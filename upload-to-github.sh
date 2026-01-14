#!/bin/bash
# Script nhanh để upload lên GitHub

echo "🚀 Bắt đầu upload lên GitHub..."

# Kiểm tra GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI đã được cài đặt"
    
    # Kiểm tra đã login chưa
    if gh auth status &> /dev/null; then
        echo "✅ Đã login GitHub"
        
        # Thêm tất cả files
        echo "📦 Đang thêm files..."
        git add .
        
        # Commit
        echo "💾 Đang commit..."
        git commit -m "Add deployment configs and documentation" || echo "⚠️  Không có thay đổi để commit"
        
        # Tạo repo và push (nếu chưa có remote)
        if ! git remote get-url origin &> /dev/null; then
            echo "📤 Đang tạo repo trên GitHub và push..."
            gh repo create docutranslate --public --source=. --remote=origin --push
        else
            echo "📤 Đang push lên GitHub..."
            git push -u origin main || git push -u origin master
        fi
        
        echo "✅ Hoàn thành! Code đã được upload lên GitHub"
        echo "🌐 Xem tại: https://github.com/$(gh api user --jq .login)/docutranslate"
    else
        echo "❌ Chưa login GitHub. Chạy: gh auth login"
        exit 1
    fi
else
    echo "⚠️  GitHub CLI chưa được cài đặt"
    echo "📝 Sử dụng Git commands thủ công:"
    echo ""
    echo "1. Thêm files:"
    echo "   git add ."
    echo ""
    echo "2. Commit:"
    echo "   git commit -m 'Initial commit'"
    echo ""
    echo "3. Tạo repo trên GitHub (qua web), sau đó:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/docutranslate.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    exit 1
fi
