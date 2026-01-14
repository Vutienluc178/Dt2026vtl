# 📋 Tổng Hợp Chức Năng DocuTranslate

## 🎯 Tổng Quan

**DocuTranslate** là một công cụ dịch thuật tài liệu dựa trên **Large Language Models (LLM)**. Ứng dụng có thể dịch nhiều loại file khác nhau sang ngôn ngữ khác, giữ nguyên định dạng và hỗ trợ nhiều tính năng nâng cao.

---

## 🌟 Chức Năng Chính

### 1. 📄 Dịch Thuật Đa Định Dạng

DocuTranslate hỗ trợ dịch thuật **10+ loại file**:

| Định Dạng | Mô Tả | Giữ Nguyên Format? |
|-----------|-------|---------------------|
| **PDF** | Tài liệu PDF, sách, báo cáo | ❌ (chuyển sang Markdown) |
| **DOCX** | Microsoft Word documents | ✅ Có |
| **XLSX** | Microsoft Excel spreadsheets | ✅ Có |
| **TXT** | Plain text files | ✅ Có |
| **MD** | Markdown files | ✅ Có |
| **JSON** | JSON data files | ✅ Có (selective translation) |
| **EPUB** | E-book files | ✅ Có |
| **SRT** | Subtitle files | ✅ Có |
| **ASS** | Advanced SubStation Alpha subtitles | ✅ Có |
| **PPTX** | PowerPoint presentations | ✅ Có |
| **HTML** | Web pages | ✅ Có |

**Ví dụ sử dụng:**
```python
# Dịch file Word
result = client.translate("document.docx", to_lang="Tiếng Việt")
result.save(fmt="docx")  # Giữ nguyên format Word

# Dịch file Excel
result = client.translate("spreadsheet.xlsx", to_lang="English")
result.save(fmt="xlsx")  # Giữ nguyên format Excel
```

---

### 2. 🤖 Hỗ Trợ Nhiều AI Platform

DocuTranslate hỗ trợ **15+ AI platforms**:

- ✅ **OpenAI** (GPT-4, GPT-3.5)
- ✅ **Anthropic** (Claude)
- ✅ **Google** (Gemini)
- ✅ **Zhipu AI** (智谱AI)
- ✅ **Alibaba Cloud** (通义千问)
- ✅ **Tencent** (混元)
- ✅ **Volcengine** (豆包)
- ✅ **DeepSeek**
- ✅ **SiliconFlow**
- ✅ **Ollama** (Local LLM)
- ✅ **LM Studio** (Local LLM)
- ✅ **302.AI**
- ✅ **OpenRouter**
- ✅ **DMXAPI**
- ✅ **Juguang AI**
- ✅ Và nhiều platform khác...

**Ví dụ:**
```python
# Sử dụng OpenAI
client = Client(
    base_url="https://api.openai.com/v1",
    api_key="sk-xxx",
    model_id="gpt-4o"
)

# Sử dụng Zhipu AI
client = Client(
    base_url="https://open.bigmodel.cn/api/paas/v4",
    api_key="your-key",
    model_id="glm-4-air"
)
```

---

### 3. 📊 PDF Nâng Cao - Nhận Diện Bảng, Công Thức, Code

DocuTranslate có thể nhận diện và dịch:

- ✅ **Bảng (Tables)**: Giữ nguyên cấu trúc bảng
- ✅ **Công thức toán học (Formulas)**: OCR và dịch công thức
- ✅ **Code blocks**: Nhận diện và dịch code comments
- ✅ **Hình ảnh**: OCR cho PDF scan

**PDF Parsing Engines:**
- **MinerU** (Online/Offline) - Khuyến nghị
- **Docling** (Local) - Cần cài đặt thêm

**Ví dụ:**
```python
# Dịch PDF với công thức
result = client.translate(
    "paper.pdf",
    convert_engine="mineru",
    formula_ocr=True,  # Bật nhận diện công thức
    code_ocr=True      # Bật nhận diện code
)
```

---

### 4. 📚 Tự Động Tạo Thuật Ngữ (Glossary)

DocuTranslate có thể tự động tạo và sử dụng thuật ngữ để đảm bảo tính nhất quán:

**Tính năng:**
- ✅ Tự động phát hiện thuật ngữ trong tài liệu
- ✅ Tạo glossary từ tài liệu
- ✅ Sử dụng glossary để dịch nhất quán
- ✅ Hỗ trợ custom glossary (từ điển riêng)

**Ví dụ:**
```python
# Tự động tạo glossary
client = Client(
    glossary_generate_enable=True,
    to_lang="Tiếng Việt"
)

# Hoặc dùng glossary có sẵn
client = Client(
    glossary_dict={
        "API": "Giao diện lập trình ứng dụng",
        "SDK": "Bộ công cụ phát triển phần mềm"
    }
)
```

---

### 5. 🎨 Giữ Nguyên Định Dạng

DocuTranslate có thể dịch và **giữ nguyên format** cho:

