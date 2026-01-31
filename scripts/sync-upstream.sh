#!/bin/bash
# OWF Sync Script - Sync updates from AWF upstream
# Usage: ./scripts/sync-upstream.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     OWF Sync Script - Sync from AWF Upstream             ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if upstream exists
if ! git remote | grep -q upstream; then
    echo -e "${YELLOW}Adding upstream remote...${NC}"
    git remote add upstream https://github.com/TUAN130294/awf.git
fi

# Fetch upstream
echo -e "${CYAN}Fetching upstream...${NC}"
git fetch upstream

# Get versions
AWF_VERSION=$(git show upstream/main:VERSION 2>/dev/null | tr -d '\r\n' || echo "unknown")
OWF_VERSION=$(cat VERSION 2>/dev/null | tr -d '\r\n' || echo "unknown")

echo ""
echo -e "AWF upstream version: ${GREEN}$AWF_VERSION${NC}"
echo -e "OWF current version:  ${YELLOW}$OWF_VERSION${NC}"
echo ""

# Show changes
echo -e "${CYAN}Changes in upstream:${NC}"
git log main..upstream/main --oneline 2>/dev/null || echo "No new commits or branches diverged"

echo ""
echo -e "${CYAN}Files changed:${NC}"
git diff main upstream/main --stat 2>/dev/null | tail -20 || echo "Unable to compare"

echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}MANUAL STEPS REQUIRED:${NC}"
echo ""
echo "1. Create sync branch:"
echo -e "   ${GREEN}git checkout -b sync-awf-$AWF_VERSION${NC}"
echo ""
echo "2. For each updated workflow, run:"
echo -e "   ${GREEN}git show upstream/main:workflows/FILENAME.md > commands/FILENAME.md${NC}"
echo ""
echo "3. For each updated skill, run:"
echo -e "   ${GREEN}git show upstream/main:awf_skills/SKILL_NAME/SKILL.md > skills/SKILL_NAME/SKILL.md${NC}"
echo ""
echo "4. Copy schemas and templates:"
echo -e "   ${GREEN}git checkout upstream/main -- schemas/ templates/${NC}"
echo ""
echo "5. Update paths in copied files:"
echo -e "   - Replace ~/.gemini/antigravity/ with ~/.config/opencode/"
echo -e "   - Replace GEMINI.md with OWF_INSTRUCTIONS.md"
echo ""
echo "6. Update VERSION and commit:"
echo -e "   ${GREEN}echo \"1.x.x\" > VERSION${NC}"
echo -e "   ${GREEN}git add . && git commit -m \"Sync with AWF v$AWF_VERSION\"${NC}"
echo ""
echo "7. Merge and push:"
echo -e "   ${GREEN}git checkout main && git merge sync-awf-$AWF_VERSION && git push${NC}"
echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
