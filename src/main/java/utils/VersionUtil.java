package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Utility class for managing application versioning, especially for CSS cache busting
 */
public class VersionUtil {
    
    private static String cssVersion = null;
    private static final String DEFAULT_VERSION = "1.0";
    
    /**
     * Get CSS version for cache busting
     * @return version string
     */
    public static String getCSSVersion() {
        if (cssVersion == null) {
            initializeCSSVersion();
        }
        return cssVersion;
    }
    
    /**
     * Initialize CSS version from various sources
     */
    private static void initializeCSSVersion() {
        try {
            // Thử đọc từ Maven properties hoặc build info
            cssVersion = getBuildVersion();
            
            if (cssVersion == null || cssVersion.trim().isEmpty()) {
                // Fallback: sử dụng timestamp để đảm bảo không cache
                cssVersion = String.valueOf(System.currentTimeMillis() / 1000);
            }
            
        } catch (Exception e) {
            // Final fallback
            cssVersion = DEFAULT_VERSION + "." + (System.currentTimeMillis() / 1000);
        }
    }
    
    /**
     * Try to get build version from Maven properties
     * @return build version or null
     */
    private static String getBuildVersion() {
        try {
            // Đọc từ META-INF/maven properties
            InputStream inputStream = VersionUtil.class.getClassLoader()
                    .getResourceAsStream("META-INF/maven/com.quanlybansua/quanlybansua/pom.properties");
            
            if (inputStream != null) {
                Properties properties = new Properties();
                properties.load(inputStream);
                String version = properties.getProperty("version");
                if (version != null) {
                    return version;
                }
            }
        } catch (IOException e) {
            // Ignore, will use fallback
        }
        
        // Alternative: đọc từ MANIFEST.MF
        try {
            String implementationVersion = VersionUtil.class.getPackage().getImplementationVersion();
            if (implementationVersion != null) {
                return implementationVersion;
            }
        } catch (Exception e) {
            // Ignore, will use fallback
        }
        
        return null;
    }
    
    /**
     * Get full CSS URL with version parameter
     * @param cssPath relative path to CSS file
     * @return CSS URL with version parameter
     */
    public static String getVersionedCSSUrl(String cssPath) {
        return cssPath + "?v=" + getCSSVersion();
    }
} 