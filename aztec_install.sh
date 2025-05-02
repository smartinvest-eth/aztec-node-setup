#!/bin/bash
# aztec_install.sh - Tải và chạy các thành phần Aztec

# 1. Dọn thư mục cũ nếu có
echo "🔧 Đang clone repository..."
if [ -d "/tmp/aztec-node-setup" ]; then
  echo "⚠️ Thư mục /tmp/aztec-node-setup đã tồn tại. Đang xoá..."
  rm -rf /tmp/aztec-node-setup
fi

git clone https://github.com/smartinvest-eth/aztec-node-setup.git /tmp/aztec-node-setup
cd /tmp/aztec-node-setup || exit 1

# 2. Menu chọn
echo ""
echo "🌐 Vui lòng chọn thành phần muốn cài đặt:"
echo "1) Aztec Full Node"
echo "2) Aztec Validator (Sequencer)"
echo "3) Aztec Prover"
read -p "Nhập lựa chọn (1/2/3): " choice

case "$choice" in
  1)
    echo "⚙️ Cài đặt Full Node..."
    chmod +x aztec_fullnode.sh
    bash ./aztec_fullnode.sh
    ;;
  2)
    echo "⚙️ Cài đặt Validator..."
    chmod +x aztec_validator.sh
    bash ./aztec_validator.sh
    ;;
  3)
    echo "⚙️ Cài đặt Prover..."
    chmod +x aztec_prover.sh
    bash ./aztec_prover.sh
    ;;
  *)
    echo "❌ Lựa chọn không hợp lệ. Thoát."
    exit 1
    ;;
esac
