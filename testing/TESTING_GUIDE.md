# P2P Chat Testing Guide

## 🚀 Quick Test

### Method 1: Automatically launch 3 nodes (recommended)
```cmd
# Windows
quick-test.bat

# Linux/Mac
./quick-test.sh
```

### Method 2: Interactive Launch
```cmd
# Windows
test-multiple-nodes.bat

# Linux/Mac  
./test-multiple-nodes.sh
```

##📋 Manual Testing Steps

## Launch Multiple Nodes

**Command-Line Version：**
```cmd
# Node 1 (Main Node)
java -cp target\classes com.group7.chat.Main 8080

# Node 2 (Connect to Node 1)
java -cp target\classes com.group7.chat.Main 8081 localhost:8080

# Node 3 (Connect to Node 1)
java -cp target\classes com.group7.chat.Main 8082 localhost:8080
```

**GUI Version：**
```cmd
#  Node 1 
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8080

#  Node 2
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8081

#  Node 3
java --module-path . --add-modules javafx.controls,javafx.fxml -jar target\p2p-chat-1.0-SNAPSHOT.jar 8082
```

## 🎮 Test Features

### 1. Basic Connection Test
-Launch Node 1 (port 8080)
-LLaunch Node 2 (port 8081)
-LIn Node 2, run: connect localhost:8080
-LCheck connection status: status

### 2.Group Chat Test
-Send a message from any node: send Hello everyone!
-Check whether the other nodes receive the message
### 3. Private Chat Test (GUI Version)
-Right-click on a user in the online user list
-Select “Private Chat”
-Send a private message

### 4. File Transfer Test
- In the GUI, click the “Send File” button
-Select the file to send
-Check whether the other nodes receive the file

### 5.Network Robustness Test
- Launch 3 nodes
- Shut down the middle node
- Check whether the other nodes can still communicate

## 🔧ommand-Line Interface Commands

### Basic Commands
- `connect <host:port>` - Connect to a Specific Node
- `send <message>` - Send a Group Chat Message
- `status` - Display Node Status and Connection Information
- `list` - List Connected Nodes
- `quit` - Exit the Program

### Advanced Commands
- `ping <host:port>` - Test Connection with a Specific Node
- `info` - Display Detailed Node Information
- `debug` - Toggle Debug Mode

## 📊 Test Scenarios

### Scenario 1: Basic P2P Communication
1. Launch 2 nodes
2. Establish the connection
3. Send messages in both directions
4. Verify message delivery

###Scenario 2: Multi-Node Network
1.Launch 3–5 nodes
2.Form a mesh network
3.Test message broadcasting
4.Verify network discovery

### Scenario 3: Node Failure Recovery
1.Launch 3 nodes
2.Disconnect one node
3.Reconnect
4.Verify network self-healing

### Scenario 4: File Transfer
1.Launch 2 nodes
2.Send files of different sizes
3.Verify file integrity
4.Test transfer speed

## 🐛 Troubleshooting

### Connection Failure
Check if the port is already in use
Verify firewall settings
Confirm the IP address and port number

### Message Desynchronization
Check the network connection
Verify the status of the nodes
Restart the affected nodes

### GUI Launch Failure
Run check-javafx.bat to check JavaFX
Use the Command-Line Version as an alternative

## 📈 Performance Testing

### Message Throughput
Send a large volume of messages
Measure transmission latency
Monitor memory usage

### Network Scalability
Gradually increase the number of nodes
Test the maximum number of connections
Observe performance changes

### File Transfer Performance
Transfer files of different sizes
Measure transfer speed
Verify concurrent transfers

## 💡 Testing Tips

1. **Use Different Ports**：Avoid port conflicts
2. **Monitor Logs**：Observe detailed runtime information
3. **Network Tools**：Use netstat to check connection status
4. **Step-by-Step Testing*：Verify each functional module individually
5. **Record Results**：Save test data for analysis

## 🎯Expected Results

-✅ Nodes can successfully connect
-✅ Messages are delivered in real time
-✅ Files are transferred completely
-✅ The network has fault recovery capability
-✅ GUI and CLI versions have consistent functionality
