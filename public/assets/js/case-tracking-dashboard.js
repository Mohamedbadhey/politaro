// ============================================
// Case Tracking Dashboard
// Professional dashboard for tracking assigned cases and investigators
// ============================================

let assignedCasesTable = null;
let investigatorPerformanceTable = null;

/**
 * Load Case Tracking Dashboard
 */
async function loadCaseTrackingDashboard() {
    const t = window.LanguageManager ? LanguageManager.t.bind(LanguageManager) : (key) => key;
    
    $('#pageTitle').text(t('case_tracking') || 'Case Tracking');
    const content = $('#pageContent');
    
    content.html(`
        <div class="page-header">
            <h2><i class="fas fa-tasks"></i> <span data-i18n="case_tracking">Case Tracking Dashboard</span></h2>
            <p data-i18n="case_tracking_desc">Monitor assigned cases and investigator performance</p>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card stat-total">
                <div class="stat-icon"><i class="fas fa-briefcase"></i></div>
                <div class="stat-content">
                    <div class="stat-value" id="totalAssignedCases">0</div>
                    <div class="stat-label">Total Assigned</div>
                </div>
            </div>
            
            <div class="stat-card stat-active">
                <div class="stat-icon"><i class="fas fa-spinner"></i></div>
                <div class="stat-content">
                    <div class="stat-value" id="activeCases">0</div>
                    <div class="stat-label">In Progress</div>
                </div>
            </div>
            
            <div class="stat-card stat-overdue">
                <div class="stat-icon"><i class="fas fa-exclamation-triangle"></i></div>
                <div class="stat-content">
                    <div class="stat-value" id="overdueCases">0</div>
                    <div class="stat-label">Overdue</div>
                </div>
            </div>
            
            <div class="stat-card stat-completed">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-content">
                    <div class="stat-value" id="completedCases">0</div>
                    <div class="stat-label">Completed</div>
                </div>
            </div>
        </div>
        
        <!-- Charts Row -->
        <div class="charts-row">
            <div class="chart-card">
                <div class="card-header">
                    <h3>Case Status Distribution</h3>
                </div>
                <div class="card-body">
                    <canvas id="caseStatusChart" height="200"></canvas>
                </div>
            </div>
            
            <div class="chart-card">
                <div class="card-header">
                    <h3>Cases by Priority</h3>
                </div>
                <div class="card-body">
                    <canvas id="priorityChart" height="200"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Assigned Cases Table -->
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list"></i> Assigned Cases</h3>
                <div class="card-actions">
                    <button class="btn btn-sm btn-primary" onclick="refreshCaseTracking()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="assignedCasesTable" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Case Number</th>
                                <th>Crime Type</th>
                                <th>Priority</th>
                                <th>Lead Investigator</th>
                                <th>Team Size</th>
                                <th>Assigned Date</th>
                                <th>Deadline</th>
                                <th>Days Left</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- DataTable will populate this -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Investigator Performance Table -->
        <div class="card" style="margin-top: 20px;">
            <div class="card-header">
                <h3><i class="fas fa-user-tie"></i> Investigator Performance</h3>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="investigatorPerformanceTable" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Investigator</th>
                                <th>Active Cases</th>
                                <th>Completed Cases</th>
                                <th>Overdue</th>
                                <th>Avg. Completion Time</th>
                                <th>Success Rate</th>
                                <th>Workload</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- DataTable will populate this -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    `);
    
    // Load data
    await loadCaseTrackingData();
}

/**
 * Load case tracking data
 */
async function loadCaseTrackingData() {
    try {
        // Fetch assigned cases
        const casesResponse = await api.get('/station/cases/assigned-tracking');
        
        if (casesResponse.status === 'success') {
            const cases = casesResponse.data || [];
            
            // Update statistics
            updateStatistics(cases);
            
            // Update charts
            updateCharts(cases);
            
            // Initialize assigned cases table
            initializeAssignedCasesTable(cases);
        }
        
        // Fetch investigator performance
        const performanceResponse = await api.get('/station/investigators/performance');
        
        if (performanceResponse.status === 'success') {
            const investigators = performanceResponse.data || [];
            initializeInvestigatorTable(investigators);
        }
        
    } catch (error) {
        console.error('Error loading case tracking data:', error);
        await Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Failed to load tracking data. Please refresh the page.',
            confirmButtonColor: '#ef4444'
        });
    }
}

