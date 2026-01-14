// ============================================
// Investigator Assignment Functions
// ============================================

// Show Assign Investigator Modal with availability indicators
async function showAssignInvestigatorModal(caseId, caseNumber) {
    // Load available investigators from the center
    let investigatorsHtml = '<option value="">Select Investigator</option>';
    let investigators = [];
    
    try {
        const response = await stationAPI.getAvailableInvestigators();
        if (response.status === 'success') {
            investigators = response.data;
            
            // Build options with availability indicators
            investigatorsHtml += investigators.map(inv => {
                const availabilityIcon = inv.is_available ? '&#10003;' : '&#9888;'; // checkmark or warning
                const availabilityText = inv.is_available ? 'Available' : 'Busy';
                const activeCases = inv.active_cases;
                
                return `<option value="${inv.id}" data-available="${inv.is_available}" data-cases="${activeCases}">
                    ${availabilityIcon} ${inv.full_name} - ${inv.badge_number || 'N/A'} (${activeCases} case${activeCases !== 1 ? 's' : ''} - ${availabilityText})
                </option>`;
            }).join('');
        }
    } catch (error) {
        console.error('Failed to load investigators:', error);
        investigatorsHtml += '<option value="" disabled>Error loading investigators</option>';
    }
    
    const bodyHtml = `
        <form id="assignInvestigatorForm">
            <div class="form-group">
                <label><strong>Case:</strong> ${caseNumber}</label>
            </div>
            
            <div class="form-group">
                <label>Select Investigator *</label>
                <select name="user_id" id="investigatorSelect" required onchange="showInvestigatorDetails(this.value)">
                    ${investigatorsHtml}
                </select>
                <small style="color: #6b7280; display: block; margin-top: 5px;">
                    <i class="fas fa-info-circle"></i> Only investigators from your center are shown. &#10003; = Available (0-4 cases) | &#9888; = Busy (5+ cases)
                </small>
            </div>
            
            <div id="investigatorDetails" style="display: none; padding: 15px; background: #f9fafb; border-radius: 8px; margin-bottom: 15px;">
                <h4 style="margin: 0 0 10px 0; color: #374151;">Investigator Details</h4>
                <div id="investigatorDetailsContent"></div>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" name="is_lead_investigator"> Assign as Lead Investigator
                </label>
            </div>
            
            <div class="form-group">
                <label>Assignment Notes</label>
                <textarea name="assignment_notes" rows="3" placeholder="Special instructions or notes for this assignment..."></textarea>
            </div>
        </form>
        
        <style>
            #investigatorSelect option[data-available="true"] {
                color: #059669;
                font-weight: 500;
            }
            #investigatorSelect option[data-available="false"] {
                color: #f59e0b;
            }
        </style>
    `;
    
    showModal('Assign Investigator to Case', bodyHtml, [
        { text: 'Cancel', class: 'btn btn-secondary', onclick: 'closeModal()' },
        { text: 'Assign', class: 'btn btn-primary', onclick: `submitAssignInvestigator(${caseId})` }
    ]);
    
    // Store investigators data for details view
    window.investigatorsData = investigators;
}

// Submit Assignment - Updated to use correct endpoint
async function submitAssignInvestigator(caseId) {
    const form = $('#assignInvestigatorForm')[0];
    
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    const formData = new FormData(form);
    const investigatorId = formData.get('user_id');
    const isLeadInvestigator = formData.get('is_lead_investigator') ? 1 : 0;
    
    // The assignInvestigators endpoint expects investigator_ids array and lead_investigator_id
    const data = {
        investigator_ids: [investigatorId],
        lead_investigator_id: investigatorId,
        deadline: null // Optional: can add deadline field to form
    };
    
    try {
        showLoading('Assigning Investigator', 'Please wait...');
        const response = await stationAPI.assignInvestigators(caseId, data);
        
        closeAlert();
        if (response.status === 'success') {
            await showSuccess('Success!', 'Investigator assigned successfully!');
            closeModal();
            // Reload the page that called this modal
            if (typeof loadAssignmentsTable === 'function') {
                loadAssignmentsTable();
            } else if (typeof loadAllCasesTable === 'function') {
                loadAllCasesTable();
            }
        }
    } catch (error) {
        closeAlert();
        console.error('Assignment error:', error);
        
        if (error.status === 400 && error.response && error.response.messages) {
            const messages = error.response.messages;
            let errorText = '';
            
            if (typeof messages === 'object') {
                errorText = Object.values(messages).join('\n');
            } else {
                errorText = messages;
            }
            
            await Swal.fire({
                icon: 'error',
                title: 'Assignment Failed',
                html: errorText.replace(/\n/g, '<br>'),
                confirmButtonColor: '#ef4444'
            });
        } else {
            await showError('Error', 'Failed to assign investigator: ' + error.message);
        }
    }
}