- ✅ **Word (DOCX)**: Font, màu sắc, bảng, hình ảnh
- ✅ **Excel (XLSX)**: Format cells, formulas, charts
- ✅ **PowerPoint (PPTX)**: Slides, animations
- ✅ **EPUB**: E-book formatting
- ✅ **HTML**: Web page structure

**Insert Modes:**
- `replace`: Thay thế nội dung gốc
- `append`: Thêm bản dịch vào cuối
- `prepend`: Thêm bản dịch vào đầu

**Ví dụ:**
```python
# Dịch Word và giữ format
result = client.translate(
    "document.docx",
    insert_mode="replace"  # Thay thế nội dung
)
result.save(fmt="docx")
```

---

### 6. 🔄 Dịch Thuật Bất Đồng Bộ (Async)

DocuTranslate hỗ trợ **async/await** để xử lý nhiều tác vụ đồng thời:

**Tính năng:**
- ✅ Dịch nhiều file cùng lúc
- ✅ Concurrent requests (mặc định 10)
- ✅ Non-blocking operations
- ✅ Background tasks

**Ví dụ:**
```python
# Dịch nhiều file cùng lúc
async def translate_multiple():
    files = ["doc1.pdf", "doc2.docx", "doc3.txt"]
    results = await asyncio.gather(
        *[client.translate_async(f) for f in files]
    )
    for r in results:
        print(f"Saved: {r.save()}")

asyncio.run(translate_multiple())
```

---

### 7. 🌐 Web Interface & RESTful API

DocuTranslate cung cấp:

**Web UI:**
- ✅ Giao diện web trực quan
- ✅ Upload file trực tiếp
- ✅ Xem progress real-time
- ✅ Download kết quả

**RESTful API:**
- ✅ Submit translation tasks
- ✅ Check status
- ✅ Download results
- ✅ View logs
- ✅ Cancel tasks

**Endpoints chính:**
```
POST /api/service/translate/file    # Submit task
GET  /api/service/status/{task_id}  # Check status
GET  /api/service/download/{id}/{format}  # Download
GET  /api/service/logs/{task_id}   # View logs
POST /api/service/cancel/{task_id}  # Cancel task
```

---

### 8. 🎯 JSON Selective Translation

Với file JSON, bạn có thể chỉ định **chính xác** phần nào cần dịch:

**Tính năng:**
- ✅ Sử dụng JSONPath để chọn fields
- ✅ Chỉ dịch values, giữ nguyên keys
- ✅ Hỗ trợ nested JSON

**Ví dụ:**
```python
# Chỉ dịch các field "name" và "description"
result = client.translate(
    "data.json",
    json_paths=["$.name", "$.description", "$.items[*].title"]
)
```

**JSONPath syntax:**
- `$.name` - Field "name" ở root
- `$.*` - Tất cả fields ở root
- `$.items[*].title` - Tất cả "title" trong array "items"

---

### 9. 📝 Subtitle Translation

DocuTranslate hỗ trợ dịch phụ đề:

- ✅ **SRT files**: Standard subtitle format
- ✅ **ASS files**: Advanced subtitle với styling
- ✅ Giữ nguyên timing
- ✅ Giữ nguyên styling (ASS)

**Ví dụ:**
```python
# Dịch phụ đề
result = client.translate("subtitle.srt", to_lang="Tiếng Việt")
result.save(fmt="srt")
```

---

### 10. ⚡ High Performance

DocuTranslate được tối ưu cho hiệu suất cao:

- ✅ **Concurrent processing**: Xử lý nhiều chunk cùng lúc
- ✅ **Rate limiting**: RPM/TPM control
- ✅ **Retry mechanism**: Tự động retry khi lỗi
- ✅ **Caching**: Cache PDF parsing results
- ✅ **Streaming**: Xử lý file lớn hiệu quả

**Cấu hình:**
```python
client = Client(
    concurrent=20,      # 20 requests đồng thời
    chunk_size=3000,    # Chia nhỏ text
    timeout=120,        # Timeout 2 phút
    retry=3            # Retry 3 lần nếu lỗi
)
```

---

### 11. 🔧 Customization

DocuTranslate cho phép tùy chỉnh nhiều tham số:

**LLM Parameters:**
- `temperature`: Độ sáng tạo (0-1)
- `custom_prompt`: Prompt tùy chỉnh
- `thinking`: Thinking mode (enable/disable)
- `force_json`: Bắt buộc output JSON

**Translation Parameters:**
- `chunk_size`: Kích thước chunk
- `concurrent`: Số requests đồng thời
- `timeout`: Thời gian timeout
- `retry`: Số lần retry

**Ví dụ:**
```python
client = Client(
    temperature=0.7,           # Sáng tạo hơn
    custom_prompt="Dịch theo phong cách học thuật",
    thinking="enable",         # Bật thinking mode
    chunk_size=5000           # Chunk lớn hơn
)
```

---

### 12. 🌍 Multi-Language Support

DocuTranslate hỗ trợ dịch sang **nhiều ngôn ngữ**:

