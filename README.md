
# Aztec Node Setup Scripts (CLI-Based)

This repository includes one-hit scripts to help you quickly set up and run the Aztec Network components using the official Aztec CLI.

---

## 🛠️ Quick Install (Interactive)

Run this command on your Ubuntu server:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/aztec_install.sh)
```

This will:
- Clone this repository
- Prompt you to choose between Full Node / Validator / Prover
- Launch the appropriate setup script

---

## ⚠️ Important: Check Sync Before Validator or Prover

Before running **Validator** or **Prover**, your Full Node must be fully synced.

### 🔍 Option 1: Check via logs

```bash
journalctl -fu aztec-fullnode
```

Look for:

```
⛓️ L2 synced to block ######
```

If it's still syncing or stuck, **wait before running validator or prover**.

---

### ✅ Option 2: Use `sync-check.sh`

You can also run:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/sync-check.sh)
```

This script will:
- Show the latest synced block
- Warn if the fullnode service is not running

---

## 📦 Available Components

### 🔹 Full Node

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/aztec_fullnode.sh)
```

- Syncs the Aztec L2 blockchain
- Does not produce blocks or proofs

---

### 🔹 Validator (Sequencer)

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/aztec_validator.sh)
```

- Proposes blocks to Aztec L2 and submits to Ethereum Sepolia
- Requires Sepolia ETH in your wallet to pay gas
- ❗ Run **only after full node is fully synced**

---

### 🔹 Prover

```bash
bash <(curl -sSL https://raw.githubusercontent.com/smartinvest-eth/aztec-node-setup/main/aztec_prover.sh)
```

- Creates ZK proofs to validate blocks
- Requires Sepolia ETH and connection to validator (e.g. `http://localhost:8080`)
- ❗ Run **only after full node is fully synced**

---

## 🧪 Prerequisites

- Ubuntu server (root or sudo access)
- Stable internet connection
- Sepolia RPC URL (e.g., Infura, Alchemy)
- Sepolia Beacon URL (e.g., dRPC, QuickNode)
- Ethereum Sepolia wallet with enough **Sepolia ETH**
  - Get ETH from [https://sepoliafaucet.com](https://sepoliafaucet.com)

---

## 🗂 Files & Services

- All configurations are stored under `/root/aztec`
- Each script registers a systemd service:
  - `aztec-fullnode`
  - `aztec-validator`
  - `aztec-prover`

To monitor logs:
```bash
journalctl -fu aztec-fullnode
journalctl -fu aztec-validator
journalctl -fu aztec-prover
```

---

## ✍️ Maintainer

Made with ❤️ by [smartinvest.eth](https://github.com/smartinvest-eth)

Feel free to fork or contribute!
