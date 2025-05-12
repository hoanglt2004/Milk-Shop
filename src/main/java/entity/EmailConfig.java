package entity;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class EmailConfig {
    private static final Properties properties = new Properties();
    
    static {
        try {
            // Try to load from classpath first
            InputStream input = EmailConfig.class.getClassLoader().getResourceAsStream("email.properties");
            
            // If not found in classpath, try to load from WEB-INF/classes
            if (input == null) {
                input = EmailConfig.class.getClassLoader().getResourceAsStream("/WEB-INF/classes/email.properties");
            }
            
            // If still not found, try to load from resources directory
            if (input == null) {
                input = EmailConfig.class.getClassLoader().getResourceAsStream("/resources/email.properties");
            }
            
            if (input == null) {
                throw new RuntimeException("Unable to find email.properties in any location");
            }
            
            properties.load(input);
            input.close();
        } catch (IOException e) {
            throw new RuntimeException("Error loading email.properties", e);
        }
    }
    
    public static String getEmailFrom() {
        return properties.getProperty("email.from");
    }
    
    public static String getEmailPassword() {
        return properties.getProperty("email.password");
    }
    
    public static String getEmailHost() {
        return properties.getProperty("email.host", "smtp.gmail.com");
    }
    
    public static String getEmailPort() {
        return properties.getProperty("email.port", "587");
    }
} 