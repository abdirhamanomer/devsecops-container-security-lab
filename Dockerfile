FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Update the affected Debian package
RUN apt-get update \
    && apt-get install -y --no-install-recommends --only-upgrade zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Copy application dependencies
COPY requirements.txt .

# Install updated Python packaging tools
RUN python -m pip install --no-cache-dir --upgrade \
    pip==26.3 \
    setuptools==84.2.1 \
    && python -m pip install --no-cache-dir -r requirements.txt

# Copy application
COPY app.py .

# Create a non-root application account
RUN useradd --system --create-home appuser

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
