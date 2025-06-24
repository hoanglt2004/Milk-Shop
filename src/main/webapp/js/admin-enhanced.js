/* ===================================================== */
/* ENHANCED ADMIN JAVASCRIPT - ANIMATION FIXES & FEATURES */
/* ===================================================== */

/**
 * Enhanced Admin Management System
 * Features: Smooth animations, responsive design, accessibility
 */
class AdminManager {
    constructor() {
        this.sidebar = null;
        this.mainContent = null;
        this.menuLinks = [];
        this.isMobile = window.innerWidth <= 768;
        this.sidebarOpen = false;
        
        this.init();
    }

    /**
     * Initialize admin system
     */
    init() {
        this.setupElements();
        this.setupEventListeners();
        this.setActiveMenuItem();
        this.setupAnimations();
        this.setupAccessibility();
        
        console.log('✅ Admin Manager initialized successfully');
    }

    /**
     * Setup DOM elements
     */
    setupElements() {
        this.sidebar = document.querySelector('.admin-sidebar, #adminSidebar');
        this.mainContent = document.querySelector('.main-content');
        this.menuLinks = document.querySelectorAll('.menu-link');
        
        // Add body class for admin pages
        document.body.classList.add('admin-page');
        
        // Setup admin container if not exists
        if (!document.querySelector('.admin-container')) {
            this.wrapAdminContainer();
        }
    }

    /**
     * Wrap content in admin container
     */
    wrapAdminContainer() {
        const body = document.body;
        const adminContainer = document.createElement('div');
        adminContainer.className = 'admin-container';
        
        // Move all body content to admin container
        while (body.firstChild) {
            adminContainer.appendChild(body.firstChild);
        }
        
        body.appendChild(adminContainer);
    }

