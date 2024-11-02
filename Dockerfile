# Dockerfile
FROM zabbix/zabbix-server-mysql:7.0-ubuntu-latest

# Switch to root user to install packages
USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl net-tools snmp-mibs-downloader bc python3-venv && \
    download-mibs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install python-kasa
RUN python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install python-kasa

# Switch back to the original user (if the base image defines one)
USER zabbix

# Add environment variables to path
ENV PATH="/opt/venv/bin:$PATH"
