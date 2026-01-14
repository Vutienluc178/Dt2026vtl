# 🚀 Quick Start: Deploy to Vercel

## Bước 1: Cài đặt Vercel CLI (tùy chọn)

```bash
npm i -g vercel
```

## Bước 2: Deploy

### Option A: Sử dụng Vercel CLI

```bash
# Login
vercel login

# Deploy
vercel

# Deploy production
vercel --prod
```

### Option B: Sử dụng Vercel Dashboard

1. Truy cập [vercel.com](https://vercel.com)
2. Import Git repository
3. Vercel sẽ tự động detect cấu hình
4. Click "Deploy"

## Bước 3: Test API

```bash
# Health check
curl https://your-project.vercel.app/api/meta

# Submit translation
curl -X POST https://your-project.vercel.app/api/service/translate/file \
  -F "file=@test.txt" \
  -F 'payload={"workflow_type":"txt","base_url":"https://api.openai.com/v1","api_key":"sk-xxx","model_id":"gpt-4o","to_lang":"中文"}'
```

## ⚠️ Lưu ý

- **Timeout**: Hobby plan chỉ có 10s, Pro có 60s
- **File size**: Max 4.5MB request body
- **Memory**: Max 3008MB (Pro plan)

## 📚 Xem thêm

Chi tiết đầy đủ: [README_VERCEL.md](./README_VERCEL.md)
