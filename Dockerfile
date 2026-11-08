FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copy application dependencies
COPY requirements.txt .

# Update vulnerable Python packaging tools
RUN python -m pip install --no-cache-dir --upgrade \
    pip==26.3 \
    setuptools==84.2.1 \
    && python -m pip install --no-cache-dir -r requirements.txt

# Copy the Flask application
COPY app.py .

# Create a non-root user
RUN useradd --system --create-home appuser

# Run the application as a non-root user
USER appuser

EXPOSE 5000

# Start the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
