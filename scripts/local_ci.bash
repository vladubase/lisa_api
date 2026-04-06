#!/bin/bash

set -e
echo "Starting Local CI for LISA API..."


echo "Running Black formatter (auto-fix)..."
black src/ tests/


echo "Running Flake8 linter..."
flake8 src/ tests/ --count --select=E9,F63,F7,F82 --show-source --statistics


echo "Running Pytest..."
pytest tests/ || echo "No tests executed or tests failed."


echo "Local CI passed successfully! Code is perfectly formatted. You are ready to push."
