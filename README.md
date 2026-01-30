# ⚡ AWF v4.0 - Antigravity Workflow Framework

> **Framework mở rộng cho Antigravity Agent.**
> Biến AI của bạn thành một đội ngũ chuyên nghiệp (PM, Designer, Coder) với quy trình làm việc chuẩn.

[![Version](https://img.shields.io/badge/version-4.1.0-blue.svg)](https://github.com/TUAN130294/awf)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Website](https://img.shields.io/badge/Website-awfweb.pages.dev-8b5cf6.svg)](https://awfweb.pages.dev/)

🌐 **Website:** [https://awfweb.pages.dev/](https://awfweb.pages.dev/)

---

## ✨ Tính Năng Chính

- 🤖 **Multi-Persona AI**: Đội ngũ AI chuyên biệt (PM Hà, Dev Tuấn, Designer Mai, QA Long)
- 🧠 **Context Vĩnh Cửu**: Tự động lưu và khôi phục session làm việc
- 📦 **All-in-One**: Không cần cài thêm bất kỳ skill/agent nào khác
- 🔄 **Auto-Update**: Tự động kiểm tra và cập nhật phiên bản mới

---

## 🚀 Cài Đặt (Chỉ 1 Lệnh)

### Windows (PowerShell)
Mở Terminal (**Ctrl + `**) và dán:

```powershell
irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1 | iex
```

### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | sh
```

**Xong!** ✅ AWF sẽ tự động tải và cấu hình vào Antigravity.

> ⚠️ **Windows: Gặp lỗi ExecutionPolicy?** Chạy lệnh này trước:
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

---

## 🎮 Cách Sử Dụng

Sau khi cài xong, gõ lệnh này vào khung Chat của Antigravity:

```
/init
```

AI sẽ hỏi bạn muốn làm dự án gì và tự động hướng dẫn từng bước.

---

## 🗺️ Các Lệnh Chính

| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/init` | 🏁 Khởi động | Bắt đầu dự án mới |
| `/plan` | 📝 Kế hoạch | AI đóng vai PM, phỏng vấn yêu cầu |
| `/visualize` | 🎨 Thiết kế | Tạo UI/UX trước khi code |
| `/code` | 💻 Viết code | AI tự động lập trình theo spec |
| `/run` | ▶️ Chạy | Khởi động ứng dụng |
| `/debug` | 🐛 Sửa lỗi | Phân tích và fix bug tự động |
| `/test` | ✅ Kiểm thử | Chạy test cases |
| `/deploy` | 🚀 Deploy | Đẩy lên production |
| `/recap` | 🧠 Nhớ lại | Khôi phục context từ session cũ |
| `/awf-update` | 🔄 Cập nhật | Kiểm tra và update AWF |

---

## 📂 Cấu Trúc Thư Mục (Sau Cài Đặt)

```
~/.gemini/antigravity/
├── global_workflows/    # Các workflow chính (/init, /plan, /code...)
├── skills/              # AWF Skills (auto-activate)
├── schemas/             # JSON Schemas
└── templates/           # Mẫu cấu hình
```

---

## 🔄 Cập Nhật

Để kiểm tra và cập nhật lên phiên bản mới nhất, gõ:
```
/awf-update
```

---

## 📚 Tài Liệu Chi Tiết
Mở file `docs/index.html` để xem hướng dẫn đầy đủ với giao diện đẹp.

---

## 📜 Changelog

### v4.1.0 (Latest)
- 🆕 **Eternal Context System** - Auto-save để không bao giờ mất context
- 🆕 Skill `awf-auto-save` với trigger thông minh
- 🆕 3-Tier lazy loading cho session restore
- ✅ Session schema v2.0 với summary & checkpoints

### v4.0.1
- ✅ Fix lỗi install script trên Windows
- ✅ Cải thiện Session Restore skill
- ✅ Thêm `/awf-update` workflow

### v4.0.0
- 🆕 Skill System (awf-session-restore, awf-error-translator...)
- 🆕 Schemas & Templates
- 🆕 Multi-language support

---

**Happy Vibe Coding!** 🚀
*Authored by Antigravity Team*
