# 📖 Railway Deploy - Hướng Dẫn Từng Bước (Có Hình Ảnh Mô Tả)

## 🎯 Mục tiêu

Deploy DocuTranslate lên Railway trong **3 phút** với **0 config phức tạp**.

---

## 📸 Bước 1: Đăng ký Railway

### 1.1. Truy cập Railway

Mở browser và vào: **https://railway.app**

Bạn sẽ thấy màn hình:

```
┌─────────────────────────────────────┐
│  🚂 Railway                         │
│                                     │
│  [Start a New Project]              │
│  [Login]                            │
└─────────────────────────────────────┘
```

### 1.2. Click "Start a New Project" hoặc "Login"

### 1.3. Chọn "Login with GitHub"

Railway sẽ redirect đến GitHub để authorize.

**Lưu ý**: Bạn cần có tài khoản GitHub (miễn phí).

---

## 📸 Bước 2: Tạo Project

### 2.1. Sau khi login, bạn thấy Dashboard

```
┌─────────────────────────────────────┐
│  Dashboard                          │
│                                     │
│  [New Project]  ← Click đây       │
│                                     │
│  Recent Projects:                   │
│  (empty)                            │
└─────────────────────────────────────┘
```

### 2.2. Click "New Project"

Bạn sẽ thấy menu:

```
┌─────────────────────────────────────┐
│  Create New Project                 │
│                                     │
│  ○ Empty Project                    │
│  ● Deploy from GitHub repo  ← Chọn │
│  ○ Deploy a Template                │
└─────────────────────────────────────┘
```

### 2.3. Chọn "Deploy from GitHub repo"

---

## 📸 Bước 3: Chọn Repository

### 3.1. Railway hiển thị danh sách repositories

```
┌─────────────────────────────────────┐
│  Select Repository                  │
│                                     │
│  🔍 Search repositories...          │
│                                     │
│  📁 username/docutranslate  ← Chọn │
│  📁 username/other-repo            │
│  📁 username/another-repo          │
└─────────────────────────────────────┘
```

### 3.2. Tìm và click vào repository chứa DocuTranslate code

**Lưu ý**: 
- Nếu chưa thấy repo, click **"Configure GitHub App"**
- Cấp quyền cho Railway truy cập repositories

### 3.3. Railway tự động bắt đầu deploy

Bạn sẽ thấy:

```
┌─────────────────────────────────────┐
│  Deploying...                       │
│                                     │
│  ⏳ Building...                     │
│  ⏳ Installing dependencies...      │
│  ⏳ Starting service...              │
│                                     │
│  This may take 2-3 minutes          │
└─────────────────────────────────────┘
```

**Đợi 2-3 phút** ⏱️

---

## 📸 Bước 4: Deploy Hoàn Tất

### 4.1. Khi deploy xong, bạn thấy:

```
┌─────────────────────────────────────┐
│  ✅ Deployment Successful            │
│                                     │
│  Service: docutranslate            │
│  Status: Running                   │
│                                     │
│  🌐 https://docutranslate.up.railway.app │
│                                     │
│  [View Logs] [Settings] [Metrics]  │
└─────────────────────────────────────┘
```

### 4.2. Copy URL

URL có dạng: `https://your-project-name.up.railway.app`

---

## 📸 Bước 5: Kiểm Tra

### 5.1. Test Health Endpoint

Mở browser hoặc terminal:

```bash
curl https://your-project.up.railway.app/api/meta
```

**Expected response:**
```json
{
  "version": "1.x.x"
}
```

✅ **Nếu thấy response này = Deploy thành công!**

### 5.2. Test Web UI

Mở browser:
```
https://your-project.up.railway.app
```

Bạn sẽ thấy Web UI của DocuTranslate.

---

## ⚙️ Bước 6: Cấu Hình (Optional)

### 6.1. Custom Domain (Nếu muốn)

1. Vào **Service** → **Settings** → **Networking**
2. Click **"Generate Domain"** hoặc **"Custom Domain"**
3. Railway tự động cung cấp SSL

### 6.2. Environment Variables (Nếu cần)

1. Vào **Service** → **Variables** tab
2. Click **"New Variable"**
3. Thêm:
   ```
   KEY: PYTHON_VERSION
   VALUE: 3.11
   ```

**Lưu ý**: Railway tự động set `PORT`, không cần set thủ công.

---

## 🎯 Cấu Hình Start Command (Nếu Railway không auto-detect)

### Nếu Railway không tự động detect:

1. Vào **Service** → **Settings** → **Deploy**
2. Tìm **"Start Command"**
3. Set:
   ```
   uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
   ```
4. Click **"Save"**
5. Railway sẽ tự động redeploy

---

## 📊 Xem Logs

### Cách 1: Qua Dashboard

1. Vào **Service** → **Deployments** tab
2. Click vào deployment mới nhất
3. Xem **"Logs"** tab

### Cách 2: Qua CLI

```bash
railway logs
```

---

## 🐛 Troubleshooting

### ❌ Lỗi: "Module not found"

**Nguyên nhân**: Dependencies chưa install

**Giải pháp**:
1. Vào **Settings** → **Build**
2. Thêm Build Command:
   ```
   pip install -r requirements.txt
   ```
3. Redeploy

### ❌ Lỗi: "Port already in use"

**Nguyên nhân**: Start command không dùng `$PORT`

**Giải pháp**:
1. Vào **Settings** → **Deploy**
2. Set Start Command:
   ```
   uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
   ```
3. Redeploy

### ❌ Lỗi: "502 Bad Gateway"

**Nguyên nhân**: Application không start được

**Giải pháp**:
1. Check logs: `railway logs`
2. Đảm bảo start command đúng
3. Đảm bảo `--host 0.0.0.0` (không phải `127.0.0.1`)

### ❌ Lỗi: "Build failed"

**Nguyên nhân**: Build process gặp lỗi

**Giải pháp**:
1. Xem logs chi tiết
2. Kiểm tra `requirements.txt` format
3. Kiểm tra Python version (cần 3.11+)

---

## ✅ Checklist

Sau khi deploy, đảm bảo:

- [ ] Service status: "Running"
- [ ] URL hoạt động
- [ ] `/api/meta` trả về version
- [ ] Web UI load được
- [ ] Logs không có errors

---

## 🎉 Hoàn Thành!

Bạn đã deploy thành công DocuTranslate lên Railway! 🚂

**URL của bạn**: `https://your-project.up.railway.app`

---

## 📚 Tài Liệu Tham Khảo

- **Hướng dẫn đầy đủ**: [RAILWAY_DEPLOY.md](./RAILWAY_DEPLOY.md)
- **Quick start**: [RAILWAY_QUICKSTART.md](./RAILWAY_QUICKSTART.md)
- **Checklist**: [DEPLOY_CHECKLIST.md](./DEPLOY_CHECKLIST.md)
- **Railway Docs**: https://docs.railway.app

---

## 💡 Tips

1. **Auto-deploy**: Railway tự động deploy khi bạn push code lên GitHub
2. **Logs**: Luôn check logs khi gặp lỗi
3. **Metrics**: Monitor CPU/Memory trong Metrics tab
4. **Free tier**: $5 credit/tháng, đủ cho testing

---

**Chúc bạn deploy thành công! 🎉**