// Show investigator workload details when selected
async function showInvestigatorDetails(investigatorId) {
    const detailsDiv = $('#investigatorDetails');
    const contentDiv = $('#investigatorDetailsContent');
    
    if (!investigatorId) {
        detailsDiv.hide();
        return;
    }
    
    detailsDiv.show();
    contentDiv.html('<p><i class="fas fa-spinner fa-spin"></i> Loading details...</p>');
    
    try {
        const response = await stationAPI.getInvestigatorWorkload(investigatorId);
        if (response.status === 'success') {
            const inv = response.data.investigator;
            const workload = response.data.workload;
            const cases = response.data.active_cases;
            
            const statusColor = workload.availability_status === 'available' ? '#059669' : '#f59e0b';
            const statusIcon = workload.availability_status === 'available' ? 'check-circle' : 'exclamation-triangle';
            
            let html = `
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 10px; margin-bottom: 15px;">
                    <div style="background: white; padding: 10px; border-radius: 6px; border-left: 3px solid ${statusColor};">
                        <div style="font-size: 12px; color: #6b7280; text-transform: uppercase;">Status</div>
                        <div style="font-size: 16px; font-weight: 600; color: ${statusColor};">
                            <i class="fas fa-${statusIcon}"></i> ${workload.availability_status}
                        </div>
                    </div>
                    <div style="background: white; padding: 10px; border-radius: 6px;">
                        <div style="font-size: 12px; color: #6b7280; text-transform: uppercase;">Active Cases</div>
                        <div style="font-size: 16px; font-weight: 600; color: #374151;">${workload.total_cases}</div>
                    </div>
                    <div style="background: white; padding: 10px; border-radius: 6px;">
                        <div style="font-size: 12px; color: #6b7280; text-transform: uppercase;">Overdue</div>
                        <div style="font-size: 16px; font-weight: 600; color: ${workload.overdue_cases > 0 ? '#ef4444' : '#374151'};">
                            ${workload.overdue_cases}
                        </div>
                    </div>
                    <div style="background: white; padding: 10px; border-radius: 6px;">
                        <div style="font-size: 12px; color: #6b7280; text-transform: uppercase;">Urgent</div>
                        <div style="font-size: 16px; font-weight: 600; color: ${workload.urgent_cases > 0 ? '#f59e0b' : '#374151'};">
                            ${workload.urgent_cases}
                        </div>
                    </div>
                </div>
            `;
            
            if (cases.length > 0) {
                html += '<div style="font-size: 13px; color: #6b7280; margin-bottom: 8px;">Current Cases:</div>';
                html += '<div style="max-height: 150px; overflow-y: auto;">';
                cases.forEach(c => {
                    const deadlineColor = c.deadline && new Date(c.deadline) < new Date() ? '#ef4444' : '#6b7280';
                    html += `
                        <div style="font-size: 12px; padding: 6px; background: white; margin-bottom: 4px; border-radius: 4px; display: flex; justify-content: space-between;">
                            <span><strong>${c.case_number}</strong> - ${c.crime_type}</span>
                            <span style="color: ${deadlineColor};">
                                ${c.deadline ? new Date(c.deadline).toLocaleDateString() : 'No deadline'}
                                ${c.is_lead_investigator ? ' (Lead)' : ''}
                            </span>
                        </div>
                    `;
                });
                html += '</div>';
            } else {
                html += '<div style="font-size: 13px; color: #6b7280; font-style: italic;">No active cases</div>';
            }
            
            contentDiv.html(html);
        }
    } catch (error) {
        console.error('Failed to load investigator details:', error);
        contentDiv.html('<p style="color: #ef4444;"><i class="fas fa-exclamation-triangle"></i> Failed to load details</p>');
    }
}
