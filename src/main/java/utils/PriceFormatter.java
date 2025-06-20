package utils;

import java.text.DecimalFormat;

/**
 * Utility class for formatting prices to Vietnamese Dong
 */
public class PriceFormatter {
    
    // Decimal formatter for Vietnamese number format (using dots as thousand separators)
    private static final DecimalFormat VND_FORMATTER = new DecimalFormat("#,###");
    
    /**
     * Format price with Vietnamese formatting
     * @param price Price value
     * @return Formatted price string in VND
     */
    public static String formatPriceVND(double price) {
        String formatted = VND_FORMATTER.format(Math.round(price));
        // Replace commas with dots for Vietnamese format
        formatted = formatted.replace(",", ".");
        return formatted + " VNĐ";
    }
} 