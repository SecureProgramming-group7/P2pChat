P2P Chat Testing Tools
🚀Quick Start

### For Windows Users
1. **Check the System**
```
check.bat

```
2. **Test the CLI Version** (recommended to start with this)
```
cli-test.bat
```
3. **Test the GUI Version** (requires JavaFX)
```
gui-test.bat
```
### For Linux/Mac Users
1. **Test the CLI Version**
```
./cli-test.sh
```
2. **Test the GUI Version**
```
./gui-test.sh
```

📋Script Descriptions

**check.bat**
- Checks Java installation
- Checks JAR and class files
- Tests the CLI version
- Checks JavaFX availability

**cli-test.bat/.sh**
- Launches the CLI version of the P2P chat nodes
- Supports 1–3 nodes
- Does not require JavaFX, ensuring best compatibility
- Runs each node in a separate command-line window

**gui-test.bat/.sh**
- Launches the GUI version of the P2P chat nodes
- Supports 1–3 nodes
- Requires JavaFX support
- Runs each node in a separate GUI window

🎮Usage Instructions

### CLI Version Testing
1. Run `cli-test.bat`
2. Choose the number of nodes to start
3. In each command-line window, use the following commands:
   - `send Hello!` – send a group chat message
   - `status` – view connection status
   - `list` – list connected nodes
   - `quit` – exit the node

### GUI Version Testing
1. Run `gui-test.bat`
2. Choose the number of nodes to start
3. In each GUI window:
   - Send group chat messages
   - Right-click on a user in the list to start a private chat
   - Use the file transfer feature
   - Manually connect to other nodes

🔧Troubleshooting

### Script Crashes
- Run `check.bat` to check the system status
- Ensure you are running the scripts in the `testing/` directory
- Make sure the project is compiled: `mvn clean package`

### JavaFX Issues
- If the GUI version does not work, use the CLI version instead
- Install a Java distribution that includes JavaFX: https://www.azul.com/downloads/?package=jdk-fx

### Missing Files
- Ensure you are running the scripts in the `testing/` directory
- Run `mvn clean package` to recompile the project

💡Testing Recommendations

1. **First-Time Testing**: Run `check.bat` to verify the system setup
2. **Stable Testing**: Use `cli-test.bat` for basic functionality tests
3. **Comprehensive Testing**: If JavaFX is available, use `gui-test.bat` to test full features
4. **Network Testing**: Start multiple nodes to test P2P communication

📁Directory Structure

testing/
├── check.bat           # System check tool
├── cli-test.bat/.sh    # CLI version testing
├── gui-test.bat/.sh    # GUI version testing
├── README.md           # This document
├── TESTING_GUIDE.md    # Detailed testing guide
└── TROUBLESHOOTING.md  # Troubleshooting guide

🎯Testing Objectives

These scripts help verify:
- P2P network connections
- Group chat messaging
- Private messaging (GUI version)
- File transfer (GUI version)
- Node discovery and routing
- Secure encrypted communication
- Network failure recovery

