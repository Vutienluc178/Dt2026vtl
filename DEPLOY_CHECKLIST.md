# ✅ Deployment Checklist - Railway

## Trước khi Deploy

### 1. Code Preparation
- [ ] Code đã commit và push lên GitHub
- [ ] `requirements.txt` có đầy đủ dependencies
- [ ] `railway.json` đã tạo (optional nhưng recommended)
- [ ] Test local application hoạt động

### 2. Railway Account
- [ ] Đã đăng ký tài khoản Railway
- [ ] Đã login với GitHub
- [ ] Đã authorize Railway access GitHub repos

### 3. Configuration Check
- [ ] Start command đúng: `uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT`
- [ ] Application code không hardcode port
- [ ] Environment variables đã chuẩn bị (nếu cần)

---

## Trong quá trình Deploy

### 4. Deploy Steps
- [ ] Tạo new project trên Railway
- [ ] Chọn repository đúng
- [ ] Railway auto-detect thành công
- [ ] Build process không có lỗi
- [ ] Deploy thành công

### 5. Verification
- [ ] Service status: "Running"
- [ ] URL hoạt động: `https://your-project.up.railway.app`
- [ ] Health check: `GET /api/meta` trả về version
- [ ] Web UI load được: `GET /` hiển thị interface

---

## Sau khi Deploy

### 6. Testing
- [ ] Test health endpoint: `/api/meta`
- [ ] Test translation API: `/api/service/translate/file`
- [ ] Test status polling: `/api/service/status/{task_id}`
- [ ] Test download: `/api/service/download/{task_id}/{format}`

### 7. Monitoring
- [ ] Check logs không có errors
- [ ] Monitor CPU/Memory usage
- [ ] Set up alerts (optional)

### 8. Documentation
- [ ] Ghi lại URL của service
- [ ] Ghi lại environment variables đã set
- [ ] Update README với deployment info (optional)

---

## Troubleshooting Checklist

Nếu gặp lỗi, check:

- [ ] Logs trong Railway Dashboard
- [ ] Start command đúng format
- [ ] Port sử dụng `$PORT` (không hardcode)
- [ ] `requirements.txt` format đúng
- [ ] Python version 3.11+
- [ ] Application listen trên `0.0.0.0` (không phải `127.0.0.1`)

---

## Quick Commands

```bash
# Deploy
railway up

# View logs
railway logs

# Check status
railway status

# View domain
railway domain

# Set variables
railway variables set KEY=value
```

---

**✅ Hoàn thành checklist = Deploy thành công!**
