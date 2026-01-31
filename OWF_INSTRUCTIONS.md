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
