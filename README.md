# OWF - OpenCode Workflow Framework

> **Port of AWF (Antigravity Workflow Framework) for OpenCode**
> Transform your AI into a professional team (PM, Designer, Coder) with standardized workflows.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/lieusonsg/owf)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Based on](https://img.shields.io/badge/based%20on-AWF%20v4.1-orange.svg)](https://github.com/TUAN130294/awf)

---

## Credit

This project is a port of [AWF (Antigravity Workflow Framework)](https://github.com/TUAN130294/awf) by **TUAN130294** for use with [OpenCode](https://opencode.ai).

All workflow logic, personas, and design patterns are from the original AWF project. This port only changes the integration mechanism to work with OpenCode.

---

## Key Features

- **Multi-Persona AI**: Specialized AI team (PM Ha, Dev Tuan, Designer Mai, QA Long)
- **Eternal Context**: Auto-save and restore your working session
- **All-in-One**: No need to install additional skills/agents
- **Non-Tech Friendly**: Technical jargon automatically translated to plain language
- **21 Workflows**: Complete development lifecycle coverage

---

## Quick Install (One Command)

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/lieusonsg/owf/main/install.ps1 | iex
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/lieusonsg/owf/main/install.sh | sh
```

**Done!** OWF will automatically download and configure into OpenCode.

> **Windows: ExecutionPolicy error?** Run this first:
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

---

## Getting Started

After installation, type this in OpenCode:

```
/init
```

AI will ask what project you want to build and guide you step by step.

---

## Command Reference

### Project Lifecycle

| Command | Function | Description |
|---------|----------|-------------|
| `/init` | Bootstrap | Start a new project from scratch |
| `/brainstorm` | Ideation | Explore and refine your idea |
| `/plan` | Planning | AI acts as PM, interviews requirements |
| `/visualize` | Design | Create UI/UX before coding |
| `/code` | Development | AI codes according to spec |
| `/run` | Execute | Launch your application |
| `/debug` | Fix Bugs | Analyze and fix errors automatically |
| `/test` | Testing | Run test cases |
| `/deploy` | Ship | Push to production |

### Context & Memory

| Command | Function | Description |
|---------|----------|-------------|
| `/recap` | Remember | Restore context from previous session |
| `/save-brain` | Save | Store project knowledge for later |
| `/next` | Navigate | Get suggestions for next steps |

### Customization

| Command | Function | Description |
|---------|----------|-------------|
| `/customize` | Personalize | Set AI communication style |
| `/owf-update` | Update | Check and update OWF |

---

## Workflow Flow

```
/init → /brainstorm → /plan → /visualize → /code → /test → /deploy
      ↓                              ↓
   BRIEF.md                      /debug (if errors)
                                     ↓
                                /save-brain (end of session)
```

---

## Installation Structure

After installation, OWF is stored globally:

```
~/.config/opencode/
├── opencode.json          # Config with OWF instructions
├── OWF_INSTRUCTIONS.md    # Global rules (replaces GEMINI.md)
├── commands/              # OWF Workflows
│   ├── init.md
│   ├── plan.md
│   └── ...
├── skills/                # Auto-activate skills
│   ├── awf-session-restore/
│   ├── awf-auto-save/
│   └── ...
├── schemas/               # JSON Schemas
└── templates/             # Configuration templates
```

Project-level context is stored in each project:

```
your-project/
└── .brain/
    ├── brain.json        # Static project knowledge
    ├── session.json      # Dynamic session state
    └── preferences.json  # User preferences
```

---

## Global vs Per-Project

OWF uses a **hybrid approach**:

| Component | Location | Scope |
|-----------|----------|-------|
| Commands | `~/.config/opencode/commands/` | Global (all projects) |
| Skills | `~/.config/opencode/skills/` | Global (all projects) |
| Schemas/Templates | `~/.config/opencode/` | Global (all projects) |
| Project Context | `.brain/` in project | Per-project |

This means:
- Install once, use everywhere
- Each project has its own context (`.brain/`)
- You can customize per-project by adding files to `.opencode/` in project root

---

## Differences from AWF

| Aspect | AWF (Antigravity) | OWF (OpenCode) |
|--------|-------------------|----------------|
| Target Platform | Antigravity Agent | OpenCode |
| Config Location | `~/.gemini/antigravity/` | `~/.config/opencode/` |
| Workflows Folder | `global_workflows/` | `commands/` |
| Global Rules | `GEMINI.md` | `OWF_INSTRUCTIONS.md` |
| Config File | None | `opencode.json` |

**Everything else is identical** - same workflows, same skills, same logic!

---

## Update

To check and update to the latest version:

```
/owf-update
```

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

MIT License - feel free to use in personal and commercial projects.

---

## Acknowledgments

- **Original AWF**: [TUAN130294/awf](https://github.com/TUAN130294/awf)
- **OpenCode**: [opencode.ai](https://opencode.ai)

---

**Happy Coding!**

*Ported from AWF by TUAN130294*
