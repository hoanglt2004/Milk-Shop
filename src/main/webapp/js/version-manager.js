/**
 * CSS Version Manager - Cache Busting Utility
 * Tự động thêm version vào CSS và JS files để tránh cache issues
 * Version: 2.0.1
 */

// Current version configuration
const CSS_VERSION = "2.0.1";
const JS_VERSION = "2.0.1";

/**
 * Utility functions for version management
 */
const VersionManager = {
    
    /**
     * Get CSS URL with version parameter
     * @param {string} cssFile - CSS file path
     * @param {string} version - Version string (optional)
     * @return {string} - CSS URL with version
     */
    getCssUrl: function(cssFile, version = CSS_VERSION) {
        return cssFile + "?v=" + version;
    },
    
    /**
     * Get JS URL with version parameter
     * @param {string} jsFile - JS file path
     * @param {string} version - Version string (optional)
     * @return {string} - JS URL with version
     */
    getJsUrl: function(jsFile, version = JS_VERSION) {
        return jsFile + "?v=" + version;
    },
    
    /**
     * Dynamically load CSS with version
     * @param {string} cssFile - CSS file path
     * @param {string} version - Version string (optional)
     */
    loadCss: function(cssFile, version = CSS_VERSION) {
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.type = 'text/css';
        link.href = this.getCssUrl(cssFile, version);
        document.head.appendChild(link);
    },
    
    /**
     * Dynamically load JS with version
     * @param {string} jsFile - JS file path
     * @param {string} version - Version string (optional)
     * @param {function} callback - Callback function when loaded
     */
    loadJs: function(jsFile, version = JS_VERSION, callback = null) {
        const script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = this.getJsUrl(jsFile, version);
        if (callback) {
            script.onload = callback;
        }
        document.head.appendChild(script);
    },
    
    /**
     * Update all existing CSS links with version
     */
    updateAllCssLinks: function() {
        const links = document.querySelectorAll('link[rel="stylesheet"]');
        links.forEach(link => {
            const href = link.getAttribute('href');
            if (href && href.startsWith('css/') && !href.includes('?v=')) {
                link.href = this.getCssUrl(href);
            }
        });
    },
    
    /**
     * Update all existing JS script tags with version
     */
    updateAllJsLinks: function() {
        const scripts = document.querySelectorAll('script[src]');
        scripts.forEach(script => {
            const src = script.getAttribute('src');
            if (src && src.startsWith('js/') && !src.includes('?v=')) {
                script.src = this.getJsUrl(src);
            }
        });
    },
    
    /**
     * Force reload CSS file
     * @param {string} cssFile - CSS file path
     */
    reloadCss: function(cssFile) {
        const links = document.querySelectorAll(`link[href*="${cssFile}"]`);
        links.forEach(link => {
            const timestamp = new Date().getTime();
            const href = link.getAttribute('href').split('?')[0];
            link.href = href + "?v=" + CSS_VERSION + "&t=" + timestamp;
        });
    },
    
    /**
     * Get current version info
     */
    getVersionInfo: function() {
        return {
            css: CSS_VERSION,
            js: JS_VERSION,
            timestamp: new Date().toISOString()
        };
    }
};

// Auto-update when DOM is loaded (if enabled)
document.addEventListener('DOMContentLoaded', function() {
    // Uncomment to auto-update all links on page load
    // VersionManager.updateAllCssLinks();
    // VersionManager.updateAllJsLinks();
    
    console.log('Version Manager loaded:', VersionManager.getVersionInfo());
});

// Make it globally available
window.VersionManager = VersionManager; 