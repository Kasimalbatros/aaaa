FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy both app and tests directories
COPY app/ ./app/
COPY tests/ ./tests/

EXPOSE 8081

CMD ["python", "-m", "app.main"]
