# Quick Fix Guide: File Transfer Issues

## 🐛 Symptoms

You’re seeing:

```
[File Transfer] Starting to send file to broadcast (localhost/127.0.0.1:9081)
No response after sending the file
```

## 🔧 Cause

A complicated address format like `localhost/127.0.0.1:9081` leads to address-parsing failure.

## ✅ Solutions

### Method 1: Use the latest fixed version

1. **Get the latest code:**

   ```bash
   git pull origin main
   mvn clean compile
   ```

2. **Restart the nodes:**

   ```bash
   java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8080
   java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8081
   ```

### Method 2: Manual hotfix (if you can’t update)

If you can’t pull the latest code, edit `FileTransferService.java` lines 188–194:

```java
// Parse address and port
String normalizedAddress = targetAddress.replace("localhost", "127.0.0.1");

// Handle complex formats such as "localhost/127.0.0.1:9081"
if (normalizedAddress.contains("/")) {
    // Take the part after the last slash
    normalizedAddress = normalizedAddress.substring(normalizedAddress.lastIndexOf("/") + 1);
}
```

## 🚀 Verification

After applying the fix, you should see logs like:

```
[File Transfer] Broadcast mode, sending to: localhost/127.0.0.1:9081
[File Transfer] Starting to send file to broadcast (127.0.0.1:9081)
[File Transfer] Original address: localhost/127.0.0.1:9081, normalized address: 127.0.0.1:9081
[File Transfer] Parse result — host: 127.0.0.1, base port: 9081, file-transfer port: 10081
[File Transfer] File sent: filename.txt (XXX bytes)
```

## 📋 Test Steps

1. Start two nodes
2. Confirm the nodes are connected
3. Attempt a file transfer
4. Watch the console output and verify the transfer completes

The fix has been committed to GitHub; you can pull the latest version directly.

