#!/bin/bash
#!/bin/bash
# Khởi chạy Aztec Validator (Sequencer)

echo "==== CẤU HÌNH AZTEC VALIDATOR (SEQUENCER) ===="

AZTEC_DIR="/root/aztec"
ENV_FILE="${AZTEC_DIR}/aztec-validator.env"
mkdir -p "$AZTEC_DIR"

read -p "RPC_URL (Execution Sepolia RPC endpoint): " RPC_URL
read -p "BEACON_URL (Consensus Sepolia Beacon endpoint): " BEACON_URL
read -p "ETH_PRIVATE_KEY (0x...): " ETH_PRIVATE_KEY
read -p "COINBASE_ADDRESS (0x...): " COINBASE_ADDRESS
PUBLIC_IP="$(curl -s ipv4.icanhazip.com)"

cat > "${ENV_FILE}" <<EOF
RPC_URL="${RPC_URL}"
BEACON_URL="${BEACON_URL}"
ETH_PRIVATE_KEY="${ETH_PRIVATE_KEY}"
COINBASE_ADDRESS="${COINBASE_ADDRESS}"
PUBLIC_IP="${PUBLIC_IP}"
EOF

START_SCRIPT="${AZTEC_DIR}/aztec-validator.sh"
cat > "${START_SCRIPT}" <<EOF
#!/bin/bash
source "${ENV_FILE}"
/root/.aztec/bin/aztec start \
  --node \
  --archiver \
  --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "\${RPC_URL}" \
  --l1-consensus-host-urls "\${BEACON_URL}" \
  --sequencer.validatorPrivateKey "\${ETH_PRIVATE_KEY}" \
  --sequencer.coinbase "\${COINBASE_ADDRESS}" \
  --p2p.p2pIp "\${PUBLIC_IP}"
EOF
chmod +x "${START_SCRIPT}"

cat > /etc/systemd/system/aztec-validator.service <<EOF
[Unit]
Description=Aztec Validator Node
After=network.target

[Service]
User=root
EnvironmentFile=${ENV_FILE}
ExecStart=${START_SCRIPT}
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable aztec-validator
systemctl start aztec-validator

echo "✅ Aztec validator đã được cài và khởi chạy!"
