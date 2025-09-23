# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jupyter Book project for cognician, a data plumbing collective. The repository creates a static website using Jupyter Book that documents their services and capabilities.

## Architecture

- **Build System**: Uses Jupyter Book (`jb`) to convert Markdown files into a static HTML website
- **Content Structure**:
  - `about.md` - Landing page with company description
  - `contact.md` - Contact information
  - `drafts/` - Draft content excluded from builds
  - `samples/` - Sample notebooks and content excluded from builds
- **Configuration**:
  - `_config.yml` - Main Jupyter Book configuration
  - `_toc.yml` - Table of contents structure
  - `requirements.txt` - Python dependencies

## Common Commands

### Building the Book
```bash
# Clean and build (recommended)
./build.sh

# Or manually:
jb clean --all .
jb build .

# Local build with permissions fix
./build-local.sh
```

### Development

#### Initial Setup
```bash
# Install production dependencies
pip install -r requirements.txt

# Install development dependencies (optional)
pip install -r requirements-dev.txt

# Set up pre-commit hooks (recommended)
pre-commit install
```

#### Local Development
```bash
# Build the book locally
./build.sh

# Or manually:
jb clean --all .
jb build .

# The built book will be in _build/html/
```

#### Code Quality
```bash
# Run pre-commit hooks manually (uses Ruff for formatting and linting)
pre-commit run --all-files

# Update pre-commit hooks to latest versions
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
- **Features**: Uses Python 3.11, caches dependencies and executed notebooks

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

## File Structure Notes

- No traditional package.json or similar - this is a documentation site, not a web application
- The `_build/` directory contains generated files and should not be edited directly
- Static assets go in `_static/` directory
- always update claude.md before committing