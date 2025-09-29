# 测试工具故障排除指南

## 🚨 常见问题

### 问题1：双击脚本后命令行闪退

**症状：** 双击 `multi-gui-test.bat` 后，命令行窗口一闪而过

**原因：** 脚本遇到错误后立即退出

**解决方案：**
1. **使用诊断工具：**
   ```cmd
   # 双击运行
   test-diagnosis.bat
   ```

2. **使用调试版本：**
   ```cmd
   # 双击运行
   multi-gui-test-debug.bat
   ```

3. **手动运行：**
   ```cmd
   # 在命令提示符中运行
   cd testing
   multi-gui-test.bat
   ```

### 问题2：找不到JAR文件

**错误信息：** `Cannot find JAR file!`

**解决方案：**
1. **确保项目已编译：**
   ```cmd
   # 在主项目目录运行
   mvn clean package
   ```

2. **检查目录结构：**
   ```
   P2pChat/
   ├── testing/          ← 您应该在这里
   └── target/
       └── p2p-chat-1.0-SNAPSHOT.jar
   ```

### 问题3：JavaFX不可用

**错误信息：** `JavaFX not available!` 或 `Module javafx.controls not found`

**解决方案：**
1. **检查JavaFX安装：**
   ```cmd
   ..\check-javafx.bat
   ```

2. **安装包含JavaFX的Java：**
   - 下载：https://www.azul.com/downloads/?package=jdk-fx
   - 选择 "JDK FX" 版本

3. **使用CLI版本替代：**
   ```cmd
   multi-cli-test.bat
   ```

### 问题4：GUI窗口不出现

**症状：** 脚本运行成功，但没有GUI窗口出现

**解决方案：**
1. **检查任务管理器：** 查看是否有Java进程在运行
2. **检查防火墙：** 确保Java程序被允许
3. **尝试单个节点：**
   ```cmd
   java --module-path . --add-modules javafx.controls,javafx.fxml -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 8080
   ```

### 问题5：端口被占用

**错误信息：** `Address already in use` 或类似的端口错误

**解决方案：**
1. **关闭其他P2P Chat实例**
2. **使用不同端口：**
   ```cmd
   # 手动指定端口
   java -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 9090
   ```
3. **重启计算机**（如果问题持续）

## 🔧 诊断工具

### 1. 基本诊断
```cmd
test-diagnosis.bat
```
检查：
- JAR文件是否存在
- Java是否安装
- JavaFX是否可用
- CLI版本是否工作

### 2. 详细调试
```cmd
multi-gui-test-debug.bat
```
提供：
- 详细的执行步骤
- 错误信息显示
- 单节点测试选项

### 3. JavaFX专项检查
```cmd
..\check-javafx.bat
```
检查：
- Java版本
- JavaFX模块
- 编译和运行测试

## 📋 手动测试步骤

如果自动脚本都失败，可以手动测试：

### 1. 测试CLI版本
```cmd
cd testing
java -cp ..\target\classes com.group7.chat.Main 8080
```

### 2. 测试GUI版本
```cmd
cd testing
java --module-path . --add-modules javafx.controls,javafx.fxml -jar ..\target\p2p-chat-1.0-SNAPSHOT.jar 8080
```

### 3. 测试多个节点
```cmd
# 第一个命令提示符
java -cp ..\target\classes com.group7.chat.Main 8080

# 第二个命令提示符
java -cp ..\target\classes com.group7.chat.Main 8081 localhost:8080
```

## 🆘 获取帮助

### 收集错误信息
1. **运行诊断工具：** `test-diagnosis.bat`
2. **截图错误信息**
3. **记录Java版本：** `java -version`
4. **记录操作系统版本**

### 常见解决方案优先级
1. ✅ **首先尝试：** CLI版本测试
2. ✅ **然后尝试：** 安装JavaFX支持的Java
3. ✅ **最后尝试：** 手动命令行运行

### 备选方案
如果GUI测试始终失败：
- 使用 `multi-cli-test.bat` 进行CLI测试
- 功能完全相同，只是界面不同
- 更稳定，兼容性更好

## 💡 预防措施

1. **确保项目编译：** 运行测试前先执行 `mvn clean package`
2. **使用正确的Java：** 推荐使用包含JavaFX的Java发行版
3. **从正确目录运行：** 确保在 `testing/` 目录中运行脚本
4. **关闭其他实例：** 避免端口冲突
