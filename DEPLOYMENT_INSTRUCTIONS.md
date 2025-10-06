# P2P Chat — Deployment Guide

##  Latest Update (2025-09-29)

The newest code, including all file-transfer fixes, has been pushed to GitHub.

## 📋 Deployment Steps

### 1) Get the latest code

```bash
git clone https://github.com/WebProjectTest114514/P2pChat.git
cd P2pChat
```

If you already have a local copy:

```bash
git pull origin main
```

### 2) Build the project

```bash
mvn clean package -DskipTests
```

### 3) Verify required files

Make sure the following exist:

* `target/p2p-chat-1.0-SNAPSHOT.jar` (main JAR)
* `src/main/java/com/group7/chat/FileTransferService.java` (contains the fixes)
* `src/main/java/com/group7/chat/AddressParsingTest.java` (test utility)

### 4) Start the nodes

**Node 1 (port 8080):**

```bash
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target/p2p-chat-1.0-SNAPSHOT.jar 8080
```

**Node 2 (port 8081):**

```bash
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target/p2p-chat-1.0-SNAPSHOT.jar 8081
```

##  Validate the Fix

### Expected debug output

When you attempt a file transfer, you should see detailed logs like:

```
[File Transfer] Start processing file send request
[File Transfer] Target node ID: broadcast
[File Transfer] File: filename.png (12345 bytes)
[File Transfer] Save path: filename.png
[File Transfer] Broadcast mode, current connection count: 1
[File Transfer] Broadcast mode, chosen connection: localhost/127.0.0.1:9081
[File Transfer] Connected remote node ID: e5ec6c83...
[File Transfer] Original address: localhost/127.0.0.1:9081, normalized address: 127.0.0.1:9081
[File Transfer] Parse result — host: 127.0.0.1, base port: 9081, file-transfer port: 10081
[File Transfer] Preparing to connect to: 127.0.0.1:10081
[File Transfer] Sending header: SEND:transfer_xxx:filename.png:12345:filename.png
[File Transfer] Send progress: 100% (12345/12345 bytes)
[File Transfer] File sent: filename.png (12345 bytes)
```

### If you still see the old format

If you only see:

```
[File Transfer] Start sending file to broadcast (localhost/127.0.0.1:9081)
```

you’re still on an old build. Please:

1. **Confirm you pulled the latest code**
2. **Rebuild the project**
3. **Run the newly generated JAR**

##  Troubleshooting

### Issue 1: Private-chat files don’t appear on disk

* Check the program’s working directory
* Verify file system permissions
* Confirm the receiver shows the full transfer log

### Issue 2: Group-chat file transfer fails

* Ensure both nodes are connected
* Check firewall rules
* Watch the detailed debug output

### Issue 3: Still no verbose logs

* Re-clone: `git clone https://github.com/WebProjectTest114514/P2pChat.git`
* Remove old build output: `rm -rf target`
* Rebuild: `mvn clean package -DskipTests`

##  Support

If problems persist, please provide:

1. Full startup logs
2. Full logs from the file-transfer attempt
3. Your OS and Java versions

The latest code includes all fixes and should resolve the file-transfer issues.

