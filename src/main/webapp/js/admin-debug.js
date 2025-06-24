/* ===================================================== */
/* ADMIN DEBUG SCRIPT - FOR TROUBLESHOOTING SIDEBAR */
/* ===================================================== */

// Debug function to check admin page setup
function debugAdminPage() {
    console.log('=== ADMIN PAGE DEBUG ===');
    
    // Check body class
    const body = document.body;
    console.log('Body classes:', body.className);
    console.log('Has admin-page class:', body.classList.contains('admin-page'));
    
    // Check sidebar existence
    const sidebar = document.querySelector('.sidebar');
    console.log('Sidebar element:', sidebar);
    if (sidebar) {
        console.log('Sidebar computed styles:');
        const styles = window.getComputedStyle(sidebar);
        console.log('- Position:', styles.position);
        console.log('- Left:', styles.left);
        console.log('- Width:', styles.width);
        console.log('- Height:', styles.height);
        console.log('- Z-index:', styles.zIndex);
        console.log('- Display:', styles.display);
    }
    
    // Check main content
    const mainContent = document.querySelector('.main-content');
    console.log('Main content element:', mainContent);
    if (mainContent) {
        const styles = window.getComputedStyle(mainContent);
        console.log('Main content styles:');
        console.log('- Margin-left:', styles.marginLeft);
        console.log('- Width:', styles.width);
    }
    
    // Check menu items
    const menuItems = document.querySelectorAll('.menu-item');
    console.log('Menu items found:', menuItems.length);
    menuItems.forEach((item, index) => {
        console.log(`Menu item ${index}:`, item.textContent.trim(), 'Active:', item.classList.contains('active'));
    });
    
    // Check CSS files loading
    const cssFiles = document.querySelectorAll('link[rel="stylesheet"]');
    console.log('CSS files loaded:');
    cssFiles.forEach(link => {
        if (link.href.includes('admin')) {
            console.log('- Admin CSS:', link.href);
        }
    });
}

// Force sidebar active state function
function forceActiveSidebar() {
    console.log('Forcing sidebar active state...');
    
    // Remove all active classes
    document.querySelectorAll('.menu-item').forEach(item => {
        item.classList.remove('active');
    });
    
    // Detect current page and set active
    const path = window.location.pathname;
    let activePage = null;
    
    if (path.includes('admin') && !path.includes('adminReports')) {
        activePage = 'admin';
    } else if (path.includes('adminReports')) {
        activePage = 'adminReports';
    } else if (path.includes('hoaDon') || path.includes('HoaDon')) {
        activePage = 'hoaDon';
    } else if (path.includes('managerAccount')) {
        activePage = 'managerAccount';
    } else if (path.includes('manager') && !path.includes('managerAccount') && !path.includes('managerSupplier')) {
        activePage = 'manager';
    } else if (path.includes('quanLyDanhMuc')) {
        activePage = 'quanLyDanhMuc';
    } else if (path.includes('managerSupplier') || path.includes('NhaPhanPhoi')) {
        activePage = 'managerSupplier';
    } else if (path.includes('quanLyKhuyenMai')) {
        activePage = 'quanLyKhuyenMai';
    } else if (path.includes('quanLyKho')) {
        activePage = 'quanLyKho';
    }
    
    console.log('Detected page:', activePage);
    
    if (activePage) {
        const activeItem = document.querySelector(`.menu-item[data-page="${activePage}"]`);
        if (activeItem) {
            activeItem.classList.add('active');
            console.log('Set active:', activeItem.textContent.trim());
        }
    }
}

// Fix sidebar layout function
function fixSidebarLayout() {
    console.log('Fixing sidebar layout...');
    
    const body = document.body;
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    // Ensure admin-page class
    if (!body.classList.contains('admin-page')) {
        body.classList.add('admin-page');
        console.log('Added admin-page class to body');
    }
    
    // Force sidebar styles
    if (sidebar) {
        sidebar.style.position = 'fixed';
        sidebar.style.top = '0';
        sidebar.style.left = '0';
        sidebar.style.width = '250px';
        sidebar.style.height = '100vh';
        sidebar.style.zIndex = '9999';
        sidebar.style.backgroundColor = '#ffffff';
        sidebar.style.borderRight = '1px solid #e0e0e0';
        console.log('Applied force styles to sidebar');
    }
    
    // Force main content styles
    if (mainContent) {
        mainContent.style.marginLeft = '250px';
        mainContent.style.width = 'calc(100% - 250px)';
        mainContent.style.minHeight = '100vh';
        mainContent.style.padding = '20px';
        console.log('Applied force styles to main content');
    }
}

// Initialize debug on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log('Admin debug script loaded');
    
    // Wait a bit for all CSS to load
    setTimeout(function() {
        debugAdminPage();
        forceActiveSidebar();
        
        // Apply fixes if needed
        if (!document.body.classList.contains('admin-page')) {
            fixSidebarLayout();
        }
    }, 500);
});

// Expose functions globally for manual debugging
window.debugAdminPage = debugAdminPage;
window.forceActiveSidebar = forceActiveSidebar;
window.fixSidebarLayout = fixSidebarLayout;

// Auto-fix on window resize
window.addEventListener('resize', function() {
    setTimeout(fixSidebarLayout, 100);
}); 