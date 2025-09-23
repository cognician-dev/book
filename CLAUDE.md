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
# Run pre-commit hooks manually
pre-commit run --all-files

# Format code with black
black .

# Sort imports
isort .

# Lint with flake8
flake8 .
```

## Content Management

- Main content files are in the root directory
- `drafts/` and `samples/` directories are excluded from builds via `_config.yml`
- The book is configured to force re-execution of notebooks on each build
- Logo file: `logo-t-a.png`
- Bibliography: `references.bib`

## Deployment

- **Production**: Automatic deployment to GitHub Pages via `.github/workflows/build-deploy.yml`
  - Triggers on pushes to `main` or `master` branches
  - Uses Python 3.11 and caches dependencies and executed notebooks
- **PR Validation**: Automated build validation via `.github/workflows/validate.yml`
  - Runs on all pull requests to ensure builds succeed
  - Prevents broken builds from being merged

## Development Workflow

1. **Setup**: Install dependencies and pre-commit hooks
2. **Development**: Work on the `dev` branch for testing
3. **Quality**: Pre-commit hooks automatically run on commit
4. **Dev Deploy**: Push to `dev` branch triggers deployment to staging environment
5. **PR**: Create pull request from `dev` to `main` - build validation runs automatically
6. **Production Deploy**: Merge to `main` triggers automatic deployment to production

### Branch Strategy
- `dev` - Development branch for testing changes before production
- `main` - Production branch for live site

## File Structure Notes

- No traditional package.json or similar - this is a documentation site, not a web application
- The `_build/` directory contains generated files and should not be edited directly
- Static assets go in `_static/` directory