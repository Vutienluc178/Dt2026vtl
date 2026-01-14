# ⚡ Upload lên GitHub - NHANH NHẤT (1 phút)

## 🚀 Cách NHANH NHẤT: GitHub CLI

### Bước 1: Cài GitHub CLI (nếu chưa có)

**macOS:**
```bash
brew install gh
```

**Windows/Linux:**
Xem: https://cli.github.com

### Bước 2: Login

```bash
gh auth login
```

### Bước 3: Upload (1 lệnh!)

```bash
cd /Users/tienluc/Downloads/docutranslate-main
./upload-to-github.sh
```

**Hoặc thủ công:**

```bash
git add .
git commit -m "Add deployment configs"
gh repo create docutranslate --public --source=. --remote=origin --push
```

**✅ Xong!** Code đã lên GitHub!

---

## 📝 Cách 2: Git Commands (3 phút)

```bash
# 1. Thêm files
git add .

# 2. Commit
git commit -m "Initial commit: DocuTranslate"

# 3. Tạo repo trên GitHub (qua web hoặc CLI)
gh repo create docutranslate --public

# 4. Push
git remote add origin https://github.com/YOUR_USERNAME/docutranslate.git
git branch -M main
git push -u origin main
```

---

## 🎯 Nếu chưa có GitHub CLI

### Tạo repo trên GitHub Web:

1. Vào [github.com/new](https://github.com/new)
2. Tên: `docutranslate`
3. **KHÔNG** check "Initialize with README"
4. Click "Create repository"

### Sau đó chạy:

```bash
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/docutranslate.git
git branch -M main
git push -u origin main
```

---

## ✅ Checklist

- [ ] Đã cài GitHub CLI: `brew install gh`
- [ ] Đã login: `gh auth login`
- [ ] Đã chạy script: `./upload-to-github.sh`

---

**Xem hướng dẫn chi tiết**: [GITHUB_UPLOAD.md](./GITHUB_UPLOAD.md)
