# Dockerfile
FROM --platform=linux/amd64 python:3.11-slim

# Install build dependencies
RUN apt-get update && apt-get install -y gcc g++ make

# Install Poetry
RUN pip install poetry

# Set work directory
WORKDIR /app

# Copy pyproject.toml and poetry.lock
COPY pyproject.toml poetry.lock ./

# Copy the rest of the application code
COPY . .

# Install dependencies
RUN poetry install

ENV PYTHONPATH=/app/src

CMD ["sh", "-c", "poetry run python rag_demo/vector_store_generator.py && poetry run python unified_api/unified_api_server.py"]

EXPOSE 5001
