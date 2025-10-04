# Project Structure Overview

## 📁 Directory Structure

```
P2pChat/
├── src/                                    # Source code
│   └── main/
│       ├── java/com/group7/chat/           # Java sources
│       │   ├── gui/                        # GUI components
│       │   ├── security/                   # Security module
│       │   ├── Node.java                   # P2P node implementation
│       │   ├── Message.java                # Message handling
│       │   └── ...                         # Other core files
│       └── resources/                      # Resources
│           ├── fxml/                       # JavaFX FXML views
│           └── css/                        # Stylesheets
├── target/                                  # Maven build output
│   ├── classes/                            # Compiled class files
│   ├── p2p-chat-1.0-SNAPSHOT.jar           # Executable JAR (with dependencies)
│   └── decentralized-chat-1.0-SNAPSHOT.jar # Project JAR (code only)
├── scripts/                                 # Startup scripts
│   ├── start-cli.bat/sh                     # CLI startup scripts
│   ├── start-gui.bat/sh                     # GUI startup scripts
│   ├── start-simple.bat/sh                  # Simplified startup scripts
│   └── run-with-javafx.sh                   # JavaFX-only launcher
├── documentation/                           # Project documentation
│   ├── INSTALL_JAVAFX.md                    # JavaFX installation guide
│   ├── QUICK_FIX.md                         # Quick troubleshooting
│   ├── SECURITY_ARCHITECTURE.md             # Security architecture
│   ├── SECURITY_VULNERABILITIES_ANALYSIS.md # Vulnerability analysis
│   ├── PROJECT_COMPLETION_REPORT.md         # Project completion report
│   ├── SECURE_COMMUNICATION_PROTOCOL.md     # Secure communication protocol
│   ├── DISTRIBUTED_OVERLAY_PROTOCOL.md      # Distributed overlay network protocol
│   ├── RUNNING_METHODS_COMPARISON.md        # Run-mode comparison
│   ├── JAR_FILES_EXPLANATION.md             # JAR files explained
│   └── ...                                  # Other technical docs
├── keys/                                    # Key store (generated at runtime)
├── pom.xml                                  # Maven configuration
├── start.bat                                # Main launcher (Windows)
├── start.sh                                 # Main launcher (Linux/Mac)
├── README.md                                # Project overview (this file)
└── PROJECT_STRUCTURE.md                     # Project structure notes
```

## 🎯 File Purposes

### Startup Scripts

* **`start.bat/sh`** — Main entry; automatically tries multiple run modes
* **`scripts/start-cli.*`** — CLI mode, no JavaFX required
* **`scripts/start-gui.*`** — GUI mode, requires JavaFX
* **`scripts/start-simple.*`** — Simplified mode with automatic fallback

### Core Docs

* **`README.md`** — Project overview and quick start
* **`documentation/INSTALL_JAVAFX.md`** — JavaFX troubleshooting
* **`documentation/QUICK_FIX.md`** — Common quick fixes

### Technical Docs

* **Security:** `SECURITY_*.md` — architecture, protocols, vulnerability analysis
* **Networking:** `DISTRIBUTED_OVERLAY_PROTOCOL.md` — P2P overlay implementation
* **Run Guides:** `RUNNING_METHODS_COMPARISON.md` — comparison of run modes

### Build Artifacts

* **`target/p2p-chat-1.0-SNAPSHOT.jar`** — executable JAR with all deps (8.4 MB)
* **`target/decentralized-chat-1.0-SNAPSHOT.jar`** — code-only JAR (113 KB)

## 🚀 Recommended Usage

### General Users

1. Double-click `start.bat` (Windows) or run `./start.sh` (Linux/Mac)
2. If anything goes wrong, see `documentation/QUICK_FIX.md`

### Developers

1. Browse the technical docs in `documentation/`
2. Use the dedicated launchers in `scripts/`
3. See `documentation/RUNNING_METHODS_COMPARISON.md` for mode details

### Security Researchers

1. Read `documentation/SECURITY_VULNERABILITIES_ANALYSIS.md`
2. Review `documentation/SECURE_COMMUNICATION_PROTOCOL.md`
3. Inspect code under `src/main/java/com/group7/chat/security/`

## 🧹 Housekeeping

The project structure has been streamlined:

* ✅ Removed outdated emoji-related docs
* ✅ Consolidated scattered launchers into `scripts/`
* ✅ Unified technical docs under `documentation/`
* ✅ Simplified the top-level layout
* ✅ Kept core features and key documentation

