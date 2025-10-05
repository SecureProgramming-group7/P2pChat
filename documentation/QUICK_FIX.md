# Quick Fix Guide

## ❌ Common Errors

### 1. Seeing encoding errors or garbled text

Your batch script may have an encoding issue.

### 2. Seeing “Module javafx.controls not found”

Your Java environment is missing the JavaFX modules.

## 🚀 Immediate Solutions

### If JavaFX modules are missing

**Easiest (recommended):**

1. Download a JDK that includes JavaFX: [https://www.azul.com/downloads/?package=jdk-fx](https://www.azul.com/downloads/?package=jdk-fx)
2. Install it, then run `start.bat` again.

**Quick test:**

```cmd
:: Run the CLI version (no JavaFX required)
start-cli.bat
```

### If JavaFX is installed but problems persist

**Method 1: Run directly from the command line**

Open Command Prompt (cmd), cd into the project directory, then run:

```cmd
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar
```

**Method 2: Use the simplified script**

Double-click: `start.bat`

**Method 3: Run the CLI version**

If the GUI still won’t launch:

```cmd
:: Compile first (if needed)
mvn clean compile

:: Then run
java -cp target\classes com.group7.chat.Main
```

Or double-click: `start-cli.bat`

## 🔧 If the `java` command doesn’t work

1. **Check if Java is installed:**

   ```cmd
   java -version
   ```

2. **If Java isn’t installed:**

   * Install Java 11 or newer.
   * Recommended: Azul Zulu JDK (with JavaFX): [https://www.azul.com/downloads/?package=jdk-fx](https://www.azul.com/downloads/?package=jdk-fx)

3. **If Java is installed but the command fails:**

   * Ensure your PATH includes the Java bin directory.
   * Restart Command Prompt.

## 📋 Full Steps

1. Download the project
2. Extract to a directory
3. Open Command Prompt
4. Go to the project folder: `cd C:\path\to\P2pChat`
5. Run:

   ```cmd
   java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar
   ```

## 💡 Still having issues?

See the detailed guide: `JAVAFX_RUNTIME_SOLUTIONS.md`
