# Private Messaging — Fix & Debugging Guide

##  Problem Description

Users reported two issues:

1. **Display issue:** The private chat view shows “Starting a private chat with (an irregular string)”.
2. **Functionality issue:** 8081 sends a private message to 8080, but 8080 doesn’t receive it.

##  Display Issues Fixed

### 1. Private chat window title

**Before:** `"Private Chat - " + targetMember.getNodeId()`
**After:**  `"Private Chat - " + targetMember.getDisplayName()`

### 2. Welcome message

**Before:** `"Starting a private chat with " + targetMember.getNodeId()`
**After:**  `"Starting a private chat with " + targetMember.getDisplayName()"`

### 3. System message

**Before:** `"Opened a private chat window with " + nodeId`
**After:**  `"Opened a private chat window with " + member.getDisplayName()`

The private chat view should now display: **“Starting a private chat with Node_8080.”**

##  Added Debugging Aids

To diagnose why private messages weren’t being received, detailed debug logs were added:

### 1. Sender-side log

```java
// In Node.sendPrivateMessage()
System.out.println("Sending private message: " + getDisplayName()
    + " -> " + targetNodeId.substring(0, 8) + "...: " + message);
```

### 2. Receiver-side log

```java
// In MessageRouter.processLocalAppMessage()
System.out.println("Processing local private message: "
    + message.getSenderId().substring(0, 8) + "... -> "
    + node.getDisplayName() + ": " + message.getContent());
```

### 3. Forwarding-path logs

```java
// In MessageRouter.forwardMessage()
System.out.println("Forwarding private message, target: "
    + targetNodeId.substring(0, 8) + "..., current connections: "
    + node.getConnections().size());
System.out.println("Checking connection: " + connection.getAddress()
    + ", remote ID: " + (remoteId != null ? remoteId.substring(0, 8) + "..." : "null"));
System.out.println("Direct connection found; sending private message to: "
    + connection.getAddress());
```

##  Test & Debug Steps

### 1) Start the test

```cmd
testing\gui-test.bat
# Choose "2. Two nodes"
```

### 2) Watch the console output

After startup, the console should show:

* Node startup messages
* Connection establishment
* HELLO message exchange

### 3) Test private messaging

1. On the 8081 node, right-click **Node_8080**
2. Choose **Private Chat**
3. Send **Hello**

### 4) Expected debug output

**Sender (8081):**

```
Sending private message: Node_8081 -> 12345678...: Hello
Forwarding private message, target: 12345678..., current connections: 1
Checking connection: localhost:8080, remote ID: 12345678...
Direct connection found; sending private message to: localhost:8080
```

**Receiver (8080):**

```
Processing local private message: 87654321... -> Node_8080: Hello
```

##  Possible Issues & Fixes

### Issue 1: Remote node ID on the connection is `null`

**Symptom:** Debug output shows `remote ID: null`
**Cause:** `connection.setRemoteNodeId()` wasn’t set during HELLO handling
**Fix:** Check `MessageRouter.handleHelloMessage()`

### Issue 2: No direct connection found

**Symptom:** Debug shows `current connections: 0` or no match for the target ID
**Cause:** Connection not established or node ID mismatch
**Fix:** Verify the connection state and the node-ID matching logic

### Issue 3: Message sent but not received

**Symptom:** Sender logs appear; receiver logs don’t
**Cause:** Transport issue or message serialization problem
**Fix:** Inspect the network connection and message format

##  Next Steps for Debugging

If the issue persists:

1. **Run the test and review the console output**
2. **Capture the full debug logs**
3. **Note any error messages**
4. **Confirm connection state and node-ID matching**

These details will help quickly pinpoint the root cause.

