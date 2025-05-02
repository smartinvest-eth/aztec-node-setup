#!/bin/bash
#!/bin/bash
# install.sh - Script để tải và chạy các thành phần Aztec từ GitHub

echo "🔧 Đang clone repository..."
git clone https://github.com/smartinvest-eth/aztec-node-setup.git /tmp/aztec-node-setup
cd /tmp/aztec-node-setup || exit 1

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
    sudo ./aztec_fullnode.sh
    ;;
  2)
    echo "⚙️ Cài đặt Validator..."
    chmod +x aztec_validator.sh
    sudo ./aztec_validator.sh
    ;;
  3)
    echo "⚙️ Cài đặt Prover..."
    chmod +x aztec_prover.sh
    sudo ./aztec_prover.sh
    ;;
  *)
    echo "❌ Lựa chọn không hợp lệ. Thoát."
    exit 1
    ;;
esac
