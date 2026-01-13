#!/usr/bin/env bash
set -e

echo "🚀 Setting up pre-commit hooks for hassio-addons repository"
echo ""

# Check if pre-commit is installed
if ! command -v pre-commit &> /dev/null; then
    echo "📦 pre-commit not found. Installing..."

    # Try pip first
    if command -v uv &> /dev/null; then
        uv tool install --user pre-commit
    else
        echo "❌ Error: uv not found. Please install Python and uv first."
        exit 1
    fi
else
    echo "✅ pre-commit is already installed"
fi

# Install the git hooks
echo "📌 Installing pre-commit hooks..."
pre-commit install

echo ""
echo "✅ Pre-commit setup complete!"
echo ""
echo "Optional: Run pre-commit on all files to check current state:"
echo "  pre-commit run --all-files"
echo ""
echo "The hooks will now run automatically before each commit."
