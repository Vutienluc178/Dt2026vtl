# ⚡ Railway Quick Start - 3 Phút Deploy

## 🚀 Cách NHANH NHẤT (GitHub Integration)

### Bước 1: Đăng ký Railway
👉 [railway.app](https://railway.app) → Login with GitHub

### Bước 2: Deploy
1. Click **"New Project"**
2. Chọn **"Deploy from GitHub repo"**
3. Chọn repository của bạn
4. **Xong!** Railway tự động deploy (~2-3 phút)

### Bước 3: Lấy URL
Railway tự động tạo URL: `https://your-project.up.railway.app`

### Bước 4: Test
```bash
curl https://your-project.up.railway.app/api/meta
```

**✅ Done!**

---

## 💻 Hoặc dùng CLI

```bash
# Install
npm i -g @railway/cli

# Login
railway login

# Deploy
railway init
railway up

# Xem URL
railway domain
```

---

## ⚙️ Cấu hình (Nếu cần)

### Start Command (Railway tự detect, nhưng có thể set thủ công):
```
uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
```

### Environment Variables (Optional):
```
PORT=8010  # Railway tự set, không cần
PYTHON_VERSION=3.11
```

---

## 🐛 Troubleshooting

**Lỗi "Port already in use"?**
→ Đảm bảo start command dùng `$PORT`

**Lỗi "Module not found"?**
→ Kiểm tra `requirements.txt` có đầy đủ

**Lỗi "502 Bad Gateway"?**
→ Check logs: `railway logs`

---

## 📚 Xem chi tiết

👉 [RAILWAY_DEPLOY.md](./RAILWAY_DEPLOY.md) - Hướng dẫn đầy đủ

---

**Chúc bạn deploy thành công! 🎉**