- Tiếng Việt
- English
- 中文 (简体/繁体)
- 日本語
- 한국어
- Français
- Deutsch
- Español
- Và nhiều ngôn ngữ khác...

**Ví dụ:**
```python
# Dịch sang tiếng Việt
client = Client(to_lang="Tiếng Việt")

# Dịch sang tiếng Anh
client = Client(to_lang="English")

# Dịch sang tiếng Trung
client = Client(to_lang="简体中文")
```

---

### 13. 📦 Multiple Output Formats

Sau khi dịch, bạn có thể export ra nhiều format:

- ✅ **HTML**: Web view với styling
- ✅ **Markdown**: Markdown với images
- ✅ **Markdown ZIP**: Markdown + images riêng
- ✅ **Original format**: DOCX, XLSX, etc.
- ✅ **Base64**: Cho API transmission

**Ví dụ:**
```python
result = client.translate("document.pdf")

# Export HTML
result.save(fmt="html")

# Export Markdown
result.save(fmt="markdown")

# Export Base64
base64_content = result.export(fmt="html")
```

---

### 14. 🔐 Security & Privacy

DocuTranslate đảm bảo:

- ✅ **Local processing**: Xử lý local, không gửi data lên server
- ✅ **API key security**: Không log API keys
- ✅ **File privacy**: Files chỉ tồn tại trong memory
- ✅ **HTTPS support**: Secure connections

---

### 15. 🛠️ Developer-Friendly

DocuTranslate cung cấp:

- ✅ **SDK**: Simple Client API
- ✅ **Workflow API**: Advanced control
- ✅ **RESTful API**: HTTP endpoints
- ✅ **Type hints**: Full type support
- ✅ **Documentation**: Comprehensive docs

**SDK Example:**
```python
from docutranslate.sdk import Client

client = Client(
    api_key="sk-xxx",
    base_url="https://api.openai.com/v1",
    model_id="gpt-4o",
    to_lang="Tiếng Việt"
)

result = client.translate("file.pdf")
result.save()
```

---

## 📊 So Sánh với Công Cụ Khác

| Tính Năng | DocuTranslate | Google Translate | DeepL | ChatGPT |
|-----------|---------------|------------------|-------|---------|
| Đa định dạng | ✅ 10+ | ❌ Text only | ❌ Text only | ❌ Text only |
| Giữ format | ✅ | ❌ | ❌ | ❌ |
| PDF nâng cao | ✅ | ❌ | ❌ | ❌ |
| Glossary | ✅ | ❌ | ❌ | ❌ |
| API | ✅ | ✅ | ✅ | ✅ |
| Local | ✅ | ❌ | ❌ | ❌ |
| Free tier | ✅ | ✅ | ⚠️ Limited | ⚠️ Limited |

---

## 🎯 Use Cases

### 1. Dịch Tài Liệu Học Thuật
- Dịch research papers
- Dịch sách kỹ thuật
- Giữ nguyên công thức và bảng

### 2. Dịch Tài Liệu Kinh Doanh
- Dịch hợp đồng
- Dịch báo cáo
- Giữ nguyên format Word/Excel

### 3. Dịch Sách/Novel
- Dịch EPUB books
- Dịch Markdown files
- Export HTML để đọc

### 4. Dịch Phụ Đề
- Dịch SRT/ASS files
- Giữ nguyên timing
- Dịch hàng loạt

### 5. Dịch Website
- Dịch HTML pages
- Dịch JSON data
- API integration

---

## 🚀 Getting Started

### Quick Start

```python
from docutranslate.sdk import Client

# Khởi tạo client
client = Client(
    api_key="YOUR_API_KEY",
    base_url="https://api.openai.com/v1",
    model_id="gpt-4o",
    to_lang="Tiếng Việt"
)

# Dịch file
result = client.translate("document.pdf")
result.save(fmt="html")
```

### Web UI

```bash
# Start web server
docutranslate -i

# Mở browser
# http://127.0.0.1:8010
```

---

## 📚 Tài Liệu

- **README**: [README.md](./README.md)
- **API Docs**: http://localhost:8010/docs (khi chạy local)
- **GitHub**: https://github.com/xunbu/docutranslate

---

## ✅ Tóm Tắt

DocuTranslate là một công cụ dịch thuật **mạnh mẽ, linh hoạt và dễ sử dụng**, phù hợp cho:

- ✅ Dịch tài liệu học thuật
- ✅ Dịch tài liệu kinh doanh
- ✅ Dịch sách/novel
- ✅ Dịch phụ đề
- ✅ API integration
- ✅ Batch processing

**Điểm mạnh:**
- 🌟 Hỗ trợ nhiều định dạng
- 🌟 Giữ nguyên format
- 🌟 PDF nâng cao (bảng, công thức, code)
- 🌟 Tự động tạo glossary
- 🌟 High performance
- 🌟 Developer-friendly

---

**Chúc bạn sử dụng hiệu quả! 🎉**
