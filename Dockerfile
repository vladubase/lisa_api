FROM python:3.14-slim AS builder

WORKDIR /app

RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY pyproject.toml .

RUN pip install --no-cache-dir .

# Final production stage
FROM python:3.14-slim

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv

COPY src/ ./src/

ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

RUN useradd -m -u 1001 lisa_user
USER lisa_user

# Command to run the FastAPI application using Uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]