FROM python:3.12-slim-bookworm AS builder
ENV DEBIAN_FRONTEND=noninteractive

# The installer requires curl (and certificates) to download the release archive
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/0.7.20/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock* ./

# Create virtual environment and install dependencies
RUN python3.12 -m venv .venv
ENV PATH="/app/.venv/bin:$PATH"
RUN uv sync --no-group dev --frozen

# Production stage
FROM python:3.12-slim-bookworm AS production

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Install only runtime dependencies (Python 3.12 is default in Ubuntu 24.04)
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    ca-certificates

# Set up application directory
WORKDIR /app

# Copy virtual environment from builder stage
# makes sure that only non dev dependencies included here, and already installed in dev
# so no need to re-install extra files just .venv
COPY --from=builder /app/.venv /app/.venv

# Copy source code
COPY --chown=appuser:appuser src/ src/

# Set up environment variables
ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONPATH=/app/src/
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Security and performance settings
ENV PYTHONHASHSEED=random
ENV OMP_NUM_THREADS=1

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK CMD curl -f http://localhost:8000/health || exit 1

# Expose port
EXPOSE 8000

# Use exec form for proper signal handling
CMD ["python", "src/main.py"]
