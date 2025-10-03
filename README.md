# Secure P2P Chat Application

A full-featured **secure P2P chat application** built with Java and JavaFX. It supports group chat, private chat, and file transfer, with a robust security architecture and a truly distributed network design.

## 🚀 Quick Start

### Method 1: One-Click Start (Recommended)

**Windows:**

```cmd
# Smart start (automatically chooses GUI or CLI)
start.bat

# Start GUI only
start-gui-only.bat
```

**Linux/Mac:**

```bash
# Smart start (automatically chooses GUI or CLI)
./start.sh

# Start GUI only
scripts/start-gui.sh
```

> **Note:** If you see a console instead of the GUI, your Java environment is missing JavaFX support. See the JavaFX troubleshooting below.

### Method 2: Run Manually

```bash
# Build the project
mvn clean package

# Run the GUI version
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target/p2p-chat-1.0-SNAPSHOT.jar

# Or run the CLI version
java -cp target/classes com.group7.chat.Main
```

## ❌ Troubleshooting

### Issue 1: Console appears instead of GUI after startup

**Symptom:** Running `start.bat` shows a black console window instead of the graphical UI.

**Cause:** Your Java environment lacks JavaFX support, so the script falls back to the CLI version.

**Fix:** See “Issue 2: Missing JavaFX runtime components” below.

### Issue 2: Missing JavaFX runtime components

**Error message:** `Error: JavaFX runtime components are missing` or `Module javafx.controls not found`

**Fixes:**

**First, check whether JavaFX is installed:**

```cmd
# Windows
check-javafx.bat

# Linux/Mac
./check-javafx.sh
```

1. **Easiest approach (recommended):**

   * Download a JDK that includes JavaFX: [https://www.azul.com/downloads/?package=jdk-fx](https://www.azul.com/downloads/?package=jdk-fx)
   * Choose “Azul Zulu JDK FX” for your OS.
   * After installation, run `start.bat` again.

2. **Quick test (CLI only):**

   ```cmd
   # Windows
   scripts\start-cli.bat

   # Linux/Mac
   scripts/start-cli.sh
   ```

3. **Manual JavaFX installation:**

   * Download the JavaFX SDK: [https://openjfx.io/](https://openjfx.io/)
   * Extract it to a directory (e.g., `C:\javafx-sdk-17.0.2`)
   * Run:

   ```cmd
   java --module-path "C:\javafx-sdk-17.0.2\lib" --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar
   ```

### Issue 2: JAR file not found

**Error message:** `Unable to access jarfile`

**Fix:**

```bash
# Build first
mvn clean package

# Then run
start.bat  # Windows
./start.sh # Linux/Mac
```

### Issue 3: Build failure

**Fix:**

```bash
# Verify Java version
java -version  # Java 11+ required

# Clean and rebuild
mvn clean compile package
```

## 📁 Project Structure

```
P2pChat/
├── src/                          # Source code
├── target/                       # Build output
├── start.bat / start.sh          # Main startup scripts
├── scripts/                      # Additional startup scripts
│   ├── start-cli.bat/sh          # CLI version
│   ├── start-gui.bat/sh          # GUI version
│   └── start-simple.bat/sh       # Simplified version
├── testing/                      # Testing utilities
│   ├── test-launcher.bat         # Test suite main menu
│   ├── multi-gui-test.bat/sh     # Multi-GUI instance test
│   ├── multi-cli-test.bat/sh     # Multi-CLI instance test
│   └── TESTING_GUIDE.md          # Detailed testing guide
├── documentation/                # Detailed documents
│   ├── INSTALL_JAVAFX.md         # JavaFX installation guide
│   ├── SECURITY_*.md             # Security documents
│   └── PROJECT_*.md              # Project docs
└── README.md                     # This file
```

## 🎮 Usage

### Test P2P Features (Recommended First)

**Multi-GUI test (recommended):**

```cmd
# Windows — launch the test suite
testing\test-launcher.bat

# Or start the multi-GUI test directly
testing\multi-gui-test.bat

# Linux/Mac — multi-GUI test
testing/multi-gui-test.sh
```

**Multi-CLI test (no JavaFX required):**

```cmd
# Windows
testing\multi-cli-test.bat

# Linux/Mac
testing/multi-cli-test.sh
```

**Quick 3-node test:**

```cmd
# Windows
testing\quick-test.bat

# Linux/Mac
testing/quick-test.sh
```

**Manual start with custom ports:**

```cmd
# Node 1 (port 8080)
java -cp target\classes com.group7.chat.Main 8080

# Node 2 (port 8081, connect to Node 1)
java -cp target\classes com.group7.chat.Main 8081 localhost:8080

# GUI with a specific port
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8081
```

### GUI Mode

You’ll see:

* A modern chat interface
* Online members list
* Group and private chats
* File transfer
* Security/encryption status

### CLI Mode

Available commands:

* `connect <host:port>` — connect to a node
* `send <message>` — send a message
* `status` — show status
* `quit` — exit

## 🔒 Security Features

* **End-to-end encryption (E2EE):** RSA-2048 + AES-256-GCM
* **Distributed network:** Kademlia-based overlay protocol
* **Secure file transfer:** Files moved over encrypted channels
* **Forward secrecy:** Dynamic key exchange
* **Integrity checks:** Protection against tampering and replay

## 🛠️ Developer Info

### Build Requirements

* Java 11 or newer
* Maven 3.6+
* JavaFX (for GUI mode)

### Run Tests

```bash
mvn test
```

### Create a Release Build

```bash
mvn clean package
```

## 📚 Documentation

* **Installation issues:** `documentation/INSTALL_JAVAFX.md`
* **Run guide:** `documentation/RUN_GUIDE.md`
* **Security architecture:** `documentation/SECURITY_ARCHITECTURE.md`
* **Project completion report:** `documentation/PROJECT_COMPLETION_REPORT.md`

## 🔍 Security Review

This project includes **intentionally inserted security vulnerabilities** for academic study:

* Detailed analysis: `documentation/SECURITY_VULNERABILITIES_ANALYSIS.md`
* Secure protocol: `documentation/SECURE_COMMUNICATION_PROTOCOL.md`

## 📞 Support

If you run into problems:

1. Check `documentation/QUICK_FIX.md`
2. Try a different startup script
3. Verify your Java and JavaFX installation

---

**Quick start:** Double-click `start.bat` (Windows) or run `./start.sh` (Linux/Mac).