    /**
     * Setup event listeners
     */
    setupEventListeners() {
        // Menu link clicks
        this.menuLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                this.handleMenuClick(e, link);
            });
        });

        // Responsive handling
        window.addEventListener('resize', () => {
            this.handleResize();
        });

        // Mobile menu toggle
        this.setupMobileMenu();

        // Table enhancements
        this.enhanceTables();

        // Form enhancements
        this.enhanceForms();

        // Button click effects
        this.enhanceButtons();
    }

    /**
     * Handle menu item clicks
     */
    handleMenuClick(e, clickedLink) {
        // Remove active class from all links
        this.menuLinks.forEach(link => {
            link.classList.remove('active');
        });

        // Add active class to clicked link
        clickedLink.classList.add('active');

        // Store in localStorage for persistence
        const page = clickedLink.getAttribute('data-page');
        if (page) {
            localStorage.setItem('adminActivePage', page);
        }

        // Add loading effect
        this.addLoadingEffect(clickedLink);

        // Close mobile menu if open
        if (this.isMobile && this.sidebarOpen) {
            this.closeMobileMenu();
        }
    }

    /**
     * Set active menu item based on current page
     */
    setActiveMenuItem() {
        const currentPath = window.location.pathname;
        const savedPage = localStorage.getItem('adminActivePage');
        
        let activePage = 'admin'; // default

        // Determine active page from URL
        if (currentPath.includes('adminReports') || currentPath.includes('top10') || currentPath.includes('top5khachhang')) {
            activePage = 'adminReports';
        } else if (currentPath.includes('manager') && !currentPath.includes('managerAccount') && !currentPath.includes('managerSupplier')) {
            activePage = 'manager';
        } else if (currentPath.includes('managerAccount')) {
            activePage = 'managerAccount';
        } else if (currentPath.includes('managerSupplier')) {
            activePage = 'managerSupplier';
        } else if (currentPath.includes('quanLyDanhMuc')) {
            activePage = 'quanLyDanhMuc';
        } else if (currentPath.includes('quanLyKho')) {
            activePage = 'quanLyKho';
        } else if (currentPath.includes('quanLyKhuyenMai')) {
            activePage = 'quanLyKhuyenMai';
        } else if (currentPath.includes('hoaDon') || currentPath.includes('HoaDon')) {
            activePage = 'hoaDon';
        } else if (savedPage && currentPath.includes('admin')) {
            activePage = savedPage;
        }

        // Set active menu item
        const activeLink = document.querySelector(`[data-page="${activePage}"]`);
        if (activeLink) {
            this.menuLinks.forEach(link => link.classList.remove('active'));
            activeLink.classList.add('active');
        }
    }

    /**
     * Setup smooth animations
     */
    setupAnimations() {
        // Disable all animations initially
        document.documentElement.style.setProperty('--animation-duration', '0s');
        
        // Re-enable after page load
        window.addEventListener('load', () => {
            setTimeout(() => {
                document.documentElement.style.setProperty('--animation-duration', '0.3s');
            }, 100);
        });

        // Setup intersection observer for card animations
        this.setupCardAnimations();
    }

    /**
     * Setup card entrance animations
     */
    setupCardAnimations() {
        const cards = document.querySelectorAll('.stat-card, .chart-card, .report-card');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, {
            threshold: 0.1
        });

        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = `opacity 0.3s ease ${index * 0.1}s, transform 0.3s ease ${index * 0.1}s`;
            observer.observe(card);
        });
    }

    /**
     * Handle responsive changes
     */
    handleResize() {
        const wasMobile = this.isMobile;
        this.isMobile = window.innerWidth <= 768;

        if (wasMobile !== this.isMobile) {
            if (this.isMobile) {
                this.setupMobileMode();
            } else {
                this.setupDesktopMode();
            }
        }
    }

    /**
     * Setup mobile menu functionality
     */
    setupMobileMenu() {
        if (!this.isMobile) return;

        // Create mobile menu toggle button
        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'mobile-menu-toggle';
        toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
        toggleBtn.setAttribute('aria-label', 'Toggle navigation menu');
        
        // Add to page
        document.body.appendChild(toggleBtn);

        // Toggle functionality
        toggleBtn.addEventListener('click', () => {
            this.toggleMobileMenu();
        });

        // Close on overlay click
        const overlay = document.createElement('div');
        overlay.className = 'mobile-menu-overlay';
        document.body.appendChild(overlay);

        overlay.addEventListener('click', () => {
            this.closeMobileMenu();
        });
    }

    /**
     * Toggle mobile menu
     */
    toggleMobileMenu() {
        this.sidebarOpen = !this.sidebarOpen;
        
        if (this.sidebarOpen) {
            this.openMobileMenu();
        } else {
            this.closeMobileMenu();
        }
    }

    /**
     * Open mobile menu
     */
    openMobileMenu() {
        if (this.sidebar) {
            this.sidebar.classList.add('show');
        }
        document.querySelector('.mobile-menu-overlay')?.classList.add('show');
        document.body.style.overflow = 'hidden';
        this.sidebarOpen = true;
    }

    /**
     * Close mobile menu
     */
    closeMobileMenu() {
        if (this.sidebar) {
            this.sidebar.classList.remove('show');
        }
        document.querySelector('.mobile-menu-overlay')?.classList.remove('show');
        document.body.style.overflow = '';
        this.sidebarOpen = false;
    }

    /**
     * Setup mobile mode
     */
    setupMobileMode() {
        document.body.classList.add('mobile-mode');
        this.setupMobileMenu();
    }

    /**
     * Setup desktop mode
     */
    setupDesktopMode() {
        document.body.classList.remove('mobile-mode');
        this.closeMobileMenu();
    }

    /**
     * Add loading effect to buttons
     */
    addLoadingEffect(element) {
        element.classList.add('loading');
        
        setTimeout(() => {
            element.classList.remove('loading');
        }, 1000);
    }

    /**
     * Enhance tables with sorting and filtering
     */
    enhanceTables() {
        const tables = document.querySelectorAll('.table');
        
        tables.forEach(table => {
            this.makeTableResponsive(table);
            this.addTableHoverEffects(table);
        });
    }

    /**
     * Make table responsive
     */
    makeTableResponsive(table) {
        if (!table.closest('.table-responsive')) {
            const wrapper = document.createElement('div');
            wrapper.className = 'table-responsive';
            table.parentNode.insertBefore(wrapper, table);
            wrapper.appendChild(table);
        }
    }

    /**
     * Add hover effects to tables
     */
    addTableHoverEffects(table) {
        const rows = table.querySelectorAll('tbody tr');
        
        rows.forEach(row => {
            row.addEventListener('mouseenter', () => {
                row.style.transform = 'scale(1.01)';
                row.style.zIndex = '10';
            });
            
            row.addEventListener('mouseleave', () => {
                row.style.transform = '';
                row.style.zIndex = '';
            });
        });
    }

    /**
     * Enhance forms with validation and UX improvements
     */
    enhanceForms() {
        const forms = document.querySelectorAll('form');
        
        forms.forEach(form => {
            this.addFormValidation(form);
            this.enhanceFormInputs(form);
        });
    }

    /**
     * Add form validation
     */
    addFormValidation(form) {
        const inputs = form.querySelectorAll('input, select, textarea');
        
        inputs.forEach(input => {
            input.addEventListener('blur', () => {
                this.validateInput(input);
            });
            
            input.addEventListener('input', () => {
                this.clearValidationError(input);
            });
        });

        form.addEventListener('submit', (e) => {
            if (!this.validateForm(form)) {
                e.preventDefault();
            }
        });
    }

    /**
     * Validate individual input
     */
    validateInput(input) {
        const value = input.value.trim();
        const isRequired = input.hasAttribute('required');
        
        if (isRequired && !value) {
            this.showValidationError(input, 'Trường này là bắt buộc');
            return false;
        }

        if (input.type === 'email' && value && !this.isValidEmail(value)) {
            this.showValidationError(input, 'Email không hợp lệ');
            return false;
        }

        this.clearValidationError(input);
        return true;
    }

    /**
     * Validate entire form
     */
    validateForm(form) {
        const inputs = form.querySelectorAll('input, select, textarea');
        let isValid = true;
        
        inputs.forEach(input => {
            if (!this.validateInput(input)) {
                isValid = false;
            }
        });
        
        return isValid;
    }

    /**
     * Show validation error
     */
    showValidationError(input, message) {
        input.classList.add('is-invalid');
        
        let errorElement = input.parentNode.querySelector('.error-message');
        if (!errorElement) {
            errorElement = document.createElement('div');
            errorElement.className = 'error-message text-danger small mt-1';
            input.parentNode.appendChild(errorElement);
        }
        
        errorElement.textContent = message;
    }

    /**
     * Clear validation error
     */
    clearValidationError(input) {
        input.classList.remove('is-invalid');
        const errorElement = input.parentNode.querySelector('.error-message');
        if (errorElement) {
            errorElement.remove();
        }
    }

    /**
     * Check if email is valid
     */
    isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    /**
     * Enhance form inputs
     */
    enhanceFormInputs(form) {
        const inputs = form.querySelectorAll('input, select, textarea');
        
        inputs.forEach(input => {
            // Add floating labels effect
            if (input.type !== 'checkbox' && input.type !== 'radio') {
                this.addFloatingLabel(input);
            }
        });
    }

    /**
     * Add floating label effect
     */
    addFloatingLabel(input) {
        const label = input.previousElementSibling;
        
        if (label && label.tagName === 'LABEL') {
            label.classList.add('floating-label');
            
            input.addEventListener('focus', () => {
                label.classList.add('active');
            });
            
            input.addEventListener('blur', () => {
                if (!input.value) {
                    label.classList.remove('active');
                }
            });
            
            // Check initial value
            if (input.value) {
                label.classList.add('active');
            }
        }
    }

    /**
     * Enhance buttons with ripple effects
     */
    enhanceButtons() {
        const buttons = document.querySelectorAll('.btn, .export-btn, .btn-header, button');
        
        buttons.forEach(button => {
            button.addEventListener('click', (e) => {
                this.createRippleEffect(e, button);
            });
        });
    }

    /**
     * Create ripple effect on button click
     */
    createRippleEffect(e, button) {
        const ripple = document.createElement('span');
        const rect = button.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;
        
        ripple.style.width = ripple.style.height = size + 'px';
        ripple.style.left = x + 'px';
        ripple.style.top = y + 'px';
        ripple.classList.add('ripple');
        
        button.appendChild(ripple);
        
        setTimeout(() => {
            ripple.remove();
        }, 600);
    }

    /**
     * Setup accessibility features
     */
    setupAccessibility() {
        // Add ARIA labels
        this.addAriaLabels();
        
        // Setup keyboard navigation
        this.setupKeyboardNavigation();
        
        // Add focus indicators
        this.addFocusIndicators();
    }

    /**
     * Add ARIA labels for accessibility
     */
    addAriaLabels() {
        const menuLinks = document.querySelectorAll('.menu-link');
        menuLinks.forEach(link => {
            if (!link.getAttribute('aria-label')) {
                const text = link.textContent.trim();
                link.setAttribute('aria-label', `Điều hướng đến ${text}`);
            }
        });
    }

    /**
     * Setup keyboard navigation
     */
    setupKeyboardNavigation() {
        document.addEventListener('keydown', (e) => {
            // ESC to close mobile menu
            if (e.key === 'Escape' && this.sidebarOpen) {
                this.closeMobileMenu();
            }
            
            // Alt + M to toggle mobile menu
            if (e.altKey && e.key === 'm') {
                e.preventDefault();
                this.toggleMobileMenu();
            }
        });
    }

    /**
     * Add focus indicators
     */
    addFocusIndicators() {
        const focusableElements = document.querySelectorAll('a, button, input, select, textarea');
        
        focusableElements.forEach(element => {
            element.addEventListener('focus', () => {
                element.classList.add('focused');
            });
            
            element.addEventListener('blur', () => {
                element.classList.remove('focused');
            });
        });
    }

    /**
     * Show notification
     */
    showNotification(message, type = 'success', duration = 3000) {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'}"></i>
            <span>${message}</span>
            <button class="notification-close">&times;</button>
        `;
        
        document.body.appendChild(notification);
        
        // Auto remove
        setTimeout(() => {
            notification.remove();
        }, duration);
        
        // Manual close
        notification.querySelector('.notification-close').addEventListener('click', () => {
            notification.remove();
        });
    }

    /**
     * Utility method to show loading state
     */
    showLoading(element) {
        element.classList.add('loading');
        element.disabled = true;
    }

    /**
     * Utility method to hide loading state
     */
    hideLoading(element) {
        element.classList.remove('loading');
        element.disabled = false;
    }
}

// Initialize admin manager when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    window.adminManager = new AdminManager();
});

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = AdminManager;
}