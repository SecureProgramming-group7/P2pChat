```bat
@echo off
echo ========================================
echo P2P Chat Update & Test Script
echo ========================================

echo 1. Updating code...
git pull origin main
if %errorlevel% neq 0 (
    echo Update failed, please check your network connection
    pause
    exit /b 1
)

echo 2. Cleaning and recompiling...
mvn clean compile
if %errorlevel% neq 0 (
    echo Build failed, please check the code
    pause
    exit /b 1
)

echo 3. Checking key files...
if exist "src\main\java\com\group7\chat\FileTransferService.java" (
    echo ✓ FileTransferService.java found
) else (
    echo ✗ FileTransferService.java not found
)

if exist "src\main\java\com\group7\chat\AddressParsingTest.java" (
    echo ✓ AddressParsingTest.java found
) else (
    echo ✗ AddressParsingTest.java not found
)

echo 4. Running address parsing test...
java -cp target\classes com.group7.chat.AddressParsingTest

echo ========================================
echo Update complete! You can now test the file transfer feature
echo 
echo Launch commands:
echo Node 1: java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8080
echo Node 2: java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8081
echo ========================================
pause
```
