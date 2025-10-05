# Run Modes — Comparison Guide

## 🤔 Why did `mvn javafx:run` work before?

Great question! Here’s how each run mode works and how they differ.

## 🔍 Three Ways to Run

### 1) `mvn javafx:run` (JavaFX Maven Plugin)

**How it works:**

```bash
mvn clean compile
mvn javafx:run
```

**What happens under the hood:**

1. Maven compiles sources to `target/classes`.
2. The JavaFX plugin fetches the JavaFX runtime.
3. The plugin sets the correct module path and JVM args.
4. It launches the specified main class.

**Pros:**

* ✅ JavaFX dependencies handled automatically
* ✅ Module path set for you
* ✅ Convenient during development
* ✅ No need to package a JAR

**Cons:**

* ❌ Requires Maven
* ❌ Needs internet for dependency downloads
* ❌ May fail on servers (no GUI)
* ❌ Not ideal for end users

---

### 2) `java -jar p2p-chat-1.0-SNAPSHOT.jar` (Fat JAR)

**How it works:**

```bash
mvn clean package
java -jar target/p2p-chat-1.0-SNAPSHOT.jar
```

**What happens under the hood:**

1. Maven Shade Plugin bundles all dependencies into one JAR.
2. `MANIFEST.MF` sets the correct Main-Class.
3. You can run it directly—no extra deps needed.

**Pros:**

* ✅ Fully self-contained (no Maven needed)
* ✅ Includes all dependencies
* ✅ Best for distribution to users
* ✅ Single file, simple run command

**Cons:**

* ❌ Larger file (e.g., 8.4 MB)
* ❌ Requires packaging first

---

### 3) `java -cp target/classes` (Run class files directly)

**How it works:**

```bash
mvn clean compile
java -cp target/classes com.group7.chat.Main
```

**What happens under the hood:**

1. Runs compiled `.class` files directly.
2. Uses system-installed JavaFX (if present).
3. External dependencies aren’t included.

**Pros:**

* ✅ Fast startup
* ✅ Handy for quick dev/testing
* ✅ Minimal output size

**Cons:**

* ❌ You must manage the classpath and deps yourself
* ❌ JavaFX may be missing on the system
* ❌ Not suitable for distribution

---

## 📊 Detailed Comparison

| Feature                   | `mvn javafx:run` | `java -jar` (Fat JAR) | `java -cp` (classes) |
| ------------------------- | ---------------- | --------------------- | -------------------- |
| **Dependency management** | Automatic        | Bundled               | Manual               |
| **JavaFX support**        | Automatic        | Included              | System-dependent     |
| **File size**             | N/A              | ~8.4 MB               | ~113 KB              |
| **Network needed**        | First run        | No                    | No                   |
| **Maven required**        | Yes              | No                    | Only to compile      |
| **End-user friendly**     | ❌                | ✅                     | ❌                    |
| **Dev friendly**          | ✅                | ⚠️                    | ✅                    |

---

## 🎯 When to Use Which?

### Development

```bash
# Quick CLI test
mvn clean compile
java -cp target/classes com.group7.chat.Main

# Test GUI (if JavaFX is available)
mvn javafx:run
```

### Testing

```bash
# Test the final distributable
mvn clean package
java -jar target/p2p-chat-1.0-SNAPSHOT.jar
```

### Distribution to Users

```bash
# Ship just this file
target/p2p-chat-1.0-SNAPSHOT.jar

# Users run:
java -jar p2p-chat-1.0-SNAPSHOT.jar
```

---

## 🔧 Why might `mvn javafx:run` fail now?

On server-like environments, common causes include:

1. **No GUI support:** headless servers can’t open windows.
2. **JavaFX module issues:** module path setup is strict.
3. **Permissions:** the process may be blocked from creating windows.
4. **Dependency conflicts:** mismatched Java/JavaFX versions.

---

## 💡 Best Practices

### For Developers

1. Use `mvn javafx:run` or `java -cp` during development.
2. Validate the end-user experience with the Fat JAR.
3. Debug via IDE or command line as needed.

### For End Users

1. **Ship only** the Fat JAR.
2. Keep the run command simple: `java -jar xxx.jar`.
3. No Maven or manual dependency setup required.

---

## 🚀 Recommended Workflow

```bash
# 1) Fast dev loop
mvn clean compile
java -cp target/classes com.group7.chat.Main

# 2) GUI check (if supported)
mvn javafx:run

# 3) Prepare release build
mvn clean package

# 4) Final user test
java -jar target/p2p-chat-1.0-SNAPSHOT.jar

# 5) Distribute
# Provide only: p2p-chat-1.0-SNAPSHOT.jar
```

That’s why `mvn javafx:run` worked earlier for development, while we now recommend the Fat JAR for testing and distribution.
