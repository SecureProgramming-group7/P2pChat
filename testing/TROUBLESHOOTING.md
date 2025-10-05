# Testing Tools Troubleshooting Guide

## 🚨 Common Issues

### Issue 1: Command window flashes and closes after double-clicking the script

**Symptoms：** After double-clicking multi-gui-test.bat, the command window flashes briefly and closes.

**Reason：** The script exits immediately upon encountering an error.

**Solution：**
1. **Use Diagnostic Tools：**
   ```cmd
   # Double-Click to Run
   test-diagnosis.bat
   ```

2. **Use the Debug Version：**
   ```cmd
   # Double-Click to Run
   multi-gui-test-debug.bat
   ```

3. **Manual Run：**
   ```cmd
   # Run in Command Prompt
   cd testing
   multi-gui-test.bat
   ```

### Issue 2: JAR File Not Found

**Error Message：** `Cannot find JAR file!`

**Solution：**
1. **Ensure the project is compiled：**
   ```cmd
   # Run in the main project directory
   mvn clean package
   ```

2. **Check the directory structure：**
   ```
   P2pChat/
   ├── testing/          ← You should be here
   └── target/
       └── p2p-chat-1.0-SNAPSHOT.jar
   ```

### Issue 3: JavaFX Unavailable

**Error Message：** `JavaFX not available!` 或 `Module javafx.controls not found`

**solution：**
1. **Check JavaFX Installation：**
   ```cmd
   ..\check-javafx.bat
   ```

2. **Install a Java Distribution that Includes JavaFX：**
   - Install：https://www.azul.com/downloads/?package=jdk-fx
   - choose "JDK FX" vision

3. **Use the CLI Version as an Alternative：**
   ```cmd
   multi-cli-test.bat
   ```

### Issue 4: GUI Window Does Not Appear

**Symptoms:** The script runs successfully, but no GUI window appears.

**solution：**
1. **Check Task Manager：**Check whether there is a Java process running.
2. **Check the firewall settings.：** Ensure that the Java program is allowed to run.
3. **Try running a single node.：**
   ```cmd
   java --module-path . --add-modules javafx.controls,javafx.fxml -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 8080
   ```

### Issue 5: Port Already in Use

**Error Message：** `Address already in use` Or similar port-related errors.

**solution：**
1. **Close other P2P Chat instances.**
2. **Use a different port：**
   ```cmd
   # Manually specify the port.
   java -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 9090
   ```
3. **Restart the computer**（If the problem persists）

## 🔧Diagnostic Tools

### 1. Basic Diagnostics
```cmd
test-diagnosis.bat
```
Check:：
- Whether the JAR file exists
- Whether Java is installed
- Whether JavaFX is available
- Whether the CLI version works

### 2. Detailed Debugging
```cmd
multi-gui-test-debug.bat
```
Provide：
- Detailed execution steps
- Error message display
- Single-node test option

### 3. JavaFX-Specific Check
```cmd
..\check-javafx.bat
```
Check：
- Java Version
- JavaFX Modules
- Compile and Run Tests

## 📋Manual Testing Steps

If all automated scripts fail, you can perform manual testing:

### 1.Test the CLI Version
```cmd
cd testing
java -cp ..\target\classes com.group7.chat.Main 8080
```

### 2. Test the GUI Version
```cmd
cd testing
java --module-path . --add-modules javafx.controls,javafx.fxml -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 8080
```

### 3. Test Multiple Nodes
```cmd
# First Command Prompt
java -cp ..\target\classes com.group7.chat.Main 8080

# Second Command Prompt
java -cp ..\target\classes com.group7.chat.Main 8081 localhost:8080
```

## 🆘 Get Help

### Collect Error Information
1. **Run Diagnostic Tools：** `test-diagnosis.bat`
2. **Capture Error Screenshots**
3. **Record the Java Version：** `java -version`
4. **Record the Operating System Version**

###Priority of Common Solutions
1. ✅ **Try First：** CLI Version Testing
2. ✅ **Then Try：** Install Java with JavaFX Support
3. ✅ **Finally Try：** Run Manually in Command Line
### Alternative Solution
If GUI testing consistently fails:
- Use multi-cli-test.bat for CLI testing
- Provides the same functionality, only with a different interface
- More stable and offers better compatibility

## 💡 Preventive Measures

1. **Ensure the Project is Compiled：** Run Before Testing `mvn clean package`
2. **Use the Correct Java Version：** Recommend Using a Java Distribution with JavaFX
3. **Run from the Correct Directory：**Ensure that scripts are run in the testing/ directory
4. **Close Other Instances：** Avoid Port Conflicts
