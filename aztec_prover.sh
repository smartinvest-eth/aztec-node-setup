#!/bin/bash
#!/bin/bash
# Cài và chạy Aztec Prover (broker + agent + node)

echo "==== CẤU HÌNH AZTEC PROVER ===="

AZTEC_DIR="/root/aztec"
ENV_FILE="${AZTEC_DIR}/aztec-prover.env"
mkdir -p "$AZTEC_DIR"

read -p "ETH_PRIVATE_KEY (0x...): " ETH_PRIVATE_KEY
read -p "Validator Endpoint (e.g., http://localhost:8080): " COORD_NODE_URL

cat > "${ENV_FILE}" <<EOF
ETH_PRIVATE_KEY="${ETH_PRIVATE_KEY}"
PROVER_COORDINATION_NODE_URL="${COORD_NODE_URL}"
PROVER_BROKER_HOST="http://localhost:8081"
EOF

RUN_SCRIPT="${AZTEC_DIR}/aztec-prover-run.sh"
cat > "${RUN_SCRIPT}" <<EOF
#!/bin/bash
source "${ENV_FILE}"
/root/aztec/aztec start --prover-broker --network alpha-testnet --port 8081 &
sleep 2
/root/aztec/aztec start --prover-agent --network alpha-testnet --port 8083 &
sleep 2
exec aztec start --prover-node --archiver --network alpha-testnet --port 8082 \
  --prover.publisherPrivateKey "\${ETH_PRIVATE_KEY}" \
  --prover.coordinationNodeUrl "\${PROVER_COORDINATION_NODE_URL}" \
  --prover.brokerHost "\${PROVER_BROKER_HOST}"
EOF
chmod +x "${RUN_SCRIPT}"

cat > /etc/systemd/system/aztec-prover.service <<EOF
[Unit]
Description=Aztec Prover Node
After=network.target aztec-validator.service

[Service]
User=root
EnvironmentFile=${ENV_FILE}
ExecStart=${RUN_SCRIPT}
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable aztec-prover
systemctl start aztec-prover

echo "✅ Aztec prover đã được khởi chạy!"
