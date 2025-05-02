
# Aztec Node Setup Scripts (CLI-Based)

This repository includes a convenient `install.sh` one-hit script to help you quickly set up and run the Aztec Network components using the official Aztec CLI.

---

## 🛠️ One-liner Installation

Run this command on your Ubuntu server:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/install.sh)
```

This will:
- Clone this repository
- Prompt you to choose between Full Node / Validator / Prover
- Launch the appropriate setup script

---

## ⚠️ Important Sync Requirement

Before running **Validator** or **Prover**, your full node must be fully synced.

### 🔍 How to check sync status

Run this command to view logs:

```bash
journalctl -fu aztec-fullnode
```

Wait until you see a message like:

```
⛓️ L2 synced to block 123456
```

If your logs show ongoing syncing or older blocks, **do not run validator or prover yet**.

---

## 📦 Available Components

### 1. Aztec Full Node
- Synchronizes the Aztec blockchain.
- No validator or prover role.
- Recommended as a base layer before running validator or prover.

### 2. Aztec Validator (Sequencer)
- Submits blocks to L1 using your Ethereum Sepolia account.
- ⚠️ Your EVM wallet must have enough **Sepolia ETH** to cover gas fees.
- You will be asked to enter your private key and coinbase address.
- ❗Only run this after fullnode is synced.

### 3. Aztec Prover
- Includes broker, agent, and prover node.
- Coordinates with a validator node (usually local on port 8080).
- Also requires a Sepolia ETH-funded account for publishing proofs.
- ❗Only run this after fullnode is synced.

---

## 🧪 Prerequisites

- Ubuntu server (root or sudo access)
- Internet connection
- RPC endpoint for Ethereum Sepolia (e.g., Alchemy, Infura)
- Beacon endpoint for Sepolia (e.g., dRPC or QuickNode)
- **Sepolia ETH** in your wallet (get it from [https://sepoliafaucet.com](https://sepoliafaucet.com))

---

## 🔍 Logs

After installation, use the following to monitor:

```bash
journalctl -fu aztec-fullnode
journalctl -fu aztec-validator
journalctl -fu aztec-prover
```

---

## 🗂 File Structure

All config files and helper scripts will be saved under:

```
/root/aztec/
```

Systemd services will auto-start on boot and restart on failure.

---

## ✍️ Maintainer

Created and maintained by [smartinvest.eth](https://github.com/smartinvest-eth)

Feel free to fork or contribute.
