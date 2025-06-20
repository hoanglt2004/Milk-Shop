/**
 * Vietnamese Price Formatter
 * Formats prices with Vietnamese thousand separators
 */

/**
 * Format price with Vietnamese formatting
 * @param {number} price - Price value
 * @returns {string} Formatted price in VND
 */
function formatPriceVND(price) {
    // Format with thousand separators (dots)
    const formatted = Math.round(price).toLocaleString('de-DE');
    
    return formatted + ' VNĐ';
}

/**
 * Initialize price formatting on page load
 */
function initializePriceFormatting() {
    // Convert all existing price displays
    const priceElements = document.querySelectorAll('[data-price]');
    
    priceElements.forEach(element => {
        const price = parseFloat(element.getAttribute('data-price'));
        if (!isNaN(price)) {
            element.textContent = formatPriceVND(price);
        }
    });
}

// Auto-initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', initializePriceFormatting);

// Make function globally available
window.formatPriceVND = formatPriceVND; 