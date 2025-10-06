package com.group7.chat;

/**
 * Address parsing test program
 */
public class AddressParsingTest {
    
    public static void main(String[] args) {
        System.out.println("=== Address Parsing Test ===");
        
        // Test various address formats
        String[] testAddresses = {
            "/127.0.0.1:8080",
            "127.0.0.1:8080", 
            "localhost:8080",
            "localhost/127.0.0.1:8080",
            "/localhost/127.0.0.1:8080",
            "//127.0.0.1:8080"
        };
        
        for (String address : testAddresses) {
            String normalized = normalizeAddress(address);
            System.out.println("Original: " + address + " -> Normalized: " + normalized);
            
            String[] parts = normalized.split(":");
            if (parts.length == 2) {
                try {
                    String host = parts[0];
                    int port = Integer.parseInt(parts[1]);
                    int fileTransferPort = port + 1000;
                    System.out.println("  Parse result: host=" + host + ", port=" + port + ", file-transfer port=" + fileTransferPort);
                } catch (NumberFormatException e) {
                    System.out.println("  Parse failed: invalid port number");
                }
            } else {
                System.out.println("  Parse failed: invalid address format");
            }
            System.out.println();
        }
    }
    
    private static String normalizeAddress(String targetAddress) {
        // Parse address and port
        String normalizedAddress = targetAddress.replace("localhost", "127.0.0.1");
        
        // Remove all leading slashes; handle formats like "/127.0.0.1:8080" or "localhost/127.0.0.1:9081"
        while (normalizedAddress.startsWith("/")) {
            normalizedAddress = normalizedAddress.substring(1);
        }
        
        // Handle complex formats such as "localhost/127.0.0.1:9081"
        if (normalizedAddress.contains("/")) {
            // Take the part after the last slash
            normalizedAddress = normalizedAddress.substring(normalizedAddress.lastIndexOf("/") + 1);
        }
        
        return normalizedAddress;
    }
}

