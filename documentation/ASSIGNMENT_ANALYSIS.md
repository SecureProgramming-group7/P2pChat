# Distributed multi-party chat system - Assignment Requirements Analysis

## 📋 Overview of Assignment Objectives

This project aims to develop a **distributed multi-party chat system**, with a primary focus on designing and implementing secure communication protocols. It also deliberately embeds security vulnerabilities for peers to discover during review. Overall, it’s a comprehensive security programming assignment spanning distributed systems design, secure protocol development, vulnerability analysis, and peer review.

## 🎯 **Core Requirements Breakdown**


### 1. **Distributed Overlay Network Design**
**Requirement:** Architect and standardize a secure communication protocol

**Key points:**

* Design the overlay network topology
* Define the inter-node communication protocol
* Implement multi-party (group) chat mechanics
* Ensure the protocol is standardized and extensible

**Technical challenges:**

* Dynamic maintenance of the network topology
* Message routing algorithm design
* Load balancing and performance optimization
* Protocol version compatibility (forward/backward)

### 2. Decentralized Architecture

**Requirement:** No single central server may handle all communications.

**Key points:**

* Fully distributed node discovery
* Decentralized message routing
* Distributed group (multi-party) management
* Architecture with no single point of failure (SPOF)

**Technical challenges:**

* Distributed consistency
* Handling network partitions
* State synchronization mechanisms
* Conflict resolution strategies

### 3. Robustness by Design

**Requirement:** The system must remain robust in the face of any node or device failures.

**Key points:**

* Failure detection mechanisms
* Automatic (self-healing) recovery
* Tolerance of network partitions
* Data redundancy and backups

**Technical challenges:**

* Accuracy and timeliness of failure detection
* Efficiency of the recovery process
* Guarantees of data consistency
* Algorithms for network reconfiguration


### 4. Advanced Secure Coding Practices

**Requirement:** Incorporate advanced secure coding practices.

**Key points:**

* Secure cryptographic implementations
* Input validation and output encoding
* Memory-safe management
* Secure error handling

**Technical challenges:**

* Secure key management
* Side-channel attack mitigation
* Timing-attack resistance
* Cryptographically secure random number generation


### 5. Deliberately Planted Vulnerabilities

**Requirement:** Conduct a controlled, ethically scoped backdoor attack on your own implementation.

**Key points:**

* Design a subtle security weakness
* Ensure the weakness is discoverable through review
* Preserve core system functionality
* Document the rationale and intent behind the flaw

**Technical challenges:**

* Balancing subtlety and detectability
* Avoiding impact on critical features
* Controlling the complexity of the weakness
* Staying within clear ethical boundaries


### 6. Peer Review Readiness

**Requirement:** Carry out peer review and perform both manual and automated code analysis.

**Key points:**

* Prepare materials for code review
* Create a vulnerability discovery guide
* Design test cases
* Write an analysis report

**Technical challenges:**

* Ensuring completeness of review materials
* Providing just-enough hints for finding vulnerabilities
* Achieving adequate test coverage
* Maintaining high documentation quality


## 🏗️ **System Architecture Design**

### **Distributed Overlay Network Architecture**

```
                Distributed Overlay Network
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │  Node A ←→ Node B ←→ Node C ←→ Node D ←→ Node E  │
    │    ↕        ↕        ↕        ↕        ↕      │
    │  Node F ←→ Node G ←→ Node H ←→ Node I ←→ Node J  │
    │    ↕        ↕        ↕        ↕        ↕      │
    │  Node K ←→ Node L ←→ Node M ←→ Node N ←→ Node O  │
    │                                                 │
    └─────────────────────────────────────────────────┘
```

**Characteristics:**

* Each node maintains connections to multiple neighbors
* Supports dynamic join and leave (churn)
* Automatic topology reconfiguration
* Multi-path message delivery

### **Multi-party Group Chat Architecture**

```
 Distributed Group Management Architecture
    ┌─────────────────────────────┐
    │      Group Alpha            │
    │  ┌─────┐  ┌─────┐  ┌─────┐  │
    │  │Node1│←→│Node2│←→│Node3│  │
    │  └─────┘  └─────┘  └─────┘  │
    └─────────────────────────────┘
    
    ┌─────────────────────────────┐
    │      Group Beta             │
    │  ┌─────┐  ┌─────┐  ┌─────┐  │
    │  │Node2│←→│Node4│←→│Node5│  │
    │  └─────┘  └─────┘  └─────┘  │
    └─────────────────────────────┘
```

**Characteristics:**

* Nodes can participate in multiple groups simultaneously
* Distributed membership management
* Efficient broadcast of group messages
* Dynamic group creation and dissolution

## 🔐 **Secure Protocol Design**

### **Layered Security Architecture**

```
┌─────────────────────────────────────────┐
│       Application-layer Security         │
│  ┌─────────────┐ ┌─────────────────────┐ │
│  │ Message     | |                     | |
|  | Integrity   | | Group Access Control| |
|  |             | |                     | |
│  └─────────────┘ └─────────────────────┘ │
├─────────────────────────────────────────┤
│        Transport-layer Security         │
│  ┌─────────────┐ ┌─────────────────────┐ │
│  │ End-to-end  | |   Authentication    | |
|  | Encryption  | |                     | |
│  └─────────────┘ └─────────────────────┘ │
├─────────────────────────────────────────┤
│          Network-layer Security          |
│  ┌─────────────┐ ┌─────────────────────┐ │
│  │  Routing    | |    Node Discovery   | |        
|  |  Security   | |     Security        | |
│  └─────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────┘
```

### Key Management Protocol

1. **Node Identity Keys**

   * Each node generates a unique RSA key pair.
   * The public key serves as the node’s identity.
   * The private key is used for digital signatures and authentication.

2. **Group Session Keys**

   * An AES group key is created when a group is formed.
   * Negotiated via the Diffie–Hellman protocol.
   * Supports key rotation and forward secrecy.

3. **Communication Session Keys**

   * Ephemeral session keys are established between nodes.
   * Periodically rekeyed to maintain forward secrecy.
   * Supports key recovery mechanisms.

## 🛡️ **Failure Recovery Mechanisms**

### **Node Failure Detection**

```java
// Heartbeat Monitoring Mechanism
public class HeartbeatMonitor {
    private static final int HEARTBEAT_INTERVAL = 30000; // Every 30 seconds.
    private static final int FAILURE_THRESHOLD = 3;      // 3 failures
    
    public void startMonitoring(String nodeId) {
        // Send heartbeat packets periodically.
        // Detect response timeouts.
        // Mark failed nodes.
    }
}
```

### **Network Partition Handling**

```java
// Network Partition Detection and Handling
public class PartitionHandler {
    public void detectPartition() {
        // Check network connectivity.
        // Identify partition boundaries.
        // Trigger reconfiguration.
    }
    
    public void handlePartition() {
        // Elect a partition coordinator.
        // Maintain intra-partition consistency.
        // Prepare for partition merge.
    }
}
```

### **Automatic Recovery Mechanism**

```java
// Automatic failure recovery.
public class RecoveryManager {
    public void recoverFromFailure(FailureType type) {
        switch (type) {
            case NODE_FAILURE:
                // Reroute messages.
                // Update the neighbor table.
                break;
            case NETWORK_PARTITION:
                // Partition merge.
                // State synchronization.
                break;
            case DATA_CORRUPTION:
                // Data recovery.
                // Consistency check.
                break;
        }
    }
}
```

## 🎭 **Deliberate Vulnerability Design Strategy**

### Vulnerability type planning.

1. **Cryptographic Vulnerabilities**

   * Weak random number generation
   * Key reuse
   * Timing-attack exposure
   * Side-channel leakage

2. **Protocol Vulnerabilities**

   * Replay attacks
   * Man-in-the-middle (MITM) footholds
   * Authentication bypass
   * Message injection

3. **Implementation Vulnerabilities**

   * Buffer overflows
   * Insufficient input validation
   * Race conditions
   * Memory leaks

4. **Logic Vulnerabilities**

   * Privilege escalation
   * Access control bypass
   * State machine errors
   * Business logic flaws

### **Stealthy Vulnerability Design**

```java
// Example: Stealthy Key Reuse Vulnerability
public class KeyManager {
    private static final Map<String, SecretKey> keyCache = new HashMap<>();
    
    public SecretKey generateSessionKey(String sessionId) {
        // Deliberate Vulnerability: Key Reuse Under Specific Conditions
        if (sessionId.startsWith("admin_")) {
            return keyCache.computeIfAbsent("admin_master", 
                k -> generateNewKey());
        }
        return generateNewKey();
    }
}
```

### **Vulnerability Discovery Hints**

1. **Code comments**
   ```java
   // TODO: Verify RNG strength here
   // FIXME: Temporary implementation; improve validation
   // NOTE: May break under high concurrency
   ```

2. **Test case**
   ```java
   @Test
   public void testAdminSessionSecurity() {
       // Special handling for admin sessions
       // Check consistency of key management
   }
   ```

3. **Documentation**
   ```markdown
   ## Known Limitations
   - Potential security risks under certain edge conditions
   - Admin privileges require extra security review
   - Thread safety under high concurrency needs further verification
   ```

## 📊 **Evaluation Metrics**

### Functional Metrics

* **Message delivery success rate:** > 99%
* **Node failure recovery time:** < 30s
* **Network partition recovery time:** < 60s
* **Group management response time:** < 5s

### Security Metrics

* **Encryption coverage:** 100%
* **Authentication success rate:** > 99.9%
* **Vulnerability discovery rate:** target 50–80%
* **False positive rate:** < 10%

### Performance Metrics

* **Message latency:** < 100 ms
* **Throughput:** > 1,000 msg/s
* **Memory usage:** < 512 MB
* **CPU utilization:** < 50%

## 🔄 **Development Plan**

### Phase 1: Infrastructure (Current)

* Project migration & environment setup
* Basic distributed networking
* Integration of core security components

### Phase 2: Overlay Network (Next)

* Distributed topology management
* Dynamic routing algorithms
* Load balancing mechanisms

### Phase 3: Multi-party Chat

* Group management protocol
* Message broadcast mechanism
* State synchronization algorithms

### Phase 4: Failure Recovery

* Failure detection system
* Automatic recovery mechanisms
* Network partition handling

### Phase 5: Security Hardening

* Advanced secure coding practices
* Deliberate vulnerability design
* Security testing framework

### Phase 6: Review Readiness

* Documentation polish
* Test case authoring
* Vulnerability discovery guide

## 🎯 **Success Criteria**

1. **System Functionality Completeness**

   * Full multi-party chat implemented
   * Supports dynamic node join/leave
   * Automatic failure recovery

2. **Security Protocol Standardization**

   * Clear, complete protocol documentation
   * Sound security mechanisms
   * Implementation aligns with best practices

3. **Rational Vulnerability Design**

   * Sufficiently stealthy
   * No impact on core functionality
   * Educational value

4. **Quality of Review Materials**

   * Clean code structure
   * Detailed, complete documentation
   * Adequate test coverage

This analysis gives us a clear direction and a concrete implementation plan. Next, we’ll follow this framework to build a fully functional, secure, and reliable distributed chat system that also includes educational, intentionally planted vulnerabilities.
