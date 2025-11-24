# Dockerfile
FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /notebooks

# Install system deps commonly useful for notebooks (git, build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install Python packages: jupyter and pip
RUN pip install --no-cache-dir pip setuptools wheel jupyter

# If you have a requirements.txt, COPY it and install
# (When building, place requirements.txt next to the Dockerfile)
COPY requirements.txt /notebooks/requirements.txt
RUN if [ -f /notebooks/requirements.txt ]; then \
      pip install --no-cache-dir -r /notebooks/requirements.txt ; \
    fi

COPY . .

# Create a user (optional) - use root for simplicity or create jovyan user:
# (Jupyter will run as root by default here via CMD; adjust if you add a non-root user)
# RUN chown -R root:root /notebooks

EXPOSE 8888

# Command to run jupyter. By default this disables the token for easier local use.
# For security in production remove --NotebookApp.token='' and use the generated token or a password.
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''", "--allow-root", "--NotebookApp.notebook_dir=/notebooks"]

