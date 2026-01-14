# 🚀 Upload Folder lên GitHub - Hướng Dẫn NHANH NHẤT

## ⚡ Cách 1: GitHub CLI (NHANH NHẤT - 2 phút)

### Bước 1: Cài đặt GitHub CLI

**macOS:**
```bash
brew install gh
```

**Windows:**
```bash
# Download từ: https://cli.github.com
# Hoặc dùng winget
winget install GitHub.cli
```

**Linux:**
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

### Bước 2: Login GitHub

```bash
gh auth login
```

Chọn:
- **GitHub.com**
- **HTTPS**
- **Login with a web browser**
- Authorize trong browser

### Bước 3: Upload (1 lệnh!)

```bash
# Di chuyển vào thư mục project
cd /Users/tienluc/Downloads/docutranslate-main

# Tạo repo và push (TẤT CẢ TRONG 1 LỆNH!)
gh repo create docutranslate --public --source=. --remote=origin --push
```

**Xong!** 🎉 Repo đã được tạo và code đã được push lên GitHub!

---

## 📝 Cách 2: Git Commands Truyền Thống (3-5 phút)

### Bước 1: Khởi tạo Git (nếu chưa có)

```bash
cd /Users/tienluc/Downloads/docutranslate-main

# Kiểm tra xem đã có git chưa
git status

# Nếu chưa có, khởi tạo
git init
```

### Bước 2: Thêm tất cả files

```bash
# Thêm tất cả files
git add .

# Hoặc thêm từng file cụ thể (nếu muốn)
# git add *.py *.md *.txt
```

### Bước 3: Commit

```bash
git commit -m "Initial commit: DocuTranslate project"
```

### Bước 4: Tạo repo trên GitHub

**Option A: Qua Web (Dễ nhất)**
1. Vào [github.com](https://github.com)
2. Click **"+"** → **"New repository"**
3. Tên repo: `docutranslate` (hoặc tên bạn muốn)
4. **KHÔNG** check "Initialize with README"
5. Click **"Create repository"**

**Option B: Qua GitHub CLI**
```bash
gh repo create docutranslate --public
```

### Bước 5: Kết nối và Push

```bash
# Thêm remote (thay YOUR_USERNAME bằng username GitHub của bạn)
git remote add origin https://github.com/YOUR_USERNAME/docutranslate.git

# Hoặc dùng SSH (nếu đã setup SSH key)
# git remote add origin git@github.com:YOUR_USERNAME/docutranslate.git

# Push code lên
git branch -M main
git push -u origin main
```

**Xong!** 🎉

---

## 🔥 Cách 3: Drag & Drop (NHANH NHẤT cho người mới - 1 phút)

### Bước 1: Tạo repo trên GitHub

1. Vào [github.com](https://github.com)
2. Click **"+"** → **"New repository"**
3. Tên: `docutranslate`
4. **KHÔNG** check "Initialize with README"
5. Click **"Create repository"**

### Bước 2: Upload files

1. Vào trang repo vừa tạo
2. Click **"uploading an existing file"**
3. **Drag & drop** toàn bộ folder vào
4. Scroll xuống, nhập commit message: `Initial commit`
5. Click **"Commit changes"**

**Xong!** 🎉 (Nhưng cách này không tốt cho version control)

---

## ⚡ Quick Commands (Copy & Paste)

### Nếu chưa có git repo:

```bash
cd /Users/tienluc/Downloads/docutranslate-main
git init
git add .
git commit -m "Initial commit: DocuTranslate"
gh repo create docutranslate --public --source=. --remote=origin --push
```

### Nếu đã có git repo:

```bash
git add .
git commit -m "Add deployment configs and documentation"
git push
```

---

## 🎯 Checklist Trước Khi Upload

- [ ] Đã kiểm tra `.gitignore` (loại trừ file không cần thiết)
- [ ] Đã xóa file nhạy cảm (API keys, passwords)
- [ ] Đã test code hoạt động
- [ ] Đã commit message rõ ràng

---

## 🐛 Troubleshooting

### Lỗi: "Repository not found"

**Giải pháp:**
- Kiểm tra username/repo name đúng
- Kiểm tra đã login GitHub: `gh auth status`

### Lỗi: "Permission denied"

**Giải pháp:**
- Setup SSH key hoặc dùng HTTPS với Personal Access Token
- Hoặc dùng GitHub CLI: `gh auth login`

### Lỗi: "Large files"

**Giải pháp:**
- Kiểm tra file lớn: `git ls-files | xargs ls -la | sort -k5 -rn | head`
- Thêm vào `.gitignore` nếu không cần
- Hoặc dùng Git LFS cho file lớn

### Lỗi: "Nothing to commit"

**Giải pháp:**
- Kiểm tra files: `git status`
- Có thể files đã được ignore: check `.gitignore`

---

## 📋 .gitignore Checklist

Đảm bảo `.gitignore` có:

```
# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so
*.egg-info/
dist/
build/

# Virtual environments
venv/
env/
.venv/

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local

# Output
output/
*.log
```

---

## 🚀 Sau Khi Upload

### 1. Kiểm tra trên GitHub

Vào: `https://github.com/YOUR_USERNAME/docutranslate`

### 2. Clone về máy khác (nếu cần)

```bash
git clone https://github.com/YOUR_USERNAME/docutranslate.git
```

### 3. Deploy lên Railway/Render

Sau khi code đã trên GitHub, bạn có thể:
- Deploy lên Railway: Connect GitHub repo
- Deploy lên Render: Connect GitHub repo
- Deploy lên Vercel: Connect GitHub repo

---

## 💡 Tips

1. **GitHub CLI là nhanh nhất**: Chỉ 1 lệnh `gh repo create`
2. **Commit thường xuyên**: `git add . && git commit -m "message" && git push`
3. **Branch protection**: Setup trên GitHub để bảo vệ main branch
4. **README.md**: Luôn có README để người khác hiểu project

---

## ✅ Quick Reference

```bash
# Khởi tạo và push lần đầu
git init
git add .
git commit -m "Initial commit"
gh repo create docutranslate --public --source=. --remote=origin --push

# Update sau này
git add .
git commit -m "Update: description"
git push
```

---

**Chúc bạn upload thành công! 🎉**
