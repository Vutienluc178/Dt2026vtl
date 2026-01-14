# 🚂 Hướng dẫn Chi Tiết Deploy DocuTranslate lên Railway

## 📋 Mục lục

1. [Chuẩn bị](#chuẩn-bị)
2. [Cách 1: Deploy qua GitHub (Khuyến nghị)](#cách-1-deploy-qua-github-khuyến-nghị)
3. [Cách 2: Deploy qua Railway CLI](#cách-2-deploy-qua-railway-cli)
4. [Cấu hình Environment Variables](#cấu-hình-environment-variables)
5. [Kiểm tra và Test](#kiểm-tra-và-test)
6. [Troubleshooting](#troubleshooting)
7. [Best Practices](#best-practices)

---

## 📦 Chuẩn bị

### Yêu cầu:
- ✅ Tài khoản GitHub (miễn phí)
- ✅ Code đã push lên GitHub repository
- ✅ Tài khoản Railway (đăng ký miễn phí tại [railway.app](https://railway.app))

### Kiểm tra code:

Đảm bảo các file sau đã có trong repository:

```
.
├── docutranslate/          # Application code
├── requirements.txt        # Python dependencies
├── railway.json           # Railway config (optional)
├── README.md
└── pyproject.toml
```

---

## 🚀 Cách 1: Deploy qua GitHub (Khuyến nghị)

### Bước 1: Đăng ký/Đăng nhập Railway

1. Truy cập [railway.app](https://railway.app)
2. Click **"Start a New Project"** hoặc **"Login"**
3. Chọn **"Login with GitHub"**
4. Authorize Railway để truy cập GitHub repositories

### Bước 2: Tạo Project mới

1. Sau khi login, bạn sẽ thấy Dashboard
2. Click **"New Project"** (nút màu xanh ở góc trên bên phải)
3. Chọn **"Deploy from GitHub repo"**

### Bước 3: Chọn Repository

1. Railway sẽ hiển thị danh sách repositories của bạn
2. Tìm và click vào repository chứa DocuTranslate code
3. Nếu chưa thấy, click **"Configure GitHub App"** để cấp quyền

### Bước 4: Railway Auto-Detection

Railway sẽ tự động:
- ✅ Detect Python project
- ✅ Detect FastAPI application
- ✅ Tạo build configuration
- ✅ Bắt đầu build và deploy

**Thời gian**: ~2-3 phút

### Bước 5: Cấu hình Service (Nếu cần)

Railway thường tự động detect, nhưng bạn có thể kiểm tra:

1. Click vào service vừa tạo
2. Vào tab **"Settings"**
3. Kiểm tra các settings:

**Build Command** (thường để trống - Railway tự detect):
```
(để trống hoặc: pip install -r requirements.txt)
```

**Start Command**:
```
uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
```

**Health Check Path** (optional):
```
/api/meta
```

### Bước 6: Lấy URL

1. Sau khi deploy xong, Railway sẽ tự động tạo URL
2. URL có dạng: `https://your-project-name.up.railway.app`
3. Click vào URL để mở trong browser
4. Hoặc click **"Generate Domain"** để tạo custom domain

### Bước 7: Test API

Mở browser và truy cập:
```
https://your-project-name.up.railway.app/api/meta
```

Bạn sẽ thấy response:
```json
{
  "version": "1.x.x"
}
```

**✅ Deploy thành công!**

---

## 💻 Cách 2: Deploy qua Railway CLI

### Bước 1: Cài đặt Railway CLI

**macOS/Linux:**
```bash
curl -fsSL https://railway.app/install.sh | sh
```

**Windows (PowerShell):**
```powershell
iwr https://railway.app/install.ps1 | iex
```

**Hoặc dùng npm:**
```bash
npm i -g @railway/cli
```

### Bước 2: Login

```bash
railway login
```

CLI sẽ mở browser để bạn login với GitHub.

### Bước 3: Khởi tạo Project

```bash
# Di chuyển vào thư mục project
cd /path/to/docutranslate

# Khởi tạo Railway project
railway init
```

CLI sẽ hỏi:
- **Create a new project?** → Chọn `Yes`
- **Project name?** → Nhập tên (hoặc Enter để dùng tên mặc định)

### Bước 4: Deploy

```bash
# Deploy code lên Railway
railway up
```

Railway sẽ:
1. Build application
2. Install dependencies
3. Deploy và start service

**Thời gian**: ~2-3 phút

### Bước 5: Lấy URL

```bash
# Xem URL của service
railway domain
```

Hoặc:
```bash
# Mở service trong browser
railway open
```

---

## ⚙️ Cấu hình Environment Variables

### Cách 1: Qua Railway Dashboard

1. Vào **Dashboard** → Chọn **Project** → Chọn **Service**
2. Click tab **"Variables"**
3. Click **"New Variable"**
4. Thêm các variables:

```
PORT=8010
PYTHON_VERSION=3.11
```

**Lưu ý**: Railway tự động set `PORT`, không cần set thủ công.

### Cách 2: Qua Railway CLI

```bash
# Set environment variable
railway variables set PORT=8010

# Xem tất cả variables
railway variables

# Xóa variable
railway variables unset VARIABLE_NAME
```

### Cách 3: Qua file `.env` (Local development)

Tạo file `.env` trong project root:

```env
PORT=8010
PYTHON_VERSION=3.11
```

Railway sẽ tự động load khi deploy.

---

## 🧪 Kiểm tra và Test

### 1. Health Check

```bash
curl https://your-project.up.railway.app/api/meta
```

**Expected response:**
```json
{"version": "1.x.x"}
```

### 2. Test Translation API

```bash
# Submit translation task
curl -X POST https://your-project.up.railway.app/api/service/translate/file \
  -F "file=@test.txt" \
  -F 'payload={
    "workflow_type": "txt",
    "base_url": "https://api.openai.com/v1",
    "api_key": "sk-your-key",
    "model_id": "gpt-4o",
    "to_lang": "中文"
  }'
```

**Expected response:**
```json
{
  "task_started": true,
  "task_id": "abc123",
  "message": "翻译任务已成功启动，请稍候..."
}
```

### 3. Check Status

```bash
curl https://your-project.up.railway.app/api/service/status/abc123
```

### 4. Test Web UI

Mở browser:
```
https://your-project.up.railway.app
```

Bạn sẽ thấy Web UI của DocuTranslate.

---

## 🔍 Xem Logs

### Qua Railway Dashboard

1. Vào **Service** → Tab **"Deployments"**
2. Click vào deployment mới nhất
3. Xem **"Logs"** tab

### Qua Railway CLI

```bash
# Xem logs real-time
railway logs

# Xem logs của deployment cụ thể
railway logs --deployment <deployment-id>

# Follow logs (giống tail -f)
railway logs --follow
```

---

## 🐛 Troubleshooting

### Lỗi 1: "Module not found"

**Nguyên nhân**: Dependencies chưa được install đúng.

**Giải pháp**:
1. Kiểm tra `requirements.txt` có đầy đủ dependencies
2. Vào **Settings** → **Build** → Thêm build command:
   ```
   pip install -r requirements.txt
   ```

### Lỗi 2: "Port already in use"

**Nguyên nhân**: Application không dùng `$PORT` environment variable.

**Giải pháp**:
1. Đảm bảo start command dùng `$PORT`:
   ```
   uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
   ```
2. Railway tự động set `PORT`, không cần set thủ công.

### Lỗi 3: "Application timeout"

**Nguyên nhân**: Build quá lâu hoặc application không start được.

**Giải pháp**:
1. Kiểm tra logs để xem lỗi cụ thể
2. Đảm bảo `requirements.txt` không có dependencies quá lớn
3. Kiểm tra start command đúng

### Lỗi 4: "502 Bad Gateway"

**Nguyên nhân**: Application không listen đúng port hoặc chưa start.

**Giải pháp**:
1. Kiểm tra start command:
   ```bash
   uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
   ```
2. Đảm bảo `--host 0.0.0.0` (không phải `127.0.0.1`)
3. Check logs để xem application có start không

### Lỗi 5: "Out of memory"

**Nguyên nhân**: Application dùng quá nhiều memory.

**Giải pháp**:
1. Upgrade plan (Railway Pro có nhiều memory hơn)
2. Giảm `concurrent` trong translation config
3. Giảm `chunk_size` trong translation config

### Lỗi 6: "Build failed"

**Nguyên nhân**: Build process gặp lỗi.

**Giải pháp**:
1. Xem logs chi tiết trong **Deployments** tab
2. Kiểm tra Python version (cần 3.11+)
3. Kiểm tra `requirements.txt` format đúng
4. Thử rebuild:
   ```bash
   railway up --detach
   ```

---

## 📊 Monitoring và Metrics

### Xem Metrics

1. Vào **Service** → Tab **"Metrics"**
2. Xem:
   - **CPU Usage**
   - **Memory Usage**
   - **Network I/O**
   - **Request Count**

### Set up Alerts

1. Vào **Project** → **Settings** → **Notifications**
2. Thêm email/Slack để nhận alerts khi:
   - Service down
   - High memory usage
   - Build failures

---

## 🔐 Security Best Practices

### 1. Environment Variables

**KHÔNG** commit sensitive data vào code:
- ❌ API keys
- ❌ Database passwords
- ❌ Secret tokens

**NÊN** dùng Railway Variables:
- ✅ Set qua Dashboard hoặc CLI
- ✅ Variables được encrypt
- ✅ Không hiển thị trong logs

### 2. Custom Domain với HTTPS

1. Vào **Service** → **Settings** → **Networking**
2. Click **"Generate Domain"** hoặc **"Custom Domain"**
3. Railway tự động cung cấp SSL certificate

### 3. Rate Limiting

Railway có built-in DDoS protection, nhưng bạn nên:
- Implement rate limiting trong application
- Validate và sanitize inputs
- Use authentication cho sensitive endpoints

---

## 💰 Pricing và Limits

### Free Tier ($5 credit/month)

- ✅ $5 credit mỗi tháng
- ✅ Unlimited deployments
- ✅ 512MB RAM per service
- ✅ 1GB storage
- ✅ 100GB bandwidth/month

### Pro Plan ($20/month)

- ✅ $20 credit mỗi tháng
- ✅ 8GB RAM per service
- ✅ 100GB storage
- ✅ 1TB bandwidth/month
- ✅ Priority support

### Tính toán Usage

Railway tính phí theo:
- **Compute**: RAM × Hours
- **Storage**: GB × Hours
- **Bandwidth**: GB transferred

Ví dụ với Free tier:
- 512MB RAM × 24h × 30 days = ~$3-4/month
- Còn dư ~$1-2 cho bandwidth

---

## 🚀 Advanced Configuration

### Custom Build Command

Nếu cần custom build, tạo `railway.json`:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "pip install -r requirements.txt && python setup.py build"
  },
  "deploy": {
    "startCommand": "uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### Multiple Services

Nếu cần deploy nhiều services:

1. **Service 1**: Main API
   ```
   Start Command: uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
   ```

2. **Service 2**: Worker (nếu cần)
   ```
   Start Command: python worker.py
   ```

### Database (Nếu cần)

Railway cung cấp:
- PostgreSQL
- MySQL
- MongoDB
- Redis

Thêm database:
1. **New** → **Database** → Chọn loại
2. Railway tự động set connection string trong variables
3. Application tự động connect

---

## 📝 Checklist Deploy

Trước khi deploy, đảm bảo:

- [ ] Code đã push lên GitHub
- [ ] `requirements.txt` đầy đủ dependencies
- [ ] Start command đúng (dùng `$PORT`)
- [ ] Environment variables đã set (nếu cần)
- [ ] Test local trước khi deploy
- [ ] Đã đọc logs để check errors

---

## 🎯 Quick Commands Reference

```bash
# Login
railway login

# Init project
railway init

# Deploy
railway up

# View logs
railway logs

# Open in browser
railway open

# Set variable
railway variables set KEY=value

# View variables
railway variables

# View domain
railway domain

# Connect to service shell
railway shell

# View service status
railway status
```

---

## 📚 Tài liệu tham khảo

- [Railway Documentation](https://docs.railway.app)
- [Railway Pricing](https://railway.app/pricing)
- [Railway Discord](https://discord.gg/railway) - Community support

---

## ✅ Kết luận

Railway là platform **NHANH NHẤT và DỄ NHẤT** để deploy DocuTranslate:

- ⚡ Deploy trong 2-3 phút
- 🎯 Auto-detect, không cần config phức tạp
- 💰 Free tier hào phóng ($5/month)
- 🚀 Hỗ trợ long-running tasks
- 📊 Built-in monitoring và logs

**Chúc bạn deploy thành công! 🎉**

Nếu gặp vấn đề, check:
1. Logs trong Railway Dashboard
2. Troubleshooting section ở trên
3. Railway Discord community
