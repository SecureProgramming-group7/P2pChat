# P2P聊天应用运行指南

## 📋 系统要求

- Java 11 或更高版本
- 支持JavaFX的运行环境

## 🚀 运行方式

### 方式1：使用可执行JAR文件（推荐）

```bash
java -jar ./target/p2p-chat-1.0-SNAPSHOT.jar
```

### 方式2：使用Maven运行

```bash
# 编译项目
mvn clean compile

# 运行命令行版本
mvn exec:java -Dexec.mainClass="com.group7.chat.Main"

# 运行GUI版本（需要JavaFX支持）
mvn javafx:run
```

### 方式3：直接运行类文件

```bash
# 编译项目
mvn clean compile

# 运行命令行版本
java -cp target/classes com.group7.chat.Main

# 运行GUI版本（需要JavaFX模块路径）
java --module-path /path/to/javafx/lib --add-modules javafx.controls,javafx.fxml -cp target/classes com.group7.chat.gui.ChatApplication
```

## 📁 文件说明

- `target/p2p-chat-1.0-SNAPSHOT.jar` - 包含所有依赖的可执行JAR文件（8.8MB）
- `target/decentralized-chat-1.0-SNAPSHOT.jar` - 仅包含项目代码的JAR文件（115KB）

## 🎮 使用说明

### 命令行模式

启动后，您可以使用以下命令：

- `connect <host:port>` - 连接到指定节点
- `send <message>` - 发送消息到所有连接的节点
- `status` - 显示当前状态
- `quit` - 退出程序

### GUI模式

启动GUI版本后，您可以：

1. 查看在线成员列表
2. 发送群聊消息
3. 发起私聊
4. 传输文件
5. 查看连接状态

## 🔧 故障排除

### 如果遇到 "Unable to access jarfile" 错误：

1. 确认您在正确的目录中（包含target文件夹）
2. 确认JAR文件存在：`ls -la target/*.jar`
3. 使用正确的文件名：`p2p-chat-1.0-SNAPSHOT.jar`

### 如果遇到JavaFX相关错误：

1. 确保您的Java版本支持JavaFX
2. 或者使用命令行版本：`java -cp target/classes com.group7.chat.Main`

### 如果遇到端口占用错误：

1. 更改默认端口：`java -jar target/p2p-chat-1.0-SNAPSHOT.jar 8081`
2. 或者终止占用端口的进程

## 🌐 网络配置

- 默认监听端口：8080
- 文件传输端口：9080
- 安全文件传输端口：10080

确保防火墙允许这些端口的通信。

## 📝 注意事项

1. 首次运行会自动生成RSA密钥对
2. 项目支持端到端加密通信
3. 具有分布式覆盖网络功能
4. 包含故意植入的安全漏洞供学习研究
