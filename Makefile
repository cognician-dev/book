.PHONY: build clean install dev open help lint

# Default target
help:
	@echo "Available targets:"
	@echo "  build    - Clean and build the book"
	@echo "  clean    - Clean build artifacts"
	@echo "  install  - Install dependencies with uv"
	@echo "  dev      - Build and open in browser"
	@echo "  open     - Open built book in browser"
	@echo "  lint     - Run pre-commit hooks"

install:
	uv sync
	uv run pre-commit install

clean:
	uv run jb clean --all .

build: clean
	@echo "Building the book..."
	uv run jb build .

dev: build open

open:
	@uv run python -c "import webbrowser; webbrowser.open('file://$$(pwd)/_build/html/index.html')"

lint:
	uv run pre-commit run --all-files
