# P2P Chat App — Run Guide

## 📋 System Requirements

* Java 11 or later
* A JavaFX-capable runtime (for GUI mode)

## 🚀 Ways to Run

### Option 1: GUI Mode (Recommended)

**Windows:**

```bash
# Double-click
start-gui.bat

# Or run from terminal
java -jar ./target/p2p-chat-1.0-SNAPSHOT.jar
```

**Linux/Mac:**

```bash
# Use the startup script
./start-gui.sh

# Or run directly
java -jar ./target/p2p-chat-1.0-SNAPSHOT.jar
```

### Option 2: Command-Line Mode

**Windows:**

```bash
# Double-click
start-cli.bat

# Or run from terminal
java -cp ./target/classes com.group7.chat.Main
```

**Linux/Mac:**

```bash
# Use the startup script
start-cli.sh

# Or run directly
java -cp ./target/classes com.group7.chat.Main
```

### Option 3: Run with Maven

```bash
# Compile the project
mvn clean compile

# Run CLI
mvn exec:java -Dexec.mainClass="com.group7.chat.Main"

# Run GUI (requires JavaFX)
mvn javafx:run
```

### Option 4: Run Class Files Directly

```bash
# Compile
mvn clean compile

# Run CLI
java -cp target/classes com.group7.chat.Main

# Run GUI (requires JavaFX module path)
java --module-path /path/to/javafx/lib --add-modules javafx.controls,javafx.fxml \
     -cp target/classes com.group7.chat.gui.ChatApplication
```

## 📁 Files

* `target/p2p-chat-1.0-SNAPSHOT.jar` — executable **fat JAR** with all deps (8.8 MB) — **launches GUI**
* `target/decentralized-chat-1.0-SNAPSHOT.jar` — project classes only (115 KB)
* `start-gui.bat` / `start-gui.sh` — GUI launch scripts
* `start-cli.bat` / `start-cli.sh` — CLI launch scripts

## 🎮 Usage

### CLI Mode

After startup, you can use:

* `connect <host:port>` — connect to a node
* `send <message>` — broadcast a message to all connected nodes
* `status` — show current status
* `quit` — exit

### GUI Mode

In the GUI you can:

1. View online members
2. Send group messages
3. Start direct messages
4. Transfer files
5. View connection status

## 🔧 Troubleshooting

### “Unable to access jarfile”

1. Ensure you’re in the correct directory (the one containing `target/`).
2. Verify the JAR exists: `ls -la target/*.jar`
3. Use the correct name: `p2p-chat-1.0-SNAPSHOT.jar`

### JavaFX-related errors

1. Ensure your Java setup supports JavaFX.
2. Or use the CLI build: `java -cp target/classes com.group7.chat.Main`

### Port already in use

1. Change the default port:
   `java -jar target/p2p-chat-1.0-SNAPSHOT.jar 8081`
2. Or stop the process using that port.

## 🌐 Network Configuration

* Default listen port: **8080**
* File transfer port: **9080**
* Secure file transfer port: **10080**

Make sure your firewall allows these ports.

## 📝 Notes

1. An RSA key pair is generated on first run.
2. End-to-end encryption is supported.
3. The app uses a distributed overlay network.
4. Intentionally planted security vulnerabilities are included for learning/research.
