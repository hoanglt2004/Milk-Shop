/**
 * Vietnamese Price Formatter
 * Converts USD prices to VND and formats with thousand separators
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
 * Format discounted price
 * @param {number} price - Original price
 * @param {number} discountPercent - Discount percentage (0.1 for 10%)
 * @returns {string} Formatted discounted price in VND
 */
function formatDiscountPriceVND(price, discountPercent) {
    const discountedPrice = price * (1 - discountPercent);
    return formatPriceVND(discountedPrice);
}

/**
 * Initialize price formatting on page load
 */
function initializePriceFormatting() {
    // Convert all existing price displays
    const priceElements = document.querySelectorAll('[data-price]');
    
    priceElements.forEach(element => {
        const usdPrice = parseFloat(element.getAttribute('data-price'));
        if (!isNaN(usdPrice)) {
            element.textContent = formatPriceVND(usdPrice);
        }
    });
    
    // Convert discount prices
    const discountElements = document.querySelectorAll('[data-discount-price]');
    
    discountElements.forEach(element => {
        const usdPrice = parseFloat(element.getAttribute('data-discount-price'));
        const discount = parseFloat(element.getAttribute('data-discount')) || 0.1;
        
        if (!isNaN(usdPrice)) {
            element.textContent = formatDiscountPriceVND(usdPrice, discount);
        }
    });
}

// Auto-initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', initializePriceFormatting);

// Make functions globally available
window.formatPriceVND = formatPriceVND;
window.formatDiscountPriceVND = formatDiscountPriceVND; 