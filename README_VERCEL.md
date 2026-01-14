# Triển khai DocuTranslate lên Vercel

Hướng dẫn chi tiết để triển khai DocuTranslate lên Vercel Serverless Functions.

## ⚠️ Lưu ý quan trọng

Vercel có giới hạn thời gian thực thi:
- **Hobby Plan**: 10 giây
- **Pro Plan**: 60 giây  
- **Enterprise Plan**: 300 giây

Do đó, các tác vụ dịch thuật dài nên sử dụng:
1. **Async endpoints** với polling (`/service/translate` + `/service/status/{task_id}`)
2. **External queue service** (Redis Queue, AWS SQS, etc.) cho tác vụ rất dài

## 📋 Yêu cầu

1. Tài khoản Vercel (miễn phí tại [vercel.com](https://vercel.com))
2. Git repository (GitHub, GitLab, hoặc Bitbucket)
3. Python 3.11+

## 🚀 Các bước triển khai

### Bước 1: Chuẩn bị repository

Đảm bảo code đã được commit và push lên Git:

```bash
git add .
git commit -m "Add Vercel deployment configuration"
git push origin main
```

### Bước 2: Kết nối với Vercel

1. Đăng nhập vào [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New..."** → **"Project"**
3. Import repository của bạn
4. Vercel sẽ tự động phát hiện cấu hình

### Bước 3: Cấu hình Build Settings

Vercel sẽ tự động phát hiện:
- **Framework Preset**: Other
- **Build Command**: (để trống - không cần build)
- **Output Directory**: (để trống)
- **Install Command**: `pip install -r requirements-vercel.txt`

### Bước 4: Cấu hình Environment Variables (Tùy chọn)

Nếu bạn muốn đặt default values cho API keys, thêm vào Vercel Dashboard:

```
DOCUTRANSLATE_PORT=8010
```

**Lưu ý**: Không nên hardcode API keys trong code. Người dùng nên truyền qua request body.

### Bước 5: Deploy

Click **"Deploy"** và chờ quá trình build hoàn tất.

## 📝 Cấu trúc file

```
.
├── api/
│   └── index.py          # Vercel serverless function entry point
├── vercel.json           # Vercel configuration
├── requirements-vercel.txt  # Python dependencies
├── .vercelignore        # Files to exclude from deployment
└── docutranslate/       # Application code
```

## 🔧 Cấu hình nâng cao

### Tăng thời gian timeout (Pro/Enterprise)

Trong `vercel.json`, bạn có thể tăng `maxDuration`:

```json
{
  "functions": {
    "api/index.py": {
      "maxDuration": 300,  // 5 minutes (Enterprise only)
      "memory": 3008
    }
  }
}
```

### Tối ưu kích thước deployment

File `.vercelignore` đã loại trừ các file không cần thiết. Nếu cần tối ưu thêm:

1. Loại bỏ `docling` dependencies (đã loại trong `requirements-vercel.txt`)
2. Sử dụng Vercel's edge caching cho static files
3. Consider using external storage cho temporary files

## 🌐 Sử dụng API

Sau khi deploy, bạn sẽ nhận được URL như: `https://your-project.vercel.app`

### Endpoints chính:

1. **Health check**: `GET https://your-project.vercel.app/api/meta`
2. **Submit translation**: `POST https://your-project.vercel.app/api/service/translate/file`
3. **Check status**: `GET https://your-project.vercel.app/api/service/status/{task_id}`
4. **Download result**: `GET https://your-project.vercel.app/api/service/download/{task_id}/{format}`

### Ví dụ sử dụng:

```bash
# 1. Submit translation task
curl -X POST https://your-project.vercel.app/api/service/translate/file \
  -F "file=@document.pdf" \
  -F 'payload={"workflow_type":"auto","base_url":"https://api.openai.com/v1","api_key":"sk-xxx","model_id":"gpt-4o","to_lang":"中文"}'

# Response: {"task_started": true, "task_id": "abc123", ...}

# 2. Poll for status
curl https://your-project.vercel.app/api/service/status/abc123

# 3. Download when ready
curl https://your-project.vercel.app/api/service/download/abc123/html -o result.html
```

## ⚡ Tối ưu hiệu suất

### 1. Sử dụng Async Endpoints

Luôn sử dụng async endpoints (`/service/translate`) thay vì sync (`/service/flat-translate`) để tránh timeout.

### 2. File Size Limits

Vercel có giới hạn:
- Request body: 4.5MB (Hobby), 4.5MB (Pro)
- Function size: 50MB (uncompressed)

Cho file lớn, nên:
- Upload file lên cloud storage (S3, Cloudinary)
- Truyền URL thay vì file content
- Hoặc sử dụng chunked upload

### 3. Memory Management

Vercel Pro cung cấp tối đa 3008MB memory. Với file lớn, có thể cần:
- Giảm `chunk_size` trong translation config
- Sử dụng streaming cho large files
- Cleanup temporary files ngay sau khi xong

## 🐛 Troubleshooting

### Lỗi: "Function exceeded maximum duration"

**Giải pháp**: 
- Sử dụng async endpoints với polling
- Giảm file size hoặc chunk size
- Upgrade lên Pro plan (60s) hoặc Enterprise (300s)

### Lỗi: "Module not found"

**Giải pháp**:
- Kiểm tra `requirements-vercel.txt` có đủ dependencies
- Đảm bảo `docutranslate` package được include trong deployment

### Lỗi: "Memory limit exceeded"

**Giải pháp**:
- Giảm concurrent requests
- Giảm chunk_size
- Upgrade memory limit (Pro plan)

## 📚 Tài liệu tham khảo

- [Vercel Python Documentation](https://vercel.com/docs/functions/serverless-functions/runtimes/python)
- [Mangum Documentation](https://mangum.io/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)

## 💡 Tips

1. **Development**: Test locally với `vercel dev` trước khi deploy
2. **Monitoring**: Sử dụng Vercel Analytics để theo dõi performance
3. **Logging**: Check Vercel Function Logs trong dashboard
4. **Caching**: Sử dụng Vercel Edge Network cho static assets

## 🔐 Security

- Không commit API keys vào repository
- Sử dụng Environment Variables trong Vercel Dashboard
- Validate và sanitize user inputs
- Implement rate limiting cho production

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Check Vercel Function Logs
2. Review error messages trong deployment logs
3. Tạo issue trên GitHub repository

---

**Chúc bạn deploy thành công! 🎉**
