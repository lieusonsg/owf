# OWF Installer for Windows (PowerShell)
# OpenCode Workflow Framework - Ported from AWF (Antigravity Workflow Framework)
# Original Author: TUAN130294 (https://github.com/TUAN130294/awf)
# Ported for OpenCode by: OWF Team

$RepoBase = "https://raw.githubusercontent.com/lieusonsg/owf/main"
$CommandsUrl = "$RepoBase/commands"

# Command list (from AWF workflows)
$Commands = @(
    # Core Flow
    "init.md", "brainstorm.md", "plan.md", "design.md",
    "visualize.md", "code.md", "run.md",
    # Quality
    "debug.md", "test.md", "audit.md",
    # Deploy & Maintain
    "deploy.md", "refactor.md", "rollback.md",
    # Support
    "next.md", "recap.md", "help.md", "customize.md",
    "save_brain.md", "review.md",
    # System
    "owf-update.md", "README.md"
)

# Schemas and Templates
$Schemas = @(
    "brain.schema.json", "session.schema.json", "preferences.schema.json"
)
$Templates = @(
    "brain.example.json", "session.example.json", "preferences.example.json"
)

# Skills
$Skills = @(
    "awf-session-restore",
    "awf-auto-save",
    "awf-adaptive-language",
    "awf-error-translator",
    "awf-context-help",
    "awf-onboarding"
)

# OpenCode paths (different from Antigravity)
$OpenCodeConfig = "$env:USERPROFILE\.config\opencode"
$CommandsDir = "$OpenCodeConfig\commands"
$SkillsDir = "$OpenCodeConfig\skills"
$SchemasDir = "$OpenCodeConfig\schemas"
$TemplatesDir = "$OpenCodeConfig\templates"
$OwfVersionFile = "$OpenCodeConfig\owf_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
} catch {
    $CurrentVersion = "1.0.0"
}

Write-Host ""
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "    OWF - OpenCode Workflow Framework v$CurrentVersion" -ForegroundColor Cyan
Write-Host "    Ported from AWF by TUAN130294" -ForegroundColor DarkGray
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host ""

# Check if updating
if (Test-Path $OwfVersionFile) {
    $OldVersion = Get-Content $OwfVersionFile
    Write-Host "Current version: $OldVersion" -ForegroundColor Yellow
    Write-Host "New version: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# 1. Create directories
foreach ($dir in @($OpenCodeConfig, $CommandsDir, $SkillsDir, $SchemasDir, $TemplatesDir)) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "Created: $dir" -ForegroundColor Green
    }
}

# 2. Download commands
Write-Host "Downloading commands..." -ForegroundColor Cyan
$success = 0
foreach ($cmd in $Commands) {
    try {
        Invoke-WebRequest -Uri "$CommandsUrl/$cmd" -OutFile "$CommandsDir\$cmd" -ErrorAction Stop
        Write-Host "   [OK] $cmd" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   [FAIL] $cmd" -ForegroundColor Red
    }
}

# 3. Download Schemas
Write-Host "Downloading schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/schemas/$schema" -OutFile "$SchemasDir\$schema" -ErrorAction Stop
        Write-Host "   [OK] $schema" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   [FAIL] $schema" -ForegroundColor Red
    }
}

# 4. Download Templates
Write-Host "Downloading templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/templates/$template" -OutFile "$TemplatesDir\$template" -ErrorAction Stop
        Write-Host "   [OK] $template" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   [FAIL] $template" -ForegroundColor Red
    }
}

# 5. Download Skills
Write-Host "Downloading skills..." -ForegroundColor Cyan
foreach ($skill in $Skills) {
    $skillDir = "$SkillsDir\$skill"
    if (-not (Test-Path $skillDir)) {
        New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
    }
    try {
        Invoke-WebRequest -Uri "$RepoBase/skills/$skill/SKILL.md" -OutFile "$skillDir\SKILL.md" -ErrorAction Stop
        Write-Host "   [OK] $skill" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   [FAIL] $skill" -ForegroundColor Red
    }
}

# 6. Save version
Set-Content -Path $OwfVersionFile -Value $CurrentVersion -Encoding UTF8
Write-Host "[OK] Saved version: $CurrentVersion" -ForegroundColor Green

# 7. Create OWF Instructions file (replaces GEMINI.md)
$OwfInstructions = @"
# OWF - OpenCode Workflow Framework

> Ported from AWF (Antigravity Workflow Framework) by TUAN130294
> https://github.com/TUAN130294/awf

## CRITICAL: Command Recognition

When user types commands starting with `/`, these are OWF WORKFLOW COMMANDS.
You MUST read the corresponding workflow file and execute according to the instructions.

## Command Mapping

| Command | File | Description |
|---------|------|-------------|
| `/init` | commands/init.md | Start a new project |
| `/brainstorm` | commands/brainstorm.md | Explore and refine ideas |
| `/plan` | commands/plan.md | AI acts as PM, plan features |
| `/design` | commands/design.md | Technical design (DB, API, Flow) |
| `/visualize` | commands/visualize.md | Create UI/UX mockup |
| `/code` | commands/code.md | Write code according to spec |
| `/run` | commands/run.md | Run the application |
| `/debug` | commands/debug.md | Analyze and fix bugs |
| `/test` | commands/test.md | Run test cases |
| `/audit` | commands/audit.md | Security audit |
| `/deploy` | commands/deploy.md | Push to production |
| `/next` | commands/next.md | Suggest next steps |
| `/recap` | commands/recap.md | Restore context from session |
| `/help` | commands/help.md | Help and guide |
| `/customize` | commands/customize.md | Personalize AI behavior |
| `/refactor` | commands/refactor.md | Restructure code |
| `/review` | commands/review.md | Code review |
| `/save-brain` | commands/save_brain.md | Save project knowledge |
| `/rollback` | commands/rollback.md | Rollback deployment |
| `/owf-update` | commands/owf-update.md | Update OWF |

## Standard Flow

``/init`` -> ``/plan`` -> ``/design`` -> ``/code`` -> ``/run`` -> ``/test`` -> ``/deploy``

## Resource Locations

- Commands: ~/.config/opencode/commands/
- Skills: ~/.config/opencode/skills/
- Schemas: ~/.config/opencode/schemas/
- Templates: ~/.config/opencode/templates/

## Skills (Auto-activate)

Skills are silent helpers that activate automatically when needed.

| Skill | Trigger | Function |
|-------|---------|----------|
| awf-session-restore | Session start | Auto-restore previous context |
| awf-auto-save | Workflow end, user leaving | Eternal Context - auto-save |
| awf-adaptive-language | Session start | Adjust language to user level |
| awf-error-translator | On error | Translate technical errors |
| awf-onboarding | /init first time | Guide new users |
| awf-context-help | /help or ? | Smart context-based help |

## How to Execute

1. When user types a command, READ the corresponding workflow file
2. Execute EACH STAGE in the workflow
3. Do NOT skip any steps
4. End with NEXT STEPS menu as defined in the workflow

## Project Context

OWF stores project context in ``.brain/`` folder:
- brain.json - Static project knowledge
- session.json - Dynamic session state
- preferences.json - User preferences

## Credit

Original AWF by TUAN130294: https://github.com/TUAN130294/awf
Ported for OpenCode by OWF Team
"@

$InstructionsFile = "$OpenCodeConfig\OWF_INSTRUCTIONS.md"
Set-Content -Path $InstructionsFile -Value $OwfInstructions -Encoding UTF8
Write-Host "[OK] Created OWF_INSTRUCTIONS.md" -ForegroundColor Green

# 8. Update opencode.json to include instructions (if exists)
$OpenCodeJson = "$OpenCodeConfig\opencode.json"
if (Test-Path $OpenCodeJson) {
    Write-Host ""
    Write-Host "TIP: Add OWF instructions to your opencode.json:" -ForegroundColor Yellow
    Write-Host '  "instructions": ["~/.config/opencode/OWF_INSTRUCTIONS.md"]' -ForegroundColor White
} else {
    # Create basic opencode.json
    $BasicConfig = @"
{
  "`$schema": "https://opencode.ai/config.json",
  "instructions": ["~/.config/opencode/OWF_INSTRUCTIONS.md"]
}
"@
    Set-Content -Path $OpenCodeJson -Value $BasicConfig -Encoding UTF8
    Write-Host "[OK] Created opencode.json with OWF instructions" -ForegroundColor Green
}

Write-Host ""
Write-Host "======================================================================" -ForegroundColor DarkGray
Write-Host "INSTALLATION COMPLETE! $success files installed." -ForegroundColor Yellow
Write-Host "Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "Locations:" -ForegroundColor DarkGray
Write-Host "  Commands:  $CommandsDir" -ForegroundColor DarkGray
Write-Host "  Skills:    $SkillsDir" -ForegroundColor DarkGray
Write-Host "  Schemas:   $SchemasDir" -ForegroundColor DarkGray
Write-Host "  Templates: $TemplatesDir" -ForegroundColor DarkGray
Write-Host ""
Write-Host "You can now use OWF in ANY project!" -ForegroundColor Cyan
Write-Host "Try: /init to start a new project" -ForegroundColor White
Write-Host "Check updates: /owf-update" -ForegroundColor White
Write-Host ""
