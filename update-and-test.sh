#!/bin/bash

echo "========================================"
echo "P2P Chat Update & Test Script"
echo "========================================"

echo "1) Pulling latest code..."
git pull origin main
if [ $? -ne 0 ]; then
    echo "Update failed. Please check your network connection."
    exit 1
fi

echo "2) Cleaning and recompiling..."
mvn clean compile
if [ $? -ne 0 ]; then
    echo "Build failed. Please check the code."
    exit 1
fi

echo "3) Checking key files..."
if [ -f "src/main/java/com/group7/chat/FileTransferService.java" ]; then
    echo "✓ FileTransferService.java found"
else
    echo "✗ FileTransferService.java not found"
fi

if [ -f "src/main/java/com/group7/chat/AddressParsingTest.java" ]; then
    echo "✓ AddressParsingTest.java found"
else
    echo "✗ AddressParsingTest.java not found"
fi

echo "4) Running address parsing test..."
java -cp target/classes com.group7.chat.AddressParsingTest

echo "========================================"
echo "Update complete! You can now test the file transfer feature."
echo ""
echo "Launch commands:"
echo "Node 1: java --module-path . --add-modules javafx.controls,javafx.fxml -jar target/p2p-chat-1.0-SNAPSHOT.jar 8080"
echo "Node 2: java --module-path . --add-modules javafx.controls,javafx.fxml -jar target/p2p-chat-1.0-SNAPSHOT.jar 8081"
echo "========================================"

