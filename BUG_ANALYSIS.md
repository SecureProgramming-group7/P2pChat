# P2P Chat Application — Issue Analysis and Fix Plan

## 🐛 Issues Identified

### 1. Online Members Display

* **Symptom:** The online members list always shows only one member.
* **Cause:** Member info isn’t properly broadcast when a node joins, or the de-duplication logic is faulty.

### 2. Duplicate Messages

* **Symptom:** When 8081 sends a message, 8080 receives it twice.
* **Cause:** The forwarding logic sends duplicates, possibly because:

  * The message is both processed locally and forwarded.
  * De-duplication is missing in the forwarding path.

### 3. Self Private Message

* **Symptom:** A user can start a private chat with themselves.
* **Cause:** The user list includes the local node’s ID and doesn’t filter it out.

### 4. Username Display

* **Symptom:** Usernames appear as long numeric strings.
* **Cause:** The full node ID is used as the display name instead of a shortened, friendly label.

## 🔧 Remediation Plan

### 1. Fix Node ID Display

* Provide user-friendly display names (e.g., `Node_8080`, `Node_8081`).
* Keep the full node ID internally for identification.

### 2. Eliminate Duplicate Messages

* Add a message de-duplication mechanism.
* Correct the forwarding flow to avoid double-processing.

### 3. Correct the Members List

* Filter out the local node from the list.
* Repair join/leave broadcasting logic.

### 4. Improve UX

* Use the port number as the displayed username.
* Attach message IDs to prevent duplicates.
* Improve online presence/state management.

## 📋 Concrete Fix Steps

1. **Modify `Node.java`:**

   * Add a `getDisplayName()` method.
   * Fix member broadcast logic.

2. **Modify `MessageRouter.java`:**

   * Implement message de-duplication.
   * Correct the forwarding logic.

3. **Modify `EnhancedChatController.java`:**

   * Filter out the local node.
   * Use the display name instead of the full ID.

4. **Modify `OnlineMember.java`:**

   * Add a `displayName` field.
   * Improve `equals` and `hashCode` implementations.
