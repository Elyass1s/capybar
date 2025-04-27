FROM python:3.11.9-slim

# Set working directory
WORKDIR /app

# Copy and install requirements first (for better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Cloud Run sets PORT environment variable - use it for our app
ENV PORT 8080

# Expose port - this is informational only, Cloud Run will use the PORT env var
EXPOSE 8080

# Run the application with the PORT from environment variable
CMD exec python -m flask run --host=0.0.0.0 --port=${PORT}