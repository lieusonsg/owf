# Hướng Dẫn Cập Nhật OWF Từ AWF Upstream

## Quy Trình Sync Updates

Khi AWF gốc (TUAN130294/awf) có update, thực hiện các bước sau:

### Bước 1: Thêm AWF làm upstream remote (chỉ làm 1 lần)

```bash
cd path/to/owf
git remote add upstream https://github.com/TUAN130294/awf.git
git remote -v
# Kết quả:
# origin    https://github.com/lieusonsg/owf.git (fetch)
# origin    https://github.com/lieusonsg/owf.git (push)
# upstream  https://github.com/TUAN130294/awf.git (fetch)
# upstream  https://github.com/TUAN130294/awf.git (push)
```

### Bước 2: Fetch updates từ AWF

```bash
git fetch upstream
```

### Bước 3: Xem những thay đổi

```bash
# Xem commits mới từ AWF
git log upstream/main --oneline -10

# Xem diff giữa OWF và AWF
git diff main upstream/main --stat
```

### Bước 4: Merge có chọn lọc

**QUAN TRỌNG**: Không merge trực tiếp! Cần xử lý thủ công vì cấu trúc thư mục khác nhau.

#### 4.1. Tạo branch để sync

```bash
git checkout -b sync-awf-update
```

#### 4.2. Copy files cần update

```bash
# Checkout specific files from upstream
# Workflows -> Commands
git checkout upstream/main -- workflows/plan.md
mv workflows/plan.md commands/plan.md

# Skills (giữ nguyên tên)
git checkout upstream/main -- awf_skills/awf-auto-save/SKILL.md
mv awf_skills/awf-auto-save/SKILL.md skills/awf-auto-save/SKILL.md

# Schemas & Templates (copy trực tiếp)
git checkout upstream/main -- schemas/
git checkout upstream/main -- templates/
```

#### 4.3. Cập nhật VERSION

```bash
# Xem version mới của AWF
cat upstream:VERSION

# Cập nhật OWF version (ví dụ: AWF 4.2.0 -> OWF 1.1.0)
echo "1.1.0" > VERSION
```

#### 4.4. Commit và push

```bash
git add .
git commit -m "Sync with AWF v4.x.x - [mô tả changes]"
git checkout main
git merge sync-awf-update
git push origin main
```

---

## Files Cần Chú Ý Khi Sync

### Files KHÔNG sync (giữ nguyên OWF)
- `install.ps1` - Paths khác nhau
- `install.sh` - Paths khác nhau
- `README.md` - Branding OWF
- `OWF_INSTRUCTIONS.md` - Specific cho OpenCode
- `commands/owf-update.md` - Specific cho OWF

### Files CẦN sync (từ AWF)
- `commands/*.md` (trừ owf-update.md) - Workflows logic
- `skills/*/SKILL.md` - Skills logic
- `schemas/*.json` - Schema definitions
- `templates/*.json` - Templates
- `docs/*.md` - Documentation

### Files CẦN review khi sync
- Bất kỳ file nào có paths `~/.gemini/` cần đổi thành `~/.config/opencode/`
- Bất kỳ references đến `GEMINI.md` cần đổi thành `OWF_INSTRUCTIONS.md`

---

## Script Tự Động Sync

Xem file `scripts/sync-upstream.sh` để chạy tự động.
