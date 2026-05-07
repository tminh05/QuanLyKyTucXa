// DOM Content Loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize all functionalities
    initFormValidation();
    initDatePickers();
    initTableSorting();
    initSearchHighlight();
    initAutoHideAlerts();
    initConfirmDialogs();
    initPhoneFormat();
    initTooltips();
});

// Form validation
function initFormValidation() {
    const forms = document.querySelectorAll('.form');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    showError(field, 'Trường này là bắt buộc');
                } else {
                    clearError(field);
                }
            });
            
            // Validate email
            const emailFields = form.querySelectorAll('input[type="email"]');
            emailFields.forEach(field => {
                if (field.value && !isValidEmail(field.value)) {
                    isValid = false;
                    showError(field, 'Email không hợp lệ');
                }
            });
            
            // Validate phone number
            const phoneFields = form.querySelectorAll('input[name="sdt"]');
            phoneFields.forEach(field => {
                if (field.value && !isValidPhone(field.value)) {
                    isValid = false;
                    showError(field, 'Số điện thoại không hợp lệ (10-15 số)');
                }
            });
            
            // Validate dates
            const startDate = form.querySelector('input[name="ngayBatDau"]');
            const endDate = form.querySelector('input[name="ngayKetThuc"]');
            
            if (startDate && endDate && startDate.value && endDate.value) {
                if (new Date(startDate.value) >= new Date(endDate.value)) {
                    isValid = false;
                    showError(endDate, 'Ngày kết thúc phải sau ngày bắt đầu');
                }
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    });
}

// Show error message
function showError(field, message) {
    clearError(field);
    field.style.borderColor = '#dc3545';
    
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.style.color = '#dc3545';
    errorDiv.style.fontSize = '12px';
    errorDiv.style.marginTop = '5px';
    errorDiv.textContent = message;
    
    field.parentNode.appendChild(errorDiv);
}

// Clear error message
function clearError(field) {
    field.style.borderColor = '#e0e0e0';
    const errorDiv = field.parentNode.querySelector('.error-message');
    if (errorDiv) {
        errorDiv.remove();
    }
}

// Email validation
function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Phone validation
function isValidPhone(phone) {
    const re = /^[0-9]{10,15}$/;
    return re.test(phone);
}

// Format phone number input
function initPhoneFormat() {
    const phoneInputs = document.querySelectorAll('input[name="sdt"]');
    
    phoneInputs.forEach(input => {
        input.addEventListener('input', function(e) {
            let value = this.value.replace(/[^0-9]/g, '');
            if (value.length > 15) {
                value = value.slice(0, 15);
            }
            this.value = value;
        });
    });
}

// Initialize date pickers with min/max dates
function initDatePickers() {
    const today = new Date().toISOString().split('T')[0];
    
    const startDateInputs = document.querySelectorAll('input[name="ngayBatDau"]');
    const endDateInputs = document.querySelectorAll('input[name="ngayKetThuc"]');
    
    startDateInputs.forEach(input => {
        input.setAttribute('min', today);
        
        input.addEventListener('change', function() {
            const endDateInput = this.closest('form').querySelector('input[name="ngayKetThuc"]');
            if (endDateInput) {
                endDateInput.setAttribute('min', this.value);
            }
        });
    });
    
    endDateInputs.forEach(input => {
        input.setAttribute('min', today);
    });
}

// Table sorting
function initTableSorting() {
    const tables = document.querySelectorAll('.data-table');
    
    tables.forEach(table => {
        const headers = table.querySelectorAll('th');
        
        headers.forEach((header, index) => {
            header.style.cursor = 'pointer';
            header.addEventListener('click', () => {
                sortTable(table, index);
            });
        });
    });
}

// Sort table function
function sortTable(table, column) {
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const isAscending = table.getAttribute('data-sort-order') === 'asc';
    
    rows.sort((a, b) => {
        const aValue = a.cells[column].textContent.trim();
        const bValue = b.cells[column].textContent.trim();
        
        if (!isNaN(aValue) && !isNaN(bValue)) {
            return isAscending ? aValue - bValue : bValue - aValue;
        }
        
        return isAscending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue);
    });
    
    rows.forEach(row => tbody.appendChild(row));
    table.setAttribute('data-sort-order', isAscending ? 'desc' : 'asc');
}

