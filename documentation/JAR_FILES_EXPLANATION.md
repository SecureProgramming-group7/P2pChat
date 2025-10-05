# JAR Files Explained

## 📦 Why are there two JARs?

You’ll see two JARs under `target/`. They’re produced by different Maven plugins:

### 1) `decentralized-chat-1.0-SNAPSHOT.jar` (113 KB)

* **Produced by:** Maven JAR Plugin (default)
* **Contents:** Only your project’s code
* **Size:** 113 KB
* **Dependencies:** **Not** included (JavaFX, Gson, etc.)
* **How to run:** Requires manual classpath setup
* **Use case:** Development, debugging, or as a library

**Run command:**

```bash
# Cannot be run directly (missing dependencies)
java -jar target/decentralized-chat-1.0-SNAPSHOT.jar  # ❌ will fail

# Provide classpath explicitly
java -cp target/classes:<deps> com.group7.chat.gui.ChatApplication
```

### 2) `p2p-chat-1.0-SNAPSHOT.jar` (8.4 MB)

* **Produced by:** Maven Shade Plugin
* **Contents:** Project code **+ all dependencies**
* **Size:** 8.4 MB
* **Dependencies:** Bundles JavaFX, Gson, etc.
* **How to run:** Runnable as-is
* **Use case:** Final, user-friendly distribution

**Run command:**

```bash
# Runs directly ✅
java -jar target/p2p-chat-1.0-SNAPSHOT.jar
```

## 🔍 Side-by-side

| Feature           | Small JAR (113 KB) | Fat JAR (8.4 MB)        |
| ----------------- | ------------------ | ----------------------- |
| **What’s inside** | Project code only  | Project code + all deps |
| **JavaFX**        | ❌ Not included     | ✅ Included              |
| **Gson**          | ❌ Not included     | ✅ Included              |
| **Run directly**  | ❌ No               | ✅ Yes                   |
| **File size**     | Small              | Large                   |
| **Use case**      | Dev / library      | Release                 |

## 🎯 Recommended

**For end users:** use `p2p-chat-1.0-SNAPSHOT.jar`

```bash
java -jar target/p2p-chat-1.0-SNAPSHOT.jar
```

**For developers:** use both

* Small JAR for dev/debug
* Fat JAR for testing the release build

## 🛠️ How it works

### Maven JAR Plugin (default)

```xml
<!-- Included by default in Maven builds -->
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-jar-plugin</artifactId>
</plugin>
```

* Packs `src/main/java` and `src/main/resources`
* **Does not** include dependencies
* Outputs `${artifactId}-${version}.jar`

### Maven Shade Plugin (added by us)

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-shade-plugin</artifactId>
  <configuration>
    <finalName>p2p-chat-1.0-SNAPSHOT</finalName>
    <!-- Bundle all dependencies -->
  </configuration>
</plugin>
```

* Merges all dependencies into one JAR
* Creates a **fat/uber JAR**
* Runs standalone—no extra deps needed

## 🗂️ What’s inside

**Small JAR:**

```
META-INF/
css/
fxml/
com/group7/chat/   (project code only)
```

**Fat JAR:**

```
META-INF/
css/
fxml/
com/group7/chat/    (project code)
com/sun/javafx/     (JavaFX)
com/google/gson/    (Gson)
javafx/             (JavaFX modules)
... (other deps)
```

## 💡 Best Practices

1. **For releases:** ship only the fat JAR.
2. **Version control:** generally don’t commit JARs to Git.
3. **CI/CD:** generate JARs during build and publish artifacts.
4. **Docs:** note in the README that users should run the fat JAR.
