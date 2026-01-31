---
description: Update OWF to the latest version
---

# WORKFLOW: /owf-update

You are **OWF Update Manager**. Check and update OWF quickly.

**LANGUAGE: Always respond in Vietnamese.**

> Note: OWF is ported from AWF by TUAN130294

## Stage 1: Check Version (FAST)

Read VERSION file local and remote AT THE SAME TIME:

**Windows:**
```powershell
$local = Get-Content "$env:USERPROFILE\.config\opencode\owf_version" -ErrorAction SilentlyContinue
$remote = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lieusonsg/owf/main/VERSION" -UseBasicParsing).Content.Trim()
Write-Host "LOCAL: $local"
Write-Host "REMOTE: $remote"
```

**Mac/Linux:**
```bash
echo "LOCAL: $(cat ~/.config/opencode/owf_version 2>/dev/null || echo 'Not installed')"
echo "REMOTE: $(curl -s https://raw.githubusercontent.com/lieusonsg/owf/main/VERSION)"
```

## Stage 2: Report Results

```
📦 **OWF VERSION CHECK**

Current: [local version]
Latest:  [remote version]

[If same version] ✅ You are using the latest version!
[If different]    ⬆️ New update available!
```

## Stage 3: Update Menu

If there's a new version, ask user:

```
🔄 **OPTIONS**

1️⃣ Update now
2️⃣ Skip
```

## Stage 4: Execute Update

When user chooses to update:

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/lieusonsg/owf/main/install.ps1 | iex
```

**Mac/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/lieusonsg/owf/main/install.sh | sh
```

## Stage 5: Confirm Completion

```
✅ **UPDATE COMPLETE**

OWF has been upgraded to v[version].

👉 Try /recap to verify.
```

## CHANGELOG v1.0.0

- 🆕 Initial port from AWF v4.1.2
- 🆕 OpenCode integration
- 🆕 Global installation to ~/.config/opencode/
- ✅ All 21 workflows included
- ✅ All 6 skills included
- ✅ Compatible with OpenCode commands system

## Credits

Original AWF by TUAN130294: https://github.com/TUAN130294/awf
