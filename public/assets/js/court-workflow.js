// ============================================
// COURT WORKFLOW UI FUNCTIONS
// ============================================

/**
 * Show Close Case Modal (Investigator) - Using SweetAlert
 */
async function showCloseCaseModal(caseId, caseNumber) {
    const result = await Swal.fire({
        title: `Close Case #${caseNumber}`,
        html: `
            <div style="text-align: left;">
                <div style="margin-bottom: 15px;">
                    <label for="swal-closure-reason" style="display: block; margin-bottom: 5px; font-weight: 600;">
                        Closure Reason *
                    </label>
                    <textarea 
                        id="swal-closure-reason" 
                        class="swal2-textarea" 
                        placeholder="Provide a detailed reason for closing this case (minimum 20 characters)..."
                        minlength="20"
                        required
                        rows="5"
                        style="width: 100%; padding: 10px; border: 1px solid #d0d0d0; border-radius: 4px; font-size: 14px; resize: vertical;"
                    ></textarea>
                    <small style="color: #6c757d; font-size: 12px;">Minimum 20 characters required</small>
                </div>
                
                <div style="background: #d1ecf1; border-left: 4px solid #0c5460; padding: 12px; border-radius: 4px; margin-top: 15px;">
                    <div style="display: flex; gap: 10px;">
                        <i class="fas fa-info-circle" style="color: #0c5460; margin-top: 2px;"></i>
                        <div style="font-size: 13px; color: #0c5460;">
                            <strong>Note:</strong> Closing this case will mark it as resolved. All active assignments will be completed.
                        </div>
                    </div>
                </div>
            </div>
        `,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-check-circle"></i> Close Case',
        cancelButtonText: 'Cancel',
        width: '600px',
        customClass: {
            popup: 'swal-wide'
        },
        preConfirm: () => {
            const reason = document.getElementById('swal-closure-reason').value.trim();
            if (!reason || reason.length < 20) {
                Swal.showValidationMessage('Closure reason must be at least 20 characters');
                return false;
            }
            return { reason: reason };
        }
    });
    
    if (result.isConfirmed) {
        submitCloseCase(caseId, result.value.reason);
    }
}

/**
 * Submit Close Case
 */
