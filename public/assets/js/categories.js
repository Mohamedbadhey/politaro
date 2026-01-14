// ============================================
// CATEGORIES MANAGEMENT
// ============================================

let categoriesData = [];
let editingCategoryId = null;

/**
 * Load categories management page
 */
function loadCategoriesManagement() {
    const content = `
        <div class="page-header">
            <h2 data-i18n="categories_management">${t('categories_management')}</h2>
            <button class="btn btn-primary" onclick="showAddCategoryModal()">
                <i class="fas fa-plus"></i> <span data-i18n="add_category">${t('add_category')}</span>
            </button>
        </div>

        <div class="card">
            <div class="card-header">
                <h3 data-i18n="all_categories">${t('all_categories')}</h3>
                <p class="text-muted" data-i18n="manage_categories_description">${t('manage_categories_description')}</p>
            </div>
            <div class="card-body">
                <div id="categoriesTableContainer">
                    ${getLoadingHTML('loading_data')}
                </div>
            </div>
        </div>
    `;
    
    $('#pageContent').html(content);
    setPageTitle('categories_management');
    
    loadCategories();
}

/**
 * Load all categories
 */
async function loadCategories() {
    try {
        const response = await adminAPI.getCategories();
        
        if (response.status === 'success') {
            categoriesData = response.data;
            renderCategoriesTable();
        }
    } catch (error) {
        console.error('Error loading categories:', error);
        showError('Error', 'Failed to load categories');
        $('#categoriesTableContainer').html('<div class="error-message">Failed to load categories</div>');
    }
}

/**
 * Render categories table
 */
