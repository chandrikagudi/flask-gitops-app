# Build stage
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY app.py .

# Run as non-root user for security best practices
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER 1000

EXPOSE 5000
CMD ["python", "app.py"]