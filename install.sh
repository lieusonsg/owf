#!/bin/bash
# OWF Installer for macOS/Linux
# OpenCode Workflow Framework - Ported from AWF (Antigravity Workflow Framework)
# Original Author: TUAN130294 (https://github.com/TUAN130294/awf)
# Ported for OpenCode by: OWF Team

set -e

REPO_BASE="https://raw.githubusercontent.com/lieusonsg/owf/main"
COMMANDS_URL="$REPO_BASE/commands"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Commands list
COMMANDS=(
    "init.md" "brainstorm.md" "plan.md" "design.md"
    "visualize.md" "code.md" "run.md"
    "debug.md" "test.md" "audit.md"
    "deploy.md" "refactor.md" "rollback.md"
    "next.md" "recap.md" "help.md" "customize.md"
    "save_brain.md" "review.md"
    "owf-update.md" "README.md"
)

# Schemas
SCHEMAS=(
    "brain.schema.json" "session.schema.json" "preferences.schema.json"
)

# Templates
TEMPLATES=(
    "brain.example.json" "session.example.json" "preferences.example.json"
)

# Skills
SKILLS=(
    "awf-session-restore"
    "awf-auto-save"
    "awf-adaptive-language"
    "awf-error-translator"
    "awf-context-help"
    "awf-onboarding"
)

# OpenCode paths
OPENCODE_CONFIG="$HOME/.config/opencode"
COMMANDS_DIR="$OPENCODE_CONFIG/commands"
SKILLS_DIR="$OPENCODE_CONFIG/skills"
SCHEMAS_DIR="$OPENCODE_CONFIG/schemas"
TEMPLATES_DIR="$OPENCODE_CONFIG/templates"
OWF_VERSION_FILE="$OPENCODE_CONFIG/owf_version"

# Get version
CURRENT_VERSION=$(curl -fsSL "$REPO_BASE/VERSION" 2>/dev/null || echo "1.0.0")

echo ""
echo -e "${CYAN}======================================================================"
echo "    OWF - OpenCode Workflow Framework v$CURRENT_VERSION"
echo -e "${GRAY}    Ported from AWF by TUAN130294"
echo -e "${CYAN}======================================================================${NC}"
echo ""

# Check if updating
if [ -f "$OWF_VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$OWF_VERSION_FILE")
    echo -e "${YELLOW}Current version: $OLD_VERSION${NC}"
    echo -e "${GREEN}New version: $CURRENT_VERSION${NC}"
    echo ""
fi

# Create directories
for dir in "$OPENCODE_CONFIG" "$COMMANDS_DIR" "$SKILLS_DIR" "$SCHEMAS_DIR" "$TEMPLATES_DIR"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}Created: $dir${NC}"
    fi
done

# Download function
download_file() {
    local url="$1"
    local dest="$2"
    if curl -fsSL "$url" -o "$dest" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Download commands
echo -e "${CYAN}Downloading commands...${NC}"
success=0
for cmd in "${COMMANDS[@]}"; do
    if download_file "$COMMANDS_URL/$cmd" "$COMMANDS_DIR/$cmd"; then
        echo -e "   ${GREEN}[OK]${NC} $cmd"
        ((success++))
    else
        echo -e "   ${RED}[FAIL]${NC} $cmd"
    fi
done

# Download schemas
echo -e "${CYAN}Downloading schemas...${NC}"
for schema in "${SCHEMAS[@]}"; do
    if download_file "$REPO_BASE/schemas/$schema" "$SCHEMAS_DIR/$schema"; then
        echo -e "   ${GREEN}[OK]${NC} $schema"
        ((success++))
    else
        echo -e "   ${RED}[FAIL]${NC} $schema"
    fi
done

# Download templates
echo -e "${CYAN}Downloading templates...${NC}"
for template in "${TEMPLATES[@]}"; do
    if download_file "$REPO_BASE/templates/$template" "$TEMPLATES_DIR/$template"; then
        echo -e "   ${GREEN}[OK]${NC} $template"
        ((success++))
    else
        echo -e "   ${RED}[FAIL]${NC} $template"
    fi
done

# Download skills
echo -e "${CYAN}Downloading skills...${NC}"
for skill in "${SKILLS[@]}"; do
    skill_dir="$SKILLS_DIR/$skill"
    mkdir -p "$skill_dir"
    if download_file "$REPO_BASE/skills/$skill/SKILL.md" "$skill_dir/SKILL.md"; then
        echo -e "   ${GREEN}[OK]${NC} $skill"
        ((success++))
    else
        echo -e "   ${RED}[FAIL]${NC} $skill"
    fi
done

# Save version
echo "$CURRENT_VERSION" > "$OWF_VERSION_FILE"
echo -e "${GREEN}[OK] Saved version: $CURRENT_VERSION${NC}"

# Create OWF Instructions file
INSTRUCTIONS_FILE="$OPENCODE_CONFIG/OWF_INSTRUCTIONS.md"
cat > "$INSTRUCTIONS_FILE" << 'EOF'
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

`/init` -> `/plan` -> `/design` -> `/code` -> `/run` -> `/test` -> `/deploy`

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

OWF stores project context in `.brain/` folder:
- brain.json - Static project knowledge
- session.json - Dynamic session state
- preferences.json - User preferences

## Credit

Original AWF by TUAN130294: https://github.com/TUAN130294/awf
Ported for OpenCode by OWF Team
EOF
echo -e "${GREEN}[OK] Created OWF_INSTRUCTIONS.md${NC}"

# Create/update opencode.json
OPENCODE_JSON="$OPENCODE_CONFIG/opencode.json"
if [ -f "$OPENCODE_JSON" ]; then
    echo ""
    echo -e "${YELLOW}TIP: Add OWF instructions to your opencode.json:${NC}"
    echo '  "instructions": ["~/.config/opencode/OWF_INSTRUCTIONS.md"]'
else
    cat > "$OPENCODE_JSON" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["~/.config/opencode/OWF_INSTRUCTIONS.md"]
}
EOF
    echo -e "${GREEN}[OK] Created opencode.json with OWF instructions${NC}"
fi

echo ""
echo -e "${GRAY}======================================================================${NC}"
echo -e "${YELLOW}INSTALLATION COMPLETE! $success files installed.${NC}"
echo -e "${CYAN}Version: $CURRENT_VERSION${NC}"
echo ""
echo -e "${GRAY}Locations:"
echo "  Commands:  $COMMANDS_DIR"
echo "  Skills:    $SKILLS_DIR"
echo "  Schemas:   $SCHEMAS_DIR"
echo "  Templates: $TEMPLATES_DIR${NC}"
echo ""
echo -e "${CYAN}You can now use OWF in ANY project!${NC}"
echo "Try: /init to start a new project"
echo "Check updates: /owf-update"
echo ""
