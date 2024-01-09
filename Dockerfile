# Use a base image with Python 3.11 for building the application
FROM python:3.11-bullseye AS build

# Create a non-root user
RUN useradd -m librarian

# Set the working directory
WORKDIR /home/librarian/app

# Set the ownership of the working directory to the non-root user
RUN chown -R librarian:librarian /home/librarian/app

# Switch to the non-root user
USER librarian

# Create cache directories
RUN mkdir -p /home/librarian/.cache/pip /home/librarian/.cache/pdm

# Install pdm
RUN --mount=type=cache,target=/home/librarian/.cache/pip \
    --mount=type=cache,target=/home/librarian/.cache/pdm \
    pip install --user pdm

# Copy the dependencies file
COPY pyproject.toml pdm.lock ./

# Copy the application code
COPY src src
COPY README.md ./

# Install the dependencies
RUN --mount=type=cache,target=/home/librarian/.cache/pip \
    --mount=type=cache,target=/home/librarian/.cache/pdm \
    /home/librarian/.local/bin/pdm sync --prod --no-editable

# Use a lightweight base image
FROM python:3.11-slim-bullseye

# Create a non-root user
RUN useradd -m librarian

# Set the working directory
WORKDIR /home/librarian/app

# Switch to the non-root user
USER librarian

# Retrieve application
COPY --from=build \
    /home/librarian/app /home/librarian/app

# Expose the default HTTP port
EXPOSE 8080

# Set the entrypoint command
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# Set the default command
CMD ["uvicorn", "src.librarian.server:app", "--host", "0.0.0.0", "--port", "8080"]