async function submitCloseCase(caseId, closureReason) {
    showLoading('Closing case...');
    
    try {
        const response = await investigationAPI.closeCase(caseId, closureReason);
        
        closeAlert();
        
        if (response.status === 'success') {
            await showSuccess('Case Closed', response.message || 'Case has been closed successfully');
            
            // Reload case details if modal is open
            if (window.currentCaseData && window.currentCaseData.id === caseId) {
                window.location.reload(); // Reload to update case status
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Error closing case:', error);
        await showError('Error', error.response?.message || error.message || 'Failed to close case');
    }
}

/**
 * Show Send to Court Modal (Investigator) - Using SweetAlert
 */
async function showSendToCourtModal(caseId, caseNumber) {
    const result = await Swal.fire({
        title: `Send Case #${caseNumber} to Court`,
        html: `
            <div style="text-align: left;">
                <div style="margin-bottom: 15px;">
                    <label for="swal-court-notes" style="display: block; margin-bottom: 5px; font-weight: 600;">
                        Notes for Court (Optional)
                    </label>
                    <textarea 
                        id="swal-court-notes" 
                        class="swal2-textarea" 
                        placeholder="Add any notes or comments for the court (optional)..."
                        maxlength="1000"
                        rows="4"
                        style="width: 100%; padding: 10px; border: 1px solid #d0d0d0; border-radius: 4px; font-size: 14px; resize: vertical;"
                    ></textarea>
                    <small style="color: #6c757d; font-size: 12px;">Maximum 1000 characters</small>
                </div>
                
                <div style="background: #fff3cd; border-left: 4px solid #ffc107; padding: 12px; border-radius: 4px; margin-top: 15px;">
                    <div style="display: flex; gap: 10px;">
                        <i class="fas fa-info-circle" style="color: #856404; margin-top: 2px;"></i>
                        <div style="font-size: 13px; color: #856404;">
                            <strong>Note:</strong> This case will be sent to court for review. Court users will be notified and can:
                            <ul style="margin: 8px 0 0 0; padding-left: 20px;">
                                <li>Close the case themselves</li>
                                <li>Assign it back to you with a deadline</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#007bff',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-paper-plane"></i> Send to Court',
        cancelButtonText: 'Cancel',
        width: '600px',
        customClass: {
            popup: 'swal-wide'
        },
        preConfirm: () => {
            const notes = document.getElementById('swal-court-notes').value.trim();
            return { notes: notes || null };
        }
    });
    
    if (result.isConfirmed) {
        submitSendToCourt(caseId, result.value.notes);
    }
}

/**
 * Submit Send to Court
 */
async function submitSendToCourt(caseId, courtNotes) {
    showLoading('Sending case to court...');
    
    try {
        const response = await investigationAPI.sendToCourt(caseId, courtNotes);
        
        closeAlert();
        
        if (response.status === 'success') {
            await showSuccess('Sent to Court', response.message || 'Case has been sent to court successfully');
            
            // Reload case details if modal is open
            if (window.currentCaseData && window.currentCaseData.id === caseId) {
                window.location.reload(); // Reload to update case status
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Error sending to court:', error);
        await showError('Error', error.response?.message || error.message || 'Failed to send case to court');
    }
}

/**
 * Show Court Assignment Info Badge
 */
function showCourtAssignmentBadge(caseData) {
    if (caseData.court_status === 'court_assigned_back' && caseData.court_deadline) {
        const deadline = new Date(caseData.court_deadline);
        const today = new Date();
        const daysLeft = Math.ceil((deadline - today) / (1000 * 60 * 60 * 24));
        
        let badgeClass = 'badge-info';
        let icon = 'fa-calendar';
        let statusText = '';
        
        if (daysLeft < 0) {
            badgeClass = 'badge-danger';
            icon = 'fa-exclamation-triangle';
            statusText = `OVERDUE by ${Math.abs(daysLeft)} day(s)`;
        } else if (daysLeft === 0) {
            badgeClass = 'badge-warning';
            icon = 'fa-clock';
            statusText = 'Due TODAY';
        } else if (daysLeft <= 3) {
            badgeClass = 'badge-warning';
            icon = 'fa-clock';
            statusText = `Due in ${daysLeft} day(s)`;
        } else {
            statusText = `Due in ${daysLeft} day(s)`;
        }
        
        return `
            <div class="alert alert-${badgeClass.replace('badge-', '')} mb-3">
                <i class="fas ${icon}"></i>
                <strong>Court Assignment:</strong> ${statusText}
                <br>
                <small>Deadline: ${formatDate(caseData.court_deadline)}</small>
                ${caseData.court_notes ? `<br><small>Notes: ${escapeHtml(caseData.court_notes)}</small>` : ''}
            </div>
        `;
    }
    return '';
}

/**
 * Get Court Status Badge HTML
 */
function getCourtStatusBadge(courtStatus) {
    const statusMap = {
        'not_sent': { label: 'Not Sent to Court', class: 'badge-secondary', icon: 'fa-circle' },
        'sent_to_court': { label: 'Sent to Court', class: 'badge-info', icon: 'fa-paper-plane' },
        'court_review': { label: 'Under Court Review', class: 'badge-primary', icon: 'fa-gavel' },
        'court_assigned_back': { label: 'Assigned by Court', class: 'badge-warning', icon: 'fa-redo' },
        'court_closed': { label: 'Closed by Court', class: 'badge-success', icon: 'fa-check-circle' }
    };
    
    const status = statusMap[courtStatus] || statusMap['not_sent'];
    
    return `<span class="category-badge ${status.class}" style="display: inline-block; position: static;">
        <i class="fas ${status.icon}"></i> ${status.label}
    </span>`;
}

/**
 * Format date helper
 */
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric' 
    });
}

/**
 * Escape HTML helper
 */
function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

/**
 * Show Court Close Case Modal
 */
async function showCourtCloseCaseModal(caseId, caseNumber) {
    const modalContent = `
        <div class="modal-header">
            <h3>Close Case #${caseNumber} (Court)</h3>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="courtCloseCaseForm">
                <div class="form-group">
                    <label for="courtClosureReason">Closure Reason *</label>
                    <textarea 
                        id="courtClosureReason" 
                        name="closure_reason" 
                        class="form-control" 
                        rows="5" 
                        required 
                        minlength="20"
                        placeholder="Provide a detailed reason for closing this case from court (minimum 20 characters)..."
                    ></textarea>
                    <small class="form-text text-muted">Minimum 20 characters required</small>
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <strong>Note:</strong> This will close the case permanently. The investigator who sent it will be notified.
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
            <button type="button" class="btn btn-success" onclick="submitCourtCloseCase(${caseId})">
                <i class="fas fa-check-circle"></i> Close Case
            </button>
        </div>
    `;
    
    showModal('Close Case', modalContent, [], 'medium');
}

/**
 * Submit Court Close Case
 */
async function submitCourtCloseCase(caseId) {
    const closureReason = document.getElementById('courtClosureReason').value.trim();
    
    if (!closureReason || closureReason.length < 20) {
        await showError('Validation Error', 'Closure reason must be at least 20 characters');
        return;
    }
    
    const result = await Swal.fire({
        title: 'Close This Case?',
        text: 'This will permanently close the case from court.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, Close Case',
        cancelButtonText: 'Cancel'
    });
    
    if (!result.isConfirmed) return;
    
    showLoading('Closing case...');
    
    try {
        const response = await courtAPI.closeCase(caseId, closureReason);
        
        closeModal();
        closeAlert();
        
        if (response.status === 'success') {
            await showSuccess('Case Closed', response.message || 'Case has been closed by court');
            
            // Reload court cases list
            if (typeof loadCourtCases === 'function') {
                loadCourtCases();
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Error closing case from court:', error);
        await showError('Error', error.response?.message || error.message || 'Failed to close case');
    }
}

/**
 * Show Assign to Investigator Modal
 */
async function showAssignToInvestigatorModal(caseId, caseNumber) {
    showLoading('Loading case and investigators...');
    
    try {
        // Get case details to check current investigator
        const caseResponse = await courtAPI.getCase(caseId);
        const caseData = caseResponse.status === 'success' ? caseResponse.data : null;
        
        // Get available investigators (use court API for court users)
        const investigatorsResponse = await courtAPI.getInvestigators();
        
        closeAlert();
        
        if (investigatorsResponse.status !== 'success') {
            await showError('Error', 'Failed to load investigators');
            return;
        }
        
        const investigators = investigatorsResponse.data || [];
        const currentInvestigatorId = caseData?.investigating_officer_id;
        const currentInvestigatorName = caseData?.investigating_officer_name;
        
        // Calculate default deadline (7 days from now)
        const defaultDeadline = new Date();
        defaultDeadline.setDate(defaultDeadline.getDate() + 7);
        const defaultDeadlineStr = defaultDeadline.toISOString().split('T')[0];
        
        const modalContent = `
            <div class="modal-header">
                <h3>Assign Case #${caseNumber} to Investigator</h3>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                ${currentInvestigatorId && currentInvestigatorName ? `
                    <div class="alert alert-info" style="margin-bottom: 20px;">
                        <i class="fas fa-info-circle"></i>
                        <strong>Currently Assigned:</strong> ${escapeHtml(currentInvestigatorName)}
                    </div>
                ` : ''}
                <form id="assignToInvestigatorForm">
                    <div class="form-group">
                        <label for="investigatorSelect">Select Investigator *</label>
                        <select id="investigatorSelect" name="investigator_id" class="form-control" required>
                            <option value="">-- Select Investigator --</option>
                            ${investigators.map(inv => `
                                <option value="${inv.id}" ${inv.id === currentInvestigatorId ? 'selected' : ''}>${escapeHtml(inv.full_name)} (${inv.active_cases || 0} active cases)${inv.id === currentInvestigatorId ? ' - Current' : ''}</option>
                            `).join('')}
                        </select>
                        <small class="form-text text-muted">
                            ${currentInvestigatorId ? 'You can reassign to a different investigator or keep the current one' : 'Select an investigator to assign this case to'}
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="assignmentDeadline">Deadline *</label>
                        <input 
                            type="date" 
                            id="assignmentDeadline" 
                            name="deadline" 
                            class="form-control" 
                            required
                            min="${new Date().toISOString().split('T')[0]}"
                            value="${defaultDeadlineStr}"
                        >
                        <small class="form-text text-muted">The investigator must complete the assignment by this date</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="assignmentNotes">Notes/Instructions (Optional)</label>
                        <textarea 
                            id="assignmentNotes" 
                            name="notes" 
                            class="form-control" 
                            rows="4"
                            maxlength="1000"
                            placeholder="Add any special instructions or notes for the investigator..."
                        ></textarea>
                    </div>
                    
                    <div class="alert alert-warning">
                        <i class="fas fa-info-circle"></i>
                        <strong>Note:</strong> The investigator will be notified and must investigate and close the case by the deadline.
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="submitAssignToInvestigator(${caseId})">
                    <i class="fas fa-user-tie"></i> Assign Case
                </button>
            </div>
        `;
        
        showModal('Assign to Investigator', modalContent, [], 'medium');
        
    } catch (error) {
        closeAlert();
        console.error('Error loading investigators:', error);
        await showError('Error', 'Failed to load investigators');
    }
}

/**
 * Submit Assign to Investigator
 */
async function submitAssignToInvestigator(caseId) {
    const investigatorId = document.getElementById('investigatorSelect').value;
    const deadline = document.getElementById('assignmentDeadline').value;
    const notes = document.getElementById('assignmentNotes').value.trim();
    
    if (!investigatorId) {
        await showError('Validation Error', 'Please select an investigator');
        return;
    }
    
    if (!deadline) {
        await showError('Validation Error', 'Please set a deadline');
        return;
    }
    
    const result = await Swal.fire({
        title: 'Assign Case to Investigator?',
        text: 'The investigator will be notified and must complete by the deadline.',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#007bff',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, Assign Case',
        cancelButtonText: 'Cancel'
    });
    
    if (!result.isConfirmed) return;
    
    showLoading('Assigning case...');
    
    try {
        const data = {
            investigator_id: parseInt(investigatorId),
            deadline: deadline,
            notes: notes || null
        };
        
        const response = await courtAPI.assignToInvestigator(caseId, data);
        
        closeModal();
        closeAlert();
        
        if (response.status === 'success') {
            await showSuccess('Case Assigned', response.message || 'Case has been assigned to investigator');
            
            // Reload court cases list
            if (typeof loadCourtCases === 'function') {
                loadCourtCases();
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Error assigning case:', error);
        await showError('Error', error.response?.message || error.message || 'Failed to assign case');
    }
}

/**
 * Mark Case as Under Review
 */
async function markCaseAsReview(caseId) {
    const result = await Swal.fire({
        title: 'Mark as Under Review?',
        text: 'This will update the case status to indicate court is reviewing it.',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#007bff',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, Mark as Review',
        cancelButtonText: 'Cancel'
    });
    
    if (!result.isConfirmed) return;
    
    showLoading('Updating status...');
    
    try {
        const response = await courtAPI.markAsReview(caseId);
        
        closeAlert();
        
        if (response.status === 'success') {
            await showSuccess('Status Updated', response.message || 'Case marked as under review');
            
            // Reload court cases list
            if (typeof loadCourtCases === 'function') {
                loadCourtCases();
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Error marking as review:', error);
        await showError('Error', error.response?.message || error.message || 'Failed to update status');
    }
}

/**
 * View Case History
 */
async function viewCaseHistory(caseId) {
    showLoading('Loading case history...');
    
    try {
        const response = await courtAPI.getCaseHistory(caseId);
        
        closeAlert();
        
        if (response.status === 'success') {
            const history = response.data || [];
            
            const historyHtml = history.length > 0 ? `
                <div class="timeline" style="max-height: 500px; overflow-y: auto;">
                    ${history.map(item => `
                        <div class="timeline-item" style="margin-bottom: 20px; padding-left: 30px; border-left: 3px solid #007bff; position: relative;">
                            <div style="position: absolute; left: -8px; top: 0; width: 12px; height: 12px; border-radius: 50%; background: #007bff;"></div>
                            <div style="font-weight: 600; color: #495057;">
                                ${escapeHtml(item.new_status)} 
                                ${item.new_court_status !== item.old_court_status ? `→ ${escapeHtml(item.new_court_status)}` : ''}
                            </div>
                            <div style="font-size: 0.85em; color: #6c757d; margin-top: 3px;">
                                <i class="fas fa-user"></i> ${escapeHtml(item.changed_by_name)}
                                <i class="fas fa-clock" style="margin-left: 10px;"></i> ${formatDateTime(item.changed_at)}
                            </div>
                            ${item.change_reason ? `
                                <div style="margin-top: 5px; padding: 8px; background: #f8f9fa; border-radius: 4px; font-size: 0.9em;">
                                    ${escapeHtml(item.change_reason)}
                                </div>
                            ` : ''}
                        </div>
                    `).join('')}
                </div>
            ` : '<div class="empty-state"><p>No history available</p></div>';
            
            const modalContent = `
                <div class="modal-header">
                    <h3>Case Status History</h3>
                    <button class="close-btn" onclick="closeModal()">&times;</button>
                </div>
                <div class="modal-body">
                    ${historyHtml}
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button>
                </div>
            `;
            
            showModal('Case History', modalContent, [], 'large');
        }
    } catch (error) {
        closeAlert();
        console.error('Error loading case history:', error);
        await showError('Error', 'Failed to load case history');
    }
}

/**
 * Format date time helper
 */
function formatDateTime(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleString('en-US', { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

// Export functions to global scope
window.showCloseCaseModal = showCloseCaseModal;
window.submitCloseCase = submitCloseCase;
window.showSendToCourtModal = showSendToCourtModal;
window.submitSendToCourt = submitSendToCourt;
window.showCourtAssignmentBadge = showCourtAssignmentBadge;
window.getCourtStatusBadge = getCourtStatusBadge;
window.showCourtCloseCaseModal = showCourtCloseCaseModal;
window.submitCourtCloseCase = submitCourtCloseCase;
window.showAssignToInvestigatorModal = showAssignToInvestigatorModal;
window.submitAssignToInvestigator = submitAssignToInvestigator;
window.markCaseAsReview = markCaseAsReview;
window.viewCaseHistory = viewCaseHistory;
