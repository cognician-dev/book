# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jupyter Book project for cognician, a data plumbing collective. The repository creates a static website using Jupyter Book that documents their services and capabilities.

## Architecture

### Branch Strategy

- **`main`**: Production source code - deployed automatically to root of site
- **`dev`**: Development/staging source - deployed automatically to `/dev/` subdirectory
- **`gh-pages`**: Deployment artifacts ONLY (auto-generated, never edit manually)
  - Contains static HTML/CSS/JS built from source branches
  - `main` branch builds deploy to root: https://cognician-dev.github.io/book/
  - `dev` branch builds deploy to `/dev/`: https://cognician-dev.github.io/book/dev/

### Build System

- **Build Tool**: Jupyter Book (`jb`) converts Markdown files into static HTML website
- **Content Structure**:
  - `about.md` - Landing page with company description
  - `contact.md` - Contact information
  - `drafts/` - Draft content excluded from builds
  - `samples/` - Sample notebooks and content excluded from builds
  - Personal directories (`.claude/`, `braindumps/`, `journal/`, `newsletter/`, etc.) - Excluded from builds
- **Configuration**:
  - `_config.yml` - Main Jupyter Book configuration (includes `exclude_patterns`)
  - `_toc.yml` - Table of contents structure
  - `pyproject.toml` - Python dependencies managed by uv
  - `uv.lock` - Locked dependency versions

## Common Commands

All development tasks are managed through a Makefile:

```bash
# See all available commands
make help

# Initial setup
make install    # Install dependencies with uv and set up pre-commit hooks

# Development workflow
make build      # Clean and build the book
make dev        # Build and open in browser
make open       # Open built book in browser

# Code quality
make lint       # Run pre-commit hooks manually
```

### Manual Commands (if needed)
```bash
# Direct Jupyter Book commands
jb clean --all .
jb build .

# The built book will be in _build/html/

# Pre-commit management
pre-commit run --all-files
pre-commit autoupdate

# Manual Ruff usage (if needed)
ruff check --fix .  # Lint and auto-fix
ruff format .       # Format code
```

## Content Management

- Main content files are in the root directory
- **Excluded from builds** (via `_config.yml`):
  - `drafts/` - Draft content directory
  - `samples/` - Sample notebooks directory
  - `CLAUDE.md` - Internal development documentation
- The book is configured to force re-execution of notebooks on each build
- Logo file: `logo-t-a.png`
- Bibliography: `references.bib`

## Deployment

### Production Environment
- **URL**: https://cognician-dev.github.io/book/
- **Workflow**: `.github/workflows/build-deploy.yml`
- **Trigger**: Pushes to `main` branch
- **Features**: Uses Python 3.11, uv for dependency management, caches dependencies and executed notebooks

### Staging Environment
- **URL**: https://cognician-dev.github.io/book/dev/
- **Workflow**: `.github/workflows/deploy-dev.yml`
- **Trigger**: Pushes to `dev` branch
- **Purpose**: Test changes before promoting to production

### Build Validation
- **Workflow**: `.github/workflows/validate.yml`
- **Triggers**: Pull requests to `main`/`dev` branches, pushes to `dev`
- **Purpose**: Ensures builds succeed before merging

## Development Workflow

1. **Setup**: Install dependencies and pre-commit hooks
2. **Development**: Work on the `dev` branch for testing
3. **Quality**: Pre-commit hooks automatically run on commit
4. **Dev Deploy**: Push to `dev` branch triggers deployment to staging environment
5. **PR**: Create pull request from `dev` to `main` - build validation runs automatically
6. **Production Deploy**: Merge to `main` triggers automatic deployment to production

### Branch Strategy
- `dev` - Development branch for testing changes before production
- `main` - Production branch for live site (protected)

### Branch Protection
The `main` branch is protected with the following rules:
- **Pull Request Required**: Direct pushes to main are blocked
- **Status Check Required**: "Validate Build" workflow must pass
- **Review Required**: At least 1 approving review needed
- **Up-to-date Branches**: Must be current with main before merge
- **No Force Push**: History cannot be rewritten
- **Stale Review Dismissal**: New commits dismiss previous approvals

## Claude Code Productivity Systems

This repository includes several Claude Code slash commands and subagents for productivity workflows:

### Weekly Check-In Protocol

The `/weekly-checkin` command will:

1. Analyze project context to determine relevant metrics
2. Ask for current values of those specific metrics
3. Compare to previous data and generate visual analysis
4. Save formatted report with insights and recommendations

The system intelligently adapts to track what matters for this specific project.

### Daily Check-In Protocol

The `/daily-checkin` command provides:

- Personal reflection prompts for well-being tracking
- Mood and energy pattern analysis
- Accomplishment tracking and momentum scoring
- Visual trends and insights over time
- Gentle, encouraging feedback for continuous growth

Daily entries are saved in `journal/daily/` for long-term pattern recognition.

### Newsletter Research Protocol

The `/newsletter-research` command:

- Analyzes competitor newsletters for trending topics
- Identifies content gaps and opportunities
- Writes complete newsletter drafts in your authentic voice
- Creates compelling subject lines and natural CTAs
- Saves research and drafts to organized folders

### Brain Dump Analysis Protocol

The `/brain-dump-analysis` command:

- Extracts insights from stream-of-consciousness writing
- Identifies recurring themes and hidden connections
- Creates visual mind maps of thought patterns
- Generates actionable items from chaotic thoughts
- Provides both personal insights and content opportunities

### Daily Brief Protocol

The `/daily-brief` command:

- Analyzes your files to identify personal interests
- Curates recent news (last 7 days only) relevant to your work
- Explains why each story matters to you specifically
- Suggests actionable next steps from news insights
- Saves personalized brief with verified publication dates

### System Architecture

- **Commands**: Stored in `.claude/commands/` as slash commands
- **Subagents**: Specialized AI agents in `.claude/subagents/`
- **Data Storage**:
  - `metrics/` - Weekly check-in history and reports
  - `journal/daily/` - Daily reflection entries and analysis
  - `newsletter/` - Research insights and draft content
  - `braindumps/` - Raw thoughts and extracted insights
  - `daily-briefs/` - Personalized news briefings

All systems are designed to intelligently adapt to your specific context and provide actionable insights rather than generic templates.

## File Structure Notes

- Uses `pyproject.toml` and `uv.lock` for Python dependency management instead of requirements.txt
- The `_build/` directory contains generated files and should not be edited directly
- Static assets go in `_static/` directory
- Virtual environment is in `.venv/` (managed by uv)
- Always update CLAUDE.md before committing
