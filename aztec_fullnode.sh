#!/bin/bash
#!/bin/bash
# Cài đặt và khởi chạy Aztec Full Node (chỉ đồng bộ blockchain)

echo "==== CÀI ĐẶT AZTEC FULL NODE ===="

# 1. Cài Aztec CLI
echo "🔧 Cài đặt Aztec CLI..."
bash -i <(curl -s https://install.aztec.network)

# 2. Nhập cấu hình RPC
read -p "RPC_URL (Execution Sepolia RPC endpoint): " RPC_URL
read -p "BEACON_URL (Consensus Sepolia Beacon endpoint): " BEACON_URL

# 3. Lưu biến môi trường
AZTEC_DIR="/root/aztec"
mkdir -p "$AZTEC_DIR"
ENV_FILE="${AZTEC_DIR}/aztec-fullnode.env"

cat > "${ENV_FILE}" <<EOF
RPC_URL="${RPC_URL}"
BEACON_URL="${BEACON_URL}"
EOF

# 4. Script chạy node
START_SCRIPT="${AZTEC_DIR}/aztec-fullnode.sh"
cat > "${START_SCRIPT}" <<EOF
#!/bin/bash
source "${ENV_FILE}"
/root/.aztec/bin/aztec start \
  --node \
  --archiver \
  --network alpha-testnet \
  --l1-rpc-urls "\${RPC_URL}" \
  --l1-consensus-host-urls "\${BEACON_URL}"
EOF
chmod +x "${START_SCRIPT}"

# 5. systemd service
cat > /etc/systemd/system/aztec-fullnode.service <<EOF
[Unit]
Description=Aztec Full Node
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

# 6. Khởi động
systemctl daemon-reload
systemctl enable aztec-fullnode
systemctl start aztec-fullnode

echo "✅ Aztec full node đã được cài đặt và chạy nền."
echo "📡 Kiểm tra log bằng: journalctl -fu aztec-fullnode"
