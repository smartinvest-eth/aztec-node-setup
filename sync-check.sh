#!/bin/bash
#!/bin/bash
# Script kiểm tra trạng thái sync của Aztec Full Node

echo "🔍 Đang kiểm tra trạng thái đồng bộ Aztec L2..."

if ! systemctl is-active --quiet aztec-fullnode; then
  echo "❌ Dịch vụ aztec-fullnode không đang chạy. Vui lòng khởi động trước."
  exit 1
fi

journalctl -u aztec-fullnode | grep "L2 synced to block" | tail -n 5
echo ""
echo "✅ Nếu block đang cập nhật liên tục và không bị kẹt, fullnode đang hoạt động bình thường."
