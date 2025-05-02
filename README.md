
# Aztec Node Setup Scripts (CLI-Based)

This repository includes 3 one-hit scripts to help you quickly set up and run the Aztec Network components using the official Aztec CLI:

## Scripts

### 1. `aztec_fullnode.sh`
- Sets up and starts an **Aztec full node** (synchronizes the chain only).
- Does **not** run validator or prover.
- Useful as a foundation before running validator/prover.

### 2. `aztec_validator.sh`
- Runs an **Aztec sequencer (validator)** node.
- Requires full node sync and an Ethereum Sepolia wallet with sufficient ETH for submitting blocks.

### 3. `aztec_prover.sh`
- Runs an **Aztec prover**, including broker, agent, and prover node.
- Requires coordination with a validator node.

---

## Prerequisites

- Ubuntu server with `sudo` access.
- Internet connection.
- **An Ethereum Sepolia wallet with sufficient testnet ETH** (used for submitting transactions as validator or prover).
  - You can request Sepolia ETH from a faucet like [https://sepoliafaucet.com](https://sepoliafaucet.com)

---

## How to Use

### 🔹 1. Run Full Node

```bash
chmod +x aztec_fullnode.sh
sudo ./aztec_fullnode.sh
```

You'll be prompted for:
- Execution RPC URL (e.g., from Infura, Alchemy)
- Beacon/Consensus RPC URL (e.g., from dRPC)

This node will sync the Aztec blockchain and provide data availability.

---

### 🔹 2. Run Validator

```bash
chmod +x aztec_validator.sh
sudo ./aztec_validator.sh
```

You'll be prompted for:
- RPC URL & Beacon URL
- Your Ethereum Sepolia private key
- Your coinbase address (where rewards go)

⚠️ **Important:** Make sure this wallet has Sepolia ETH!

---

### 🔹 3. Run Prover

```bash
chmod +x aztec_prover.sh
sudo ./aztec_prover.sh
```

You'll be prompted for:
- Your Ethereum Sepolia private key
- The internal URL of your validator node (e.g., `http://localhost:8080`)

---

## Logs

You can monitor each service with:

```bash
journalctl -fu aztec-fullnode
journalctl -fu aztec-validator
journalctl -fu aztec-prover
```

---

## Notes

- All configuration and helper scripts are stored under: `/root/aztec`
- Services are registered under systemd and auto-start on boot

---

## Author

Script maintained by [smartinvest.eth](https://github.com/smartinvest-eth)
