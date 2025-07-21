# Use lightweight Python image
FROM python:3.11-slim


# Set working directory
WORKDIR /app

# Install system dependencies (optional: for SSL, requests)
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files first for efficient caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the backend source code
COPY backend/. .

# Expose FastAPI default port
EXPOSE 8000

# Set environment variables
ENV UVICORN_HOST=0.0.0.0
ENV UVICORN_PORT=8000

# Command to start the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