function renderCategoriesTable() {
    if (categoriesData.length === 0) {
        $('#categoriesTableContainer').html(`
            <div class="empty-state">
                <i class="fas fa-folder-open"></i>
                <h3>No Categories Found</h3>
                <p>Create your first category to get started</p>
                <button class="btn btn-primary" onclick="showAddCategoryModal()">
                    <i class="fas fa-plus"></i> Add Category
                </button>
            </div>
        `);
        return;
    }
    
    let html = `
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th data-i18n="order">${t('order')}</th>
                        <th data-i18n="name">${t('name')}</th>
                        <th data-i18n="description">${t('description')}</th>
                        <th data-i18n="color">${t('color')}</th>
                        <th data-i18n="icon">${t('icon')}</th>
                        <th data-i18n="cases">${t('cases')}</th>
                        <th data-i18n="status">${t('status')}</th>
                        <th data-i18n="actions">${t('actions')}</th>
                    </tr>
                </thead>
                <tbody id="categoriesTableBody">
    `;
    
    categoriesData.forEach((category, index) => {
        // Convert string values to proper types
        const isActive = parseInt(category.is_active) === 1 || category.is_active === 1;
        const caseCount = parseInt(category.case_count) || 0;
        
        const statusBadge = isActive
            ? '<span class="category-badge badge-success" style="display: inline-block; position: static; background-color: #28a745; color: #fff; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600;">Active</span>' 
            : '<span class="category-badge badge-secondary" style="display: inline-block; position: static; background-color: #6c757d; color: #fff; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600;">Inactive</span>';
        
        html += `
            <tr data-category-id="${category.id}">
                <td>
                    <div class="order-controls">
                        ${index > 0 ? `<button class="btn-icon" onclick="moveCategory(${category.id}, 'up')" title="Move Up"><i class="fas fa-chevron-up"></i></button>` : ''}
                        <span class="order-number">${category.display_order || index + 1}</span>
                        ${index < categoriesData.length - 1 ? `<button class="btn-icon" onclick="moveCategory(${category.id}, 'down')" title="Move Down"><i class="fas fa-chevron-down"></i></button>` : ''}
                    </div>
                </td>
                <td>
                    <strong>${escapeHtml(category.name)}</strong>
                </td>
                <td>${escapeHtml(category.description || 'N/A')}</td>
                <td>
                    <div class="color-preview" style="background-color: ${category.color};" title="${category.color}"></div>
                </td>
                <td>
                    <i class="fas ${category.icon}" style="font-size: 1.2em; color: ${category.color};"></i>
                </td>
                <td>
                    <span class="category-badge badge-info" style="display: inline-block; position: static; background-color: #17a2b8; color: #fff; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600;">${caseCount}</span>
                </td>
                <td>${statusBadge}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn-icon" onclick="viewCategoryReport(${category.id})" title="View Report">
                            <i class="fas fa-chart-pie"></i>
                        </button>
                        <button class="btn-icon" onclick="viewCategoryCases(${category.id})" title="View Cases">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button class="btn-icon" onclick="editCategory(${category.id})" title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn-icon" onclick="toggleCategoryStatus(${category.id})" title="Toggle Status">
                            <i class="fas fa-toggle-on"></i>
                        </button>
                        ${caseCount === 0 ? `
                            <button class="btn-icon btn-danger" onclick="deleteCategory(${category.id})" title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        ` : ''}
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += `
                </tbody>
            </table>
        </div>
    `;
    
    $('#categoriesTableContainer').html(html);
}

/**
 * Show add category modal
 */
function showAddCategoryModal() {
    editingCategoryId = null;
    
    const modalContent = `
        <div class="modal-header">
            <h3>Add New Category</h3>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="categoryForm" onsubmit="saveCategory(event)">
                <div class="form-group">
                    <label for="categoryName">Category Name *</label>
                    <input type="text" id="categoryName" name="name" class="form-control" required maxlength="100">
                </div>
                
                <div class="form-group">
                    <label for="categoryDescription">Description</label>
                    <textarea id="categoryDescription" name="description" class="form-control" rows="3"></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="categoryColor">Color *</label>
                        <input type="color" id="categoryColor" name="color" class="form-control" value="#3498db">
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="categoryIcon">Icon *</label>
                        <select id="categoryIcon" name="icon" class="form-control">
                            <option value="fa-folder">Folder</option>
                            <option value="fa-hand-fist">Violent</option>
                            <option value="fa-home">Property</option>
                            <option value="fa-pills">Drugs</option>
                            <option value="fa-laptop">Cyber</option>
                            <option value="fa-user-shield">Sexual Offense</option>
                            <option value="fa-child">Juvenile</option>
                            <option value="fa-gavel">Legal</option>
                            <option value="fa-car">Vehicle</option>
                            <option value="fa-fire">Arson</option>
                            <option value="fa-skull">Homicide</option>
                            <option value="fa-money-bill">Financial</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="is_active" checked> Active
                    </label>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Category
                    </button>
                </div>
            </form>
        </div>
    `;
    
    showModal(modalContent);
}

/**
 * Edit category
 */
async function editCategory(categoryId) {
    console.log('editCategory called with categoryId:', categoryId, typeof categoryId);
    console.log('categoriesData:', categoriesData);
    
    const category = categoriesData.find(c => c.id == categoryId); // Use == for type coercion
    console.log('Found category:', category);
    
    if (!category) {
        console.error('Category not found for edit! Looking for ID:', categoryId);
        return;
    }
    
    editingCategoryId = categoryId;
    console.log('Opening edit modal for category:', category.name);
    
    const modalContent = `
        <div class="modal-header">
            <h3>Edit Category</h3>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="categoryForm" onsubmit="saveCategory(event)">
                <div class="form-group">
                    <label for="categoryName">Category Name *</label>
                    <input type="text" id="categoryName" name="name" class="form-control" required maxlength="100" value="${escapeHtml(category.name)}">
                </div>
                
                <div class="form-group">
                    <label for="categoryDescription">Description</label>
                    <textarea id="categoryDescription" name="description" class="form-control" rows="3">${escapeHtml(category.description || '')}</textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="categoryColor">Color *</label>
                        <input type="color" id="categoryColor" name="color" class="form-control" value="${category.color}">
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="categoryIcon">Icon *</label>
                        <select id="categoryIcon" name="icon" class="form-control">
                            <option value="fa-folder" ${category.icon === 'fa-folder' ? 'selected' : ''}>Folder</option>
                            <option value="fa-hand-fist" ${category.icon === 'fa-hand-fist' ? 'selected' : ''}>Violent</option>
                            <option value="fa-home" ${category.icon === 'fa-home' ? 'selected' : ''}>Property</option>
                            <option value="fa-pills" ${category.icon === 'fa-pills' ? 'selected' : ''}>Drugs</option>
                            <option value="fa-laptop" ${category.icon === 'fa-laptop' ? 'selected' : ''}>Cyber</option>
                            <option value="fa-user-shield" ${category.icon === 'fa-user-shield' ? 'selected' : ''}>Sexual Offense</option>
                            <option value="fa-child" ${category.icon === 'fa-child' ? 'selected' : ''}>Juvenile</option>
                            <option value="fa-gavel" ${category.icon === 'fa-gavel' ? 'selected' : ''}>Legal</option>
                            <option value="fa-car" ${category.icon === 'fa-car' ? 'selected' : ''}>Vehicle</option>
                            <option value="fa-fire" ${category.icon === 'fa-fire' ? 'selected' : ''}>Arson</option>
                            <option value="fa-skull" ${category.icon === 'fa-skull' ? 'selected' : ''}>Homicide</option>
                            <option value="fa-money-bill" ${category.icon === 'fa-money-bill' ? 'selected' : ''}>Financial</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="is_active" ${category.is_active ? 'checked' : ''}> Active
                    </label>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Category
                    </button>
                </div>
            </form>
        </div>
    `;
    
    showModal(modalContent);
}

/**
 * Save category (create or update)
 */
async function saveCategory(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const data = {
        name: formData.get('name'),
        description: formData.get('description'),
        color: formData.get('color'),
        icon: formData.get('icon'),
        is_active: formData.get('is_active') ? 1 : 0
    };
    
    try {
        let response;
        if (editingCategoryId) {
            response = await adminAPI.updateCategory(editingCategoryId, data);
        } else {
            response = await adminAPI.createCategory(data);
        }
        
        if (response.status === 'success') {
            showSuccess('Success', response.message);
            closeModal();
            loadCategories();
        }
    } catch (error) {
        console.error('Error saving category:', error);
        showError('Error', error.response?.message || error.message || 'Failed to save category');
    }
}

/**
 * Delete category
 */
async function deleteCategory(categoryId) {
    console.log('deleteCategory called with categoryId:', categoryId);
    const category = categoriesData.find(c => c.id == categoryId); // Use == for type coercion
    if (!category) {
        console.error('Category not found for delete!');
        return;
    }
    
    const result = await Swal.fire({
        title: 'Delete Category?',
        text: `Are you sure you want to delete "${category.name}"? This action cannot be undone.`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, delete it!'
    });
    
    if (result.isConfirmed) {
        try {
            const response = await adminAPI.deleteCategory(categoryId);
            
            if (response.status === 'success') {
                showSuccess('Deleted', response.message);
                loadCategories();
            }
        } catch (error) {
            console.error('Error deleting category:', error);
            showError('Error', error.response?.message || error.message || 'Failed to delete category');
        }
    }
}

/**
 * Toggle category status
 */
async function toggleCategoryStatus(categoryId) {
    console.log('toggleCategoryStatus called with categoryId:', categoryId);
    try {
        const response = await adminAPI.toggleCategoryStatus(categoryId);
        
        if (response.status === 'success') {
            showSuccess('Success', response.message);
            loadCategories();
        }
    } catch (error) {
        console.error('Error toggling category status:', error);
        showError('Error', 'Failed to toggle category status');
    }
}

/**
 * Move category up or down
 */
async function moveCategory(categoryId, direction) {
    console.log('moveCategory called:', categoryId, direction);
    const index = categoriesData.findIndex(c => c.id == categoryId); // Use == for type coercion
    if (index === -1) {
        console.error('Category not found for move!');
        return;
    }
    
    const newIndex = direction === 'up' ? index - 1 : index + 1;
    if (newIndex < 0 || newIndex >= categoriesData.length) return;
    
    // Swap categories
    [categoriesData[index], categoriesData[newIndex]] = [categoriesData[newIndex], categoriesData[index]];
    
    // Update display order
    const orderData = categoriesData.map((cat, idx) => ({
        id: cat.id,
        order: idx + 1
    }));
    
    try {
        await adminAPI.updateCategoryOrder(orderData);
        loadCategories();
    } catch (error) {
        console.error('Error updating category order:', error);
        showError('Error', 'Failed to update category order');
        // Revert the change
        loadCategories();
    }
}

/**
 * Load cases by category (tabs view)
 */
function loadCasesByCategory() {
    const content = `
        <div class="page-header">
            <h2 data-i18n="cases_by_category">${t('cases_by_category')}</h2>
            <p class="text-muted" data-i18n="view_cases_by_category_desc">${t('view_cases_by_category_desc')}</p>
        </div>

        <div class="category-tabs-container">
            <div class="category-tabs" id="categoryTabs">
                ${getLoadingHTML('loading_data')}
            </div>
            
            <div class="category-content" id="categoryContent">
                <div class="empty-state">
                    <i class="fas fa-folder-open"></i>
                    <p data-i18n="select_category_to_view">${t('select_category_to_view')}</p>
                </div>
            </div>
        </div>
    `;
    
    $('#pageContent').html(content);
    setPageTitle('cases_by_category');
    
    loadCategoriesWithCases();
}

/**
 * Load categories and display as tabs
 */
async function loadCategoriesWithCases() {
    try {
        const response = await adminAPI.getCategories();
        
        if (response.status === 'success') {
            const categories = response.data.filter(c => c.is_active);
            renderCategoryTabs(categories);
            
            // Load first category by default
            if (categories.length > 0) {
                loadCategoryContent(categories[0].id);
            }
        }
    } catch (error) {
        console.error('Error loading categories:', error);
        showError('Error', 'Failed to load categories');
    }
}

/**
 * Render category tabs
 */
function renderCategoryTabs(categories) {
    if (categories.length === 0) {
        $('#categoryTabs').html(`
            <div class="empty-state">
                <p>No active categories found</p>
            </div>
        `);
        return;
    }
    
    let html = '<div class="tabs">';
    
    categories.forEach((category, index) => {
        html += `
            <button class="tab-btn ${index === 0 ? 'active' : ''}" 
                    data-category-id="${category.id}"
                    onclick="selectCategoryTab(${category.id})"
                    style="border-bottom: 3px solid ${category.color};">
                <i class="fas ${category.icon}" style="color: ${category.color};"></i>
                <span>${escapeHtml(category.name)}</span>
                <span class="badge" style="background-color: ${category.color};">${category.case_count || 0}</span>
            </button>
        `;
    });
    
    html += '</div>';
    
    $('#categoryTabs').html(html);
}

/**
 * Select category tab
 */
function selectCategoryTab(categoryId) {
    $('.tab-btn').removeClass('active');
    $(`.tab-btn[data-category-id="${categoryId}"]`).addClass('active');
    loadCategoryContent(categoryId);
}

/**
 * Load category content (cases)
 */
async function loadCategoryContent(categoryId) {
    $('#categoryContent').html('<div class="loading">Loading cases...</div>');
    
    try {
        const response = await adminAPI.getCategoryWithCases(categoryId);
        
        if (response.status === 'success') {
            renderCategoryCases(response.data.category, response.data.cases);
        }
    } catch (error) {
        console.error('Error loading category cases:', error);
        $('#categoryContent').html('<div class="error-message">Failed to load cases</div>');
    }
}

/**
 * Render cases for selected category
 */
function renderCategoryCases(category, cases) {
    if (cases.length === 0) {
        $('#categoryContent').html(`
            <div class="empty-state">
                <i class="fas ${category.icon}" style="color: ${category.color}; font-size: 3em;"></i>
                <h3>No cases in "${escapeHtml(category.name)}"</h3>
                <p>There are currently no cases in this category</p>
            </div>
        `);
        return;
    }
    
    let html = `
        <div class="category-header" style="border-left: 4px solid ${category.color};">
            <div>
                <h3>
                    <i class="fas ${category.icon}" style="color: ${category.color};"></i>
                    ${escapeHtml(category.name)}
                </h3>
                <p>${escapeHtml(category.description || '')}</p>
            </div>
            <div class="stats">
                <span class="stat-item">
                    <strong>${cases.length}</strong> Cases
                </span>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th data-i18n="case_number">${t('case_number')}</th>
                        <th data-i18n="ob_number">${t('ob_number')}</th>
                        <th data-i18n="crime_type">${t('crime_type')}</th>
                        <th data-i18n="incident_date">${t('incident_date')}</th>
                        <th data-i18n="status">${t('status')}</th>
                        <th data-i18n="priority">${t('priority')}</th>
                        <th data-i18n="created_by">${t('created_by')}</th>
                        <th data-i18n="actions">${t('actions')}</th>
                    </tr>
                </thead>
                <tbody>
    `;
    
    cases.forEach(caseItem => {
        const statusClass = getStatusClass(caseItem.status);
        const priorityClass = getPriorityClass(caseItem.priority);
        const status = caseItem.status || 'draft';
        const priority = caseItem.priority || 'medium';
        
        html += `
            <tr>
                <td><strong>${escapeHtml(caseItem.case_number || 'N/A')}</strong></td>
                <td>${escapeHtml(caseItem.ob_number || 'N/A')}</td>
                <td>${escapeHtml(caseItem.crime_type || 'N/A')}</td>
                <td>${formatDate(caseItem.incident_date)}</td>
                <td><span class="badge ${statusClass}">${formatStatus(status)}</span></td>
                <td><span class="badge ${priorityClass}">${formatPriority(priority)}</span></td>
                <td>${escapeHtml(caseItem.created_by_name || 'N/A')}</td>
                <td>
                    <button class="btn-icon" onclick="viewCaseDetails(${caseItem.id})" title="View Details">
                        <i class="fas fa-eye"></i>
                    </button>
                </td>
            </tr>
        `;
    });
    
    html += `
                </tbody>
            </table>
        </div>
    `;
    
    $('#categoryContent').html(html);
}

/**
 * Helper function to escape HTML
 */
function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

/**
 * Helper function to get status class
 */
function getStatusClass(status) {
    const classes = {
        'draft': 'badge-secondary',
        'submitted': 'badge-warning',
        'approved': 'badge-info',
        'assigned': 'badge-primary',
        'investigating': 'badge-primary',
        'closed': 'badge-success',
        'returned': 'badge-danger'
    };
    return classes[status] || 'badge-secondary';
}

/**
 * Helper function to get priority class
 */
function getPriorityClass(priority) {
    const classes = {
        'low': 'badge-success',
        'medium': 'badge-warning',
        'high': 'badge-danger',
        'critical': 'badge-danger'
    };
    return classes[priority] || 'badge-secondary';
}

/**
 * Helper function to format status
 */
function formatStatus(status) {
    if (!status) return 'Draft';
    return status.charAt(0).toUpperCase() + status.slice(1).replace(/_/g, ' ');
}

/**
 * Helper function to format priority
 */
function formatPriority(priority) {
    if (!priority) return 'Medium';
    return priority.charAt(0).toUpperCase() + priority.slice(1);
}

/**
 * Helper function to format date
 */
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
}

/**
 * View cases in a category (modal)
 */
async function viewCategoryCases(categoryId) {
    console.log('viewCategoryCases called with categoryId:', categoryId, typeof categoryId);
    console.log('categoriesData:', categoriesData);
    
    // Convert categoryId to string to match the data type from API
    const category = categoriesData.find(c => c.id == categoryId); // Use == for type coercion
    console.log('Found category:', category);
    
    if (!category) {
        console.error('Category not found! Looking for ID:', categoryId);
        return;
    }
    
    // Show loading modal
    const title = `<i class="fas ${category.icon}" style="color: ${category.color};"></i> ${escapeHtml(category.name)} - Cases`;
    const loadingBody = '<div class="loading">Loading cases...</div>';
    
    console.log('Calling showModal with title:', title);
    showModal(title, loadingBody, [], 'large');
    console.log('showModal called');
    
    try {
        console.log('Fetching cases for category:', categoryId);
        const response = await adminAPI.getCategoryWithCases(categoryId);
        console.log('API response:', response);
        
        if (response.status === 'success') {
            const cases = response.data.cases;
            console.log('Cases found:', cases.length);
            
            let casesHtml = '';
            
            if (cases.length === 0) {
                casesHtml = `
                    <div class="empty-state">
                        <i class="fas ${category.icon}" style="color: ${category.color}; font-size: 3em;"></i>
                        <h3>No cases in this category</h3>
                        <p>There are currently no cases in "${escapeHtml(category.name)}"</p>
                    </div>
                `;
            } else {
                casesHtml = `
                    <div style="margin-bottom: 15px;">
                        <p><strong>${cases.length}</strong> case(s) found in this category</p>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table" style="font-size: 13px;">
                            <thead>
                                <tr>
                                    <th>Case #</th>
                                    <th>OB #</th>
                                    <th>Crime Type</th>
                                    <th>Incident Date</th>
                                    <th>Status</th>
                                    <th>Priority</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                `;
                
                cases.forEach(caseItem => {
                    const statusClass = getStatusClass(caseItem.status);
                    const priorityClass = getPriorityClass(caseItem.priority);
                    const status = caseItem.status || 'draft';
                    const priority = caseItem.priority || 'medium';
                    
                    casesHtml += `
                        <tr>
                            <td><strong>${escapeHtml(caseItem.case_number || 'N/A')}</strong></td>
                            <td>${escapeHtml(caseItem.ob_number || 'N/A')}</td>
                            <td>${escapeHtml(caseItem.crime_type || 'N/A')}</td>
                            <td>${formatDate(caseItem.incident_date)}</td>
                            <td><span class="category-badge ${statusClass}" style="display: inline-block; position: static; padding: 3px 6px; border-radius: 3px; font-size: 11px;">${formatStatus(status)}</span></td>
                            <td><span class="category-badge ${priorityClass}" style="display: inline-block; position: static; padding: 3px 6px; border-radius: 3px; font-size: 11px;">${formatPriority(priority)}</span></td>
                            <td>
                                <button class="btn-icon" onclick="closeModal(); viewCaseDetails(${caseItem.id})" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </td>
                        </tr>
                    `;
                });
                
                casesHtml += `
                            </tbody>
                        </table>
                    </div>
                `;
            }
            
            const title = `<i class="fas ${category.icon}" style="color: ${category.color};"></i> ${escapeHtml(category.name)} - Cases`;
            const footerButtons = [
                { text: 'Close', class: 'btn btn-secondary', onclick: 'closeModal()' }
            ];
            
            showModal(title, casesHtml, footerButtons, 'large');
        }
    } catch (error) {
        console.error('Error loading category cases:', error);
        showError('Error', 'Failed to load cases for this category');
        closeModal();
    }
}