// Search highlight
function initSearchHighlight() {
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('keyword');
    
    if (keyword) {
        const tables = document.querySelectorAll('.data-table');
        
        tables.forEach(table => {
            const cells = table.querySelectorAll('td');
            cells.forEach(cell => {
                const text = cell.textContent;
                if (text.toLowerCase().includes(keyword.toLowerCase())) {
                    const regex = new RegExp(`(${keyword})`, 'gi');
                    cell.innerHTML = text.replace(regex, '<mark class="highlight">$1</mark>');
                }
            });
        });
    }
}

// Auto hide alerts after 5 seconds
function initAutoHideAlerts() {
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.remove();
            }, 300);
        }, 5000);
    });
}

// Confirm dialogs for delete actions
function initConfirmDialogs() {
    const deleteLinks = document.querySelectorAll('.btn-delete');
    
    deleteLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc chắn muốn thực hiện thao tác này?')) {
                e.preventDefault();
            }
        });
    });
}

// Tooltips
function initTooltips() {
    const tooltips = document.querySelectorAll('[data-tooltip]');
    
    tooltips.forEach(element => {
        element.addEventListener('mouseenter', function(e) {
            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            tooltip.textContent = this.getAttribute('data-tooltip');
            tooltip.style.position = 'absolute';
            tooltip.style.background = '#333';
            tooltip.style.color = 'white';
            tooltip.style.padding = '5px 10px';
            tooltip.style.borderRadius = '5px';
            tooltip.style.fontSize = '12px';
            tooltip.style.zIndex = '1000';
            
            document.body.appendChild(tooltip);
            
            const rect = this.getBoundingClientRect();
            tooltip.style.left = rect.left + 'px';
            tooltip.style.top = (rect.top - 30) + 'px';
            
            this.addEventListener('mouseleave', function() {
                tooltip.remove();
            });
        });
    });
}

// Export data to CSV
function exportToCSV(tableId, filename = 'export.csv') {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const rows = table.querySelectorAll('tr');
    const csv = [];
    
    rows.forEach(row => {
        const cells = row.querySelectorAll('th, td');
        const rowData = [];
        
        cells.forEach(cell => {
            let text = cell.textContent.replace(/,/g, ';');
            rowData.push(`"${text}"`);
        });
        
        csv.push(rowData.join(','));
    });
    
    const blob = new Blob([csv.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    
    link.setAttribute('href', url);
    link.setAttribute('download', filename);
    link.style.display = 'none';
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
}

// Print table
function printTable(tableId) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const printWindow = window.open('', '_blank');
    printWindow.document.write('<html><head><title>In dữ liệu</title>');
    printWindow.document.write('<style>table{border-collapse:collapse;width:100%}th,td{border:1px solid #ddd;padding:8px;text-align:left}th{background:#f2f2f2}</style>');
    printWindow.document.write('</head><body>');
    printWindow.document.write(table.outerHTML);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
}

// Filter table rows
function filterTable(tableId, searchText) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const rows = table.querySelectorAll('tbody tr');
    const text = searchText.toLowerCase();
    
    rows.forEach(row => {
        let found = false;
        const cells = row.querySelectorAll('td');
        
        cells.forEach(cell => {
            if (cell.textContent.toLowerCase().includes(text)) {
                found = true;
            }
        });
        
        row.style.display = found ? '' : 'none';
    });
}

// Live search
function initLiveSearch() {
    const searchInput = document.getElementById('liveSearch');
    const tableId = searchInput?.getAttribute('data-table');
    
    if (searchInput && tableId) {
        searchInput.addEventListener('keyup', function() {
            filterTable(tableId, this.value);
        });
    }
}

// Initialize live search
initLiveSearch();

// Toast notification
function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
        <div class="toast-content">
            <span class="toast-message">${message}</span>
        </div>
    `;
    
    toast.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === 'success' ? '#28a745' : '#dc3545'};
        color: white;
        padding: 15px 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        z-index: 9999;
        animation: slideIn 0.3s ease-out;
    `;
    
    document.body.appendChild(toast);
    
    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 3000);
}

// Add animation style
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    .highlight {
        background-color: yellow;
        padding: 0 2px;
        border-radius: 3px;
    }
    
    .error-message {
        animation: fadeIn 0.3s ease-out;
    }
`;
document.head.appendChild(style);