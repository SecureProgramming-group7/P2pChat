# DONP - Distributed Overlay Network Protocol

## 🌐 Protocol Overview

**DONP (Distributed Overlay Network Protocol)** is a distributed overlay network protocol designed for multi-party chat systems. It delivers a fully decentralized architecture with dynamic node discovery, adaptive routing, fault recovery, and multi-party group communication.

### Design Principles

1. **Fully decentralized:** No central servers or coordinator nodes.
2. **Self-organizing network:** Nodes automatically discover peers and form the topology.
3. **Fault tolerance:** Robust against node failures and network partitions.
4. **Scalability:** Supports large-scale node networks.
5. **Security:** Built-in end-to-end encryption and authentication.

## 🏗️ Network Architecture

### Overlay Network Topology

```
            Distributed Overlay Network Topology
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │    A ←─→ B ←─→ C                                │
    │    ↕     ↕     ↕                                │
    │    D ←─→ E ←─→ F ←─→ G                          │
    │    ↕     ↕     ↕     ↕                          │
    │    H ←─→ I ←─→ J ←─→ K ←─→ L                    │
    │          ↕     ↕     ↕     ↕                    │
    │          M ←─→ N ←─→ O ←─→ P                    │
    │                                                 │
    └─────────────────────────────────────────────────┘
```

**Characteristics:**

* **Mesh topology:** Each node maintains multiple neighbor links
* **Redundant paths:** Multiple routes ensure message reachability
* **Dynamic adaptation:** Connections auto-adjust to network conditions
* **Load balancing:** Intelligent distribution of routing load

### Node Type Definitions

```java
public enum NodeType {
    BOOTSTRAP,    // Bootstrap node: helps new nodes join the network
    REGULAR,      // Regular node: standard participant
    SUPER,        // Super node: higher-capacity processing node
    RELAY         // Relay node: dedicated to message forwarding
}
```

**Node State Model**

```java
public enum NodeState {
    INITIALIZING,  // Initializing
    DISCOVERING,   // Discovering neighbors
    CONNECTING,    // Establishing connections
    ACTIVE,        // Active
    DEGRADED,      // Degraded (partial functionality)
    RECOVERING,    // Recovering
    LEAVING        // Leaving the network
}
```

## 📡 Communication Protocol Specification

### Message Format Definition

```json
{
  "header": {
    "version": "1.0",
    "messageId": "uuid-string",
    "messageType": "DISCOVERY|ROUTING|CHAT|CONTROL",
    "sourceNodeId": "node-id",
    "targetNodeId": "node-id|broadcast",
    "timestamp": 1234567890,
    "ttl": 10,
    "signature": "digital-signature"
  },
  "payload": {
    "encrypted": true,
    "algorithm": "AES-256-GCM",
    "data": "encrypted-content",
    "metadata": {}
  },
  "routing": {
    "path": ["node1", "node2", "node3"],
    "nextHop": "node-id",
    "priority": "HIGH|NORMAL|LOW"
  }
}
```

### Message Type Specification

#### 1. Discovery Message 

```java
// Node Announcement Message
public class NodeAnnouncement {
    private String nodeId;
    private NodeType nodeType;
    private String ipAddress;
    private int port;
    private List<String> capabilities;
    private PublicKey publicKey;
    private long timestamp;
}

// Neighbor Request Message
public class NeighborRequest {
    private String requesterId;
    private int maxNeighbors;
    private List<String> preferredTypes;
    private GeographicLocation location; // Optional
}

// Neighbor Response Message
public class NeighborResponse {
    private String responderId;
    private List<NodeInfo> availableNeighbors;
    private boolean accepted;
    private String reason;
}
```

#### 2. Routing Control Messages 

```java
// Routing Table Update
public class RoutingUpdate {
    private String sourceNodeId;
    private List<RouteEntry> routes;
    private int sequenceNumber;
    private long timestamp;
}

// Path Discovery Message
public class PathDiscovery {
    private String sourceNodeId;
    private String targetNodeId;
    private List<String> visitedNodes;
    private int maxHops;
    private Map<String, Object> metrics;
}

// Path Response Message
public class PathResponse {
    private String sourceNodeId;
    private String targetNodeId;
    private List<String> path;
    private Map<String, Object> pathMetrics;
}
```

#### 3. Group Management Messages

```java
// Group Creation Message
public class GroupCreation {
    private String groupId;
    private String creatorId;
    private String groupName;
    private GroupType groupType;
    private List<String> initialMembers;
    private GroupPolicy policy;
    private byte[] groupKey; // Encrypted Transport
}

// Group Join Request
public class GroupJoinRequest {
    private String groupId;
    private String requesterId;
    private String invitationCode; // Optional
    private PublicKey requesterPublicKey;
}

// Group Membership Update
public class GroupMemberUpdate {
    private String groupId;
    private String operatorId;
    private GroupOperation operation;
    private List<String> affectedMembers;
    private long timestamp;
}
```

#### 4. Chat Messages 

```java
// Private Message 
public class PrivateMessage {
    private String messageId;
    private String senderId;
    private String recipientId;
    private String encryptedContent;
    private MessageType contentType;
    private long timestamp;
    private byte[] signature;
}

// Group Message
public class GroupMessage {
    private String messageId;
    private String groupId;
    private String senderId;
    private String encryptedContent;
    private MessageType contentType;
    private long timestamp;
    private byte[] signature;
    private List<String> deliveryConfirmation;
}
```

## 🔀 Routing Algorithm Design

### Distributed Routing Table

```java
public class DistributedRoutingTable {
    // Direct neighbors
    private Map<String, NeighborInfo> directNeighbors;

    // Multi-hop routing table
    private Map<String, RouteEntry> routingTable;

    // Group routing table
    private Map<String, GroupRouteInfo> groupRoutes;

    // Route cache
    private LRUCache<String, List<String>> pathCache;
}


public class RouteEntry {
    private String destinationNodeId;
    private String nextHopNodeId;
    private int hopCount;
    private double reliability;
    private long latency;
    private long lastUpdated;
    private int sequenceNumber;
}
```

### Adaptive Routing Algorithm

```java
public class AdaptiveRoutingAlgorithm {

    // Distance-vector–based route discovery
    public void updateRoutingTable(RoutingUpdate update) {
        for (RouteEntry entry : update.getRoutes()) {
            String dest = entry.getDestinationNodeId();
            RouteEntry current = routingTable.get(dest);

            if (current == null || isBetterRoute(entry, current)) {
                // Update routing table
                routingTable.put(dest, entry);
                // Broadcast the update to neighbors
                broadcastRoutingUpdate(entry);
            }
        }
    }

    // Route quality evaluation
    private boolean isBetterRoute(RouteEntry newRoute, RouteEntry currentRoute) {
        // Consider hop count, latency, and reliability
        double newScore = calculateRouteScore(newRoute);
        double currentScore = calculateRouteScore(currentRoute);
        return newScore > currentScore;
    }

    // Multi-path route selection
    public List<String> findMultiplePaths(String targetNodeId, int maxPaths) {
        // Use a modified Dijkstra to find multiple paths
        // Consider path disjointness and load balancing
        return pathFinder.findKShortestPaths(targetNodeId, maxPaths);
    }
}
```

### Message Forwarding Strategy

```java
public class MessageForwardingStrategy {

    // Intelligent forwarding decision
    public ForwardingDecision makeForwardingDecision(Message message) {
        String targetId = message.getTargetNodeId();

        if (isDirectNeighbor(targetId)) {
            return new ForwardingDecision(DIRECT, targetId);
        }

        if (isGroupMessage(message)) {
            return makeGroupForwardingDecision(message);
        }

        return makeUnicastForwardingDecision(message);
    }

    // Group message forwarding
    private ForwardingDecision makeGroupForwardingDecision(GroupMessage message) {
        String groupId = message.getGroupId();
        List<String> groupMembers = getGroupMembers(groupId);

        // Compute the optimal forwarding tree
        SpanningTree forwardingTree = calculateForwardingTree(groupMembers);
        return new ForwardingDecision(MULTICAST, forwardingTree.getNextHops());
    }

    // Unicast message forwarding
    private ForwardingDecision makeUnicastForwardingDecision(Message message) {
        String targetId = message.getTargetNodeId();
        List<String> paths = routingTable.getPaths(targetId);

        if (paths.isEmpty()) {
            // Trigger path discovery
            initiatePathDiscovery(targetId);
            return new ForwardingDecision(BUFFER, null);
        }

        // Select the best next hop
        String nextHop = selectBestNextHop(paths);
        return new ForwardingDecision(FORWARD, nextHop);
    }
}
```

## 🔍 Node Discovery Mechanisms

### Bootstrap Node Discovery

```java
public class BootstrapDiscovery {
    private static final List<String> BOOTSTRAP_NODES = Arrays.asList(
        "bootstrap1.p2pchat.org:8080",
        "bootstrap2.p2pchat.org:8080",
        "bootstrap3.p2pchat.org:8080"
    );
    
    public List<NodeInfo> discoverBootstrapNodes() {
        List<NodeInfo> availableNodes = new ArrayList<>();
        
        for (String bootstrapAddress : BOOTSTRAP_NODES) {
            try {
                NodeInfo nodeInfo = queryBootstrapNode(bootstrapAddress);
                if (nodeInfo != null) {
                    availableNodes.add(nodeInfo);
                }
            } catch (Exception e) {
                logger.warn("Bootstrap node {} unavailable", bootstrapAddress);
            }
        }
        
        return availableNodes;
    }
}
```

### Local Network Discovery

```java
public class LocalNetworkDiscovery {
    private static final int DISCOVERY_PORT = 8888;
    private static final String MULTICAST_GROUP = "224.0.0.1";
    
    public void startLocalDiscovery() {
        // UDP multicast discovery
        MulticastSocket socket = new MulticastSocket(DISCOVERY_PORT);
        InetAddress group = InetAddress.getByName(MULTICAST_GROUP);
        socket.joinGroup(group);
        
        // Periodically send discovery beacons
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(() -> {
            sendDiscoveryBeacon(socket, group);
        }, 0, 30, TimeUnit.SECONDS);
        
        // Listen for discovery responses
        listenForDiscoveryResponses(socket);
    }
    
    private void sendDiscoveryBeacon(MulticastSocket socket, InetAddress group) {
        NodeAnnouncement announcement = createNodeAnnouncement();
        byte[] data = serializeMessage(announcement);
        DatagramPacket packet = new DatagramPacket(data, data.length, group, DISCOVERY_PORT);
        socket.send(packet);
    }
}
```

### DHT Node Discovery

```java
public class DHTNodeDiscovery {
    private KademliaRoutingTable routingTable;
    private static final int K_BUCKET_SIZE = 20;

    public List<NodeInfo> findClosestNodes(String targetNodeId, int count) {
        // Find closest nodes using the Kademlia algorithm
        List<NodeInfo> candidates = new ArrayList<>();

        // Start with the local routing table
        candidates.addAll(routingTable.getClosestNodes(targetNodeId, count));

        // If insufficient, query the network
        if (candidates.size() < count) {
            candidates.addAll(queryNetworkForNodes(targetNodeId, count - candidates.size()));
        }

        return candidates.stream()
                // Sort by XOR distance to the target
                .sorted((a, b) -> compareDistance(a.getNodeId(), b.getNodeId(), targetNodeId))
                .limit(count)
                .collect(Collectors.toList());
    }

    private void updateRoutingTable(NodeInfo nodeInfo) {
        String nodeId = nodeInfo.getNodeId();
        int bucketIndex = calculateBucketIndex(nodeId);

        KBucket bucket = routingTable.getBucket(bucketIndex);
        bucket.addNode(nodeInfo);

        // If the bucket is full, perform split or replacement policy
        if (bucket.isFull()) {
            handleFullBucket(bucket, nodeInfo);
        }
    }
}
```

## 🏘️ Group Management Protocol

### Distributed Group Architecture

```java
public class DistributedGroup {
    private String groupId;
    private String groupName;
    private GroupType groupType;
    private Set<String> members;
    private Map<String, GroupRole> memberRoles;
    private GroupPolicy policy;
    private SecretKey groupKey;
    private VectorClock vectorClock; // For state synchronization
    
    // Distributed group state management
    private Map<String, GroupState> memberStates;
    private ConsensusAlgorithm consensus;
}

public enum GroupType {
    PUBLIC,      // Public group; anyone can join
    PRIVATE,     // Private group; invite required
    SECRET,      // Secret group; not discoverable
    TEMPORARY    // Temporary group; expires automatically
}

public enum GroupRole {
    OWNER,       // Group owner
    ADMIN,       // Administrator
    MODERATOR,   // Moderator
    MEMBER,      // Regular member
    GUEST        // Guest
}
```

### Group Creation Protocol

```java
public class GroupCreationProtocol {
    
    public Group createGroup(GroupCreationRequest request) {
        // 1) Generate group ID and key
        String groupId = generateGroupId();
        SecretKey groupKey = generateGroupKey();
        
        // 2) Create the group object
        Group group = new Group(groupId, request.getGroupName(),
                                request.getGroupType(), request.getCreatorId());
        
        // 3) Add the creator as OWNER
        group.addMember(request.getCreatorId(), GroupRole.OWNER);
        
        // 4) Invite initial members
        for (String memberId : request.getInitialMembers()) {
            sendGroupInvitation(groupId, memberId, groupKey);
        }
        
        // 5) Broadcast group-creation notification
        broadcastGroupCreation(group);
        
        return group;
    }
    
    private void sendGroupInvitation(String groupId, String memberId, SecretKey groupKey) {
        GroupInvitation invitation = new GroupInvitation();
        invitation.setGroupId(groupId);
        invitation.setInviterId(getCurrentNodeId());
        invitation.setEncryptedGroupKey(encryptGroupKey(groupKey, memberId));
        invitation.setTimestamp(System.currentTimeMillis());
        
        sendMessage(memberId, invitation);
    }
}
```

### Group Membership Synchronization

```java
public class GroupMembershipSync {
    
    // Use a vector clock for state synchronization
    public void synchronizeGroupState(String groupId) {
        Group localGroup = getLocalGroup(groupId);
        VectorClock localClock = localGroup.getVectorClock();
        
        // Request state from all group members
        for (String memberId : localGroup.getMembers()) {
            GroupStateRequest request = new GroupStateRequest();
            request.setGroupId(groupId);
            request.setRequesterClock(localClock);
            
            sendMessage(memberId, request);
        }
    }
    
    public void handleGroupStateRequest(GroupStateRequest request) {
        String groupId = request.getGroupId();
        Group localGroup = getLocalGroup(groupId);
        VectorClock localClock = localGroup.getVectorClock();
        VectorClock requesterClock = request.getRequesterClock();
        
        // Compare vector clocks to determine what needs syncing
        if (localClock.isAfter(requesterClock)) {
            // Send updated state
            GroupStateUpdate update = createStateUpdate(localGroup, requesterClock);
            sendMessage(request.getRequesterId(), update);
        } else if (requesterClock.isAfter(localClock)) {
            // Ask for newer state
            requestStateUpdate(request.getRequesterId(), groupId);
        }
    }
    
    // Conflict resolution
    public void resolveConflict(String groupId, List<GroupStateUpdate> conflictingUpdates) {
        // Last-write-wins strategy
        GroupStateUpdate winningUpdate = conflictingUpdates.stream()
                .max(Comparator.comparing(GroupStateUpdate::getTimestamp))
                .orElse(null);
        
        if (winningUpdate != null) {
            applyStateUpdate(groupId, winningUpdate);
            // Notify others of the resolution
            broadcastConflictResolution(groupId, winningUpdate);
        }
    }
}
```

### Reliable Message Delivery

```java
public class ReliableMessageDelivery {
    private Map<String, PendingMessage> pendingMessages;
    private ScheduledExecutorService retryScheduler;
    
    public void sendReliableMessage(String targetNodeId, Message message) {
        String messageId = message.getMessageId();
        
        // Add to the pending-ACK list
        PendingMessage pending = new PendingMessage(message, targetNodeId);
        pendingMessages.put(messageId, pending);
        
        // Send the message
        sendMessage(targetNodeId, message);
        
        // Schedule retransmission
        scheduleRetransmission(messageId);
    }
    
    public void handleAcknowledgment(String messageId, String senderId) {
        PendingMessage pending = pendingMessages.remove(messageId);
        if (pending != null) {
            // Cancel retransmission timer
            pending.cancelRetransmission();
            
            // Notify app layer: message delivered
            notifyDeliveryConfirmation(messageId, senderId);
        }
    }
    
    private void scheduleRetransmission(String messageId) {
        retryScheduler.schedule(() -> {
            PendingMessage pending = pendingMessages.get(messageId);
            if (pending != null && pending.getRetryCount() < MAX_RETRIES) {
                // Retransmit
                pending.incrementRetryCount();
                sendMessage(pending.getTargetNodeId(), pending.getMessage());
                
                // Exponential backoff
                long delay = INITIAL_RETRY_DELAY * (1L << pending.getRetryCount());
                scheduleRetransmission(messageId);
            } else {
                // Max retries reached → mark as failed
                pendingMessages.remove(messageId);
                notifyDeliveryFailure(messageId);
            }
        }, INITIAL_RETRY_DELAY, TimeUnit.MILLISECONDS);
    }
}
```

### Group Message Broadcast

```java
public class GroupMessageBroadcast {
    
    // Efficient group message broadcast
    public void broadcastToGroup(String groupId, GroupMessage message) {
        Group group = getGroup(groupId);
        Set<String> members = group.getMembers();
        
        // Build a minimum spanning tree for broadcast
        SpanningTree broadcastTree = buildBroadcastTree(members);
        
        // Send to direct children
        for (String childNode : broadcastTree.getChildren(getCurrentNodeId())) {
            ForwardingInstruction instruction = new ForwardingInstruction();
            instruction.setMessage(message);
            instruction.setTargetNodes(broadcastTree.getSubtree(childNode));
            
            sendMessage(childNode, instruction);
        }
        
        // Deliver to local members of the group
        deliverToLocalMembers(groupId, message);
    }
    
    // Handle forwarding instruction
    public void handleForwardingInstruction(ForwardingInstruction instruction) {
        GroupMessage message = instruction.getMessage();
        Set<String> targetNodes = instruction.getTargetNodes();
        
        // Continue forwarding to child nodes
        for (String targetNode : targetNodes) {
            if (isDirectNeighbor(targetNode)) {
                sendMessage(targetNode, message);
            } else {
                // Further routing required
                routeMessage(targetNode, message);
            }
        }
    }
    
    // Message de-duplication
    private boolean isDuplicateMessage(GroupMessage message) {
        String messageId = message.getMessageId();
        String groupId = message.getGroupId();
        
        Set<String> seenMessages = groupMessageCache.get(groupId);
        if (seenMessages == null) {
            seenMessages = new HashSet<>();
            groupMessageCache.put(groupId, seenMessages);
        }
        
        return !seenMessages.add(messageId);
    }
}
```

### End-to-End Encryption

```java
public class EndToEndEncryption {
    
    // Encrypt private (1:1) messages
    public EncryptedMessage encryptPrivateMessage(String recipientId, String content) {
        // Fetch recipient's public key
        PublicKey recipientPublicKey = getPublicKey(recipientId);
        
        // Generate ephemeral session key
        SecretKey sessionKey = generateSessionKey();
        
        // Encrypt message content
        byte[] encryptedContent = encryptWithAES(content, sessionKey);
        
        // Encrypt session key
        byte[] encryptedSessionKey = encryptWithRSA(sessionKey.getEncoded(), recipientPublicKey);
        
        // Assemble encrypted message
        EncryptedMessage encryptedMessage = new EncryptedMessage();
        encryptedMessage.setEncryptedContent(encryptedContent);
        encryptedMessage.setEncryptedSessionKey(encryptedSessionKey);
        encryptedMessage.setSenderId(getCurrentNodeId());
        encryptedMessage.setRecipientId(recipientId);
        
        return encryptedMessage;
    }
    
    // Encrypt group messages
    public EncryptedGroupMessage encryptGroupMessage(String groupId, String content) {
        // Fetch group key
        SecretKey groupKey = getGroupKey(groupId);
        
        // Encrypt message content
        byte[] encryptedContent = encryptWithAES(content, groupKey);
        
        // Assemble encrypted group message
        EncryptedGroupMessage encryptedMessage = new EncryptedGroupMessage();
        encryptedMessage.setGroupId(groupId);
        encryptedMessage.setEncryptedContent(encryptedContent);
        encryptedMessage.setSenderId(getCurrentNodeId());
        
        return encryptedMessage;
    }
}
```

### Authentication Protocol

```java
public class DistributedAuthentication {
    
    // Node identity authentication
    public boolean authenticateNode(String nodeId, AuthenticationChallenge challenge) {
        // Fetch the node's public key
        PublicKey nodePublicKey = getPublicKey(nodeId);
        if (nodePublicKey == null) {
            return false;
        }
        
        // Verify the challenge response
        byte[] challengeData = challenge.getChallengeData();
        byte[] signature = challenge.getSignature();
        
        return verifySignature(challengeData, signature, nodePublicKey);
    }
    
    // Distributed trust evaluation
    public TrustLevel evaluateNodeTrust(String nodeId) {
        // Gather trust ratings from multiple nodes
        List<TrustRating> ratings = collectTrustRatings(nodeId);
        
        // Compute a weighted average trust score
        double trustScore = calculateWeightedTrustScore(ratings);
        
        // Factor in historical interactions
        InteractionHistory history = getInteractionHistory(nodeId);
        trustScore = adjustTrustScore(trustScore, history);
        
        return TrustLevel.fromScore(trustScore);
    }
    
    private List<TrustRating> collectTrustRatings(String nodeId) {
        List<TrustRating> ratings = new ArrayList<>();
        
        // Query neighbors for their trust assessments
        for (String neighborId : getNeighbors()) {
            TrustQuery query = new TrustQuery(nodeId);
            TrustRating rating = sendTrustQuery(neighborId, query);
            if (rating != null) {
                ratings.add(rating);
            }
        }
        
        return ratings;
    }
}
```

## 📊 Performance Optimization Strategies

### Message Caching Mechanism

```java
public class MessageCache {
    private LRUCache<String, Message> messageCache;
    private BloomFilter<String> messageFilter;
    
    public boolean isMessageCached(String messageId) {
        // Check Bloom filter first
        if (!messageFilter.mightContain(messageId)) {
            return false;
        }
        // Then confirm in the real cache
        return messageCache.containsKey(messageId);
    }
    
    public void cacheMessage(Message message) {
        String messageId = message.getMessageId();
        // Add to cache
        messageCache.put(messageId, message);
        // Add to Bloom filter
        messageFilter.put(messageId);
    }
}
```

### Load Balancing

```java
public class LoadBalancer {
    private Map<String, NodeLoad> nodeLoads;
    
    public String selectBestNode(List<String> candidates, SelectionCriteria criteria) {
        return candidates.stream()
                .min((a, b) -> compareNodes(a, b, criteria))
                .orElse(null);
    }
    
    private int compareNodes(String nodeA, String nodeB, SelectionCriteria criteria) {
        NodeLoad loadA = nodeLoads.get(nodeA);
        NodeLoad loadB = nodeLoads.get(nodeB);
        
        switch (criteria) {
            case CPU_USAGE:
                return Double.compare(loadA.getCpuUsage(), loadB.getCpuUsage());
            case MEMORY_USAGE:
                return Double.compare(loadA.getMemoryUsage(), loadB.getMemoryUsage());
            case NETWORK_LATENCY:
                return Double.compare(loadA.getNetworkLatency(), loadB.getNetworkLatency());
            case COMPOSITE:
                return Double.compare(loadA.getCompositeScore(), loadB.getCompositeScore());
            default:
                return 0;
        }
    }
}
```

## 🔧 Protocol Implementation Interfaces

```java
// Primary protocol interface
public interface OverlayNetworkProtocol {
    void joinNetwork(List<String> bootstrapNodes);
    void leaveNetwork();
    void sendMessage(String targetNodeId, Message message);
    void broadcastMessage(Message message);
    List<String> discoverNodes(int maxNodes);
    void updateRoutingTable(RoutingUpdate update);
}

// Group management interface
public interface GroupManagementProtocol {
    Group createGroup(GroupCreationRequest request);
    void joinGroup(String groupId, String invitationCode);
    void leaveGroup(String groupId);
    void sendGroupMessage(String groupId, GroupMessage message);
    void updateGroupMembership(String groupId, GroupMemberUpdate update);
}

// Fault-tolerance interface
public interface FaultToleranceProtocol {
    void detectNodeFailure(String nodeId);
    void handleNetworkPartition(List<String> partitionedNodes);
    void recoverFromFailure(FailureType failureType);
    void synchronizeState(String nodeId);
}
```

This distributed overlay network protocol provides the technical foundation for a multi-party chat system, enabling a decentralized architecture, reliable message delivery, flexible group management, and robust fault recovery. Next, we’ll implement concrete system components based on this protocol.