/**
 * Update statistics cards
 */
function updateStatistics(cases) {
    const now = new Date();
    
    const stats = {
        total: cases.length,
        active: cases.filter(c => ['assigned', 'investigating'].includes(c.status)).length,
        overdue: cases.filter(c => {
            if (!c.deadline) return false;
            return new Date(c.deadline) < now && !['closed', 'archived'].includes(c.status);
        }).length,
        completed: cases.filter(c => ['closed', 'archived'].includes(c.status)).length
    };
    
    $('#totalAssignedCases').text(stats.total);
    $('#activeCases').text(stats.active);
    $('#overdueCases').text(stats.overdue);
    $('#completedCases').text(stats.completed);
    
    // Add pulse animation for overdue if > 0
    if (stats.overdue > 0) {
        $('.stat-overdue').addClass('pulse');
    }
}

/**
 * Update charts
 */
function updateCharts(cases) {
    // Status distribution chart
    const statusCounts = {};
    cases.forEach(c => {
        statusCounts[c.status] = (statusCounts[c.status] || 0) + 1;
    });
    
    const statusChart = new Chart(document.getElementById('caseStatusChart'), {
        type: 'doughnut',
        data: {
            labels: Object.keys(statusCounts).map(s => formatStatus(s)),
            datasets: [{
                data: Object.values(statusCounts),
                backgroundColor: [
                    '#3b82f6', // assigned
                    '#f59e0b', // investigating
                    '#10b981', // evidence_collected
                    '#8b5cf6', // under_review
                    '#6b7280'  // other
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
    
    // Priority distribution chart
    const priorityCounts = {
        critical: 0,
        high: 0,
        medium: 0,
        low: 0
    };
    
    cases.forEach(c => {
        priorityCounts[c.priority] = (priorityCounts[c.priority] || 0) + 1;
    });
    
    const priorityChart = new Chart(document.getElementById('priorityChart'), {
        type: 'bar',
        data: {
            labels: ['Critical', 'High', 'Medium', 'Low'],
            datasets: [{
                label: 'Cases',
                data: [priorityCounts.critical, priorityCounts.high, priorityCounts.medium, priorityCounts.low],
                backgroundColor: [
                    '#ef4444', // critical
                    '#f59e0b', // high
                    '#3b82f6', // medium
                    '#6b7280'  // low
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });
}

/**
 * Initialize assigned cases table
 */
function initializeAssignedCasesTable(cases) {
    if (assignedCasesTable) {
        assignedCasesTable.destroy();
    }
    
    assignedCasesTable = $('#assignedCasesTable').DataTable({
        data: cases,
        order: [[7, 'asc']], // Order by days left (ascending - urgent first)
        pageLength: 25,
        responsive: true,
        columns: [
            {
                data: 'case_number',
                render: function(data, type, row) {
                    return `<strong>${data}</strong>`;
                }
            },
            { data: 'crime_type' },
            {
                data: 'priority',
                render: function(data) {
                    return getPriorityBadge(data);
                }
            },
            {
                data: 'lead_investigator_name',
                render: function(data) {
                    return data || 'N/A';
                }
            },
            {
                data: 'team_size',
                render: function(data) {
                    return `<span class="badge badge-info">${data} ${data === 1 ? 'investigator' : 'investigators'}</span>`;
                }
            },
            {
                data: 'assigned_at',
                render: function(data) {
                    return data ? new Date(data).toLocaleDateString() : 'N/A';
                }
            },
            {
                data: 'deadline',
                render: function(data) {
                    return data ? new Date(data).toLocaleDateString() : 'No deadline';
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    if (!row.deadline) return 'N/A';
                    const daysLeft = calculateDaysLeft(row.deadline);
                    return getDaysLeftBadge(daysLeft);
                }
            },
            {
                data: 'status',
                render: function(data) {
                    return getStatusBadge(data);
                }
            },
            {
                data: null,
                orderable: false,
                render: function(data, type, row) {
                    return `
                        <div class="action-buttons">
                            <button class="btn btn-sm btn-primary" onclick="viewCaseDetails(${row.id})" title="View Details">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm btn-info" onclick="viewCaseTeam(${row.id})" title="View Team">
                                <i class="fas fa-users"></i>
                            </button>
                            <button class="btn btn-sm btn-warning" onclick="updateDeadline(${row.id})" title="Update Deadline">
                                <i class="fas fa-calendar"></i>
                            </button>
                        </div>
                    `;
                }
            }
        ]
    });
}

/**
 * Initialize investigator performance table
 */
function initializeInvestigatorTable(investigators) {
    if (investigatorPerformanceTable) {
        investigatorPerformanceTable.destroy();
    }
    
    investigatorPerformanceTable = $('#investigatorPerformanceTable').DataTable({
        data: investigators,
        order: [[1, 'desc']], // Order by active cases (descending)
        pageLength: 10,
        responsive: true,
        columns: [
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <div class="investigator-info">
                            <strong>${row.full_name}</strong>
                            <div style="font-size: 0.85em; color: #666;">${row.badge_number || ''}</div>
                        </div>
                    `;
                }
            },
            {
                data: 'active_cases',
                render: function(data) {
                    return `<span class="badge badge-primary">${data}</span>`;
                }
            },
            {
                data: 'completed_cases',
                render: function(data) {
                    return `<span class="badge badge-success">${data}</span>`;
                }
            },
            {
                data: 'overdue_cases',
                render: function(data) {
                    return data > 0 
                        ? `<span class="badge badge-danger">${data}</span>`
                        : `<span class="badge badge-secondary">0</span>`;
                }
            },
            {
                data: 'avg_completion_days',
                render: function(data) {
                    return data ? `${Math.round(data)} days` : 'N/A';
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    const total = row.completed_cases + (row.failed_cases || 0);
                    if (total === 0) return 'N/A';
                    const rate = Math.round((row.completed_cases / total) * 100);
                    return getSuccessRateBadge(rate);
                }
            },
            {
                data: 'active_cases',
                render: function(data) {
                    return getWorkloadBadge(data);
                }
            },
            {
                data: null,
                orderable: false,
                render: function(data, type, row) {
                    return `
                        <div class="action-buttons">
                            <button class="btn btn-sm btn-info" onclick="viewInvestigatorCases(${row.id})" title="View Cases">
                                <i class="fas fa-folder-open"></i>
                            </button>
                            <button class="btn btn-sm btn-primary" onclick="viewInvestigatorProfile(${row.id})" title="View Profile">
                                <i class="fas fa-user"></i>
                            </button>
                        </div>
                    `;
                }
            }
        ]
    });
}

/**
 * Calculate days left until deadline
 */
function calculateDaysLeft(deadline) {
    const now = new Date();
    const deadlineDate = new Date(deadline);
    const diffTime = deadlineDate - now;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
}

/**
 * Get days left badge
 */
function getDaysLeftBadge(days) {
    if (days < 0) {
        return `<span class="badge badge-danger"><i class="fas fa-exclamation-triangle"></i> ${Math.abs(days)} days overdue</span>`;
    } else if (days === 0) {
        return `<span class="badge badge-warning"><i class="fas fa-clock"></i> Due today</span>`;
    } else if (days <= 3) {
        return `<span class="badge badge-warning">${days} days left</span>`;
    } else if (days <= 7) {
        return `<span class="badge badge-info">${days} days left</span>`;
    } else {
        return `<span class="badge badge-success">${days} days left</span>`;
    }
}

/**
 * Get success rate badge
 */
function getSuccessRateBadge(rate) {
    let color = 'secondary';
    if (rate >= 90) color = 'success';
    else if (rate >= 70) color = 'primary';
    else if (rate >= 50) color = 'warning';
    else color = 'danger';
    
    return `<span class="badge badge-${color}">${rate}%</span>`;
}

/**
 * Get workload badge
 */
function getWorkloadBadge(activeCases) {
    if (activeCases === 0) {
        return `<span class="badge badge-secondary">Available</span>`;
    } else if (activeCases <= 2) {
        return `<span class="badge badge-success">Light</span>`;
    } else if (activeCases <= 5) {
        return `<span class="badge badge-primary">Moderate</span>`;
    } else if (activeCases <= 8) {
        return `<span class="badge badge-warning">Heavy</span>`;
    } else {
        return `<span class="badge badge-danger">Overloaded</span>`;
    }
}

/**
 * Format status for display
 */
function formatStatus(status) {
    return status.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
}

/**
 * Refresh case tracking data
 */
async function refreshCaseTracking() {
    await loadCaseTrackingData();
    await Swal.fire({
        icon: 'success',
        title: 'Refreshed!',
        text: 'Case tracking data has been updated',
        confirmButtonColor: '#10b981',
        timer: 1500,
        showConfirmButton: false
    });
}

/**
 * View case team
 */
async function viewCaseTeam(caseId) {
    try {
        const response = await api.get(`/station/cases/${caseId}/team`);
        
        if (response.status === 'success') {
            const team = response.data || [];
            
            let teamHtml = '<div class="team-list">';
            team.forEach(member => {
                const leadBadge = member.is_lead_investigator ? '<span class="badge badge-warning">Lead</span>' : '';
                teamHtml += `
                    <div class="team-member">
                        <strong>${member.full_name}</strong> ${leadBadge}
                        <div style="font-size: 0.9em; color: #666;">Badge: ${member.badge_number}</div>
                        <div style="font-size: 0.9em; color: #666;">Phone: ${member.phone || 'N/A'}</div>
                    </div>
                `;
            });
            teamHtml += '</div>';
            
            await Swal.fire({
                title: 'Investigation Team',
                html: teamHtml,
                width: '600px',
                confirmButtonColor: '#3b82f6'
            });
        }
    } catch (error) {
        console.error('Error loading team:', error);
        showToast('error', 'Failed to load team information');
    }
}

/**
 * Update deadline
 */
async function updateDeadline(caseId) {
    const { value: deadline } = await Swal.fire({
        title: 'Update Deadline',
        html: `
            <input type="date" id="deadline-input" class="swal2-input" min="${new Date().toISOString().split('T')[0]}">
        `,
        focusConfirm: false,
        showCancelButton: true,
        confirmButtonText: 'Update',
        confirmButtonColor: '#3b82f6',
        preConfirm: () => {
            const deadline = document.getElementById('deadline-input').value;
            if (!deadline) {
                Swal.showValidationMessage('Please select a deadline');
            }
            return deadline;
        }
    });
    
    if (deadline) {
        try {
            const response = await api.post(`/station/cases/${caseId}/deadline`, { deadline });
            
            if (response.status === 'success') {
                await Swal.fire({
                    icon: 'success',
                    title: 'Updated!',
                    text: 'Deadline has been updated successfully',
                    confirmButtonColor: '#10b981'
                });
                await loadCaseTrackingData();
            }
        } catch (error) {
            console.error('Error updating deadline:', error);
            await Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Failed to update deadline',
                confirmButtonColor: '#ef4444'
            });
        }
    }
}

/**
 * View investigator cases
 */
async function viewInvestigatorCases(investigatorId) {
    // Navigate to a filtered view or show modal with investigator's cases
    loadPage('investigator-cases', { investigatorId });
}

/**
 * View investigator profile
 */
async function viewInvestigatorProfile(investigatorId) {
    // Navigate to investigator profile page
    loadPage('investigator-profile', { investigatorId });
}
