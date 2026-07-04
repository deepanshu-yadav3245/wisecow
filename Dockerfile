# Wisecow Application Dockerfile
FROM ubuntu:22.04

# Install prerequisites:
# - fortune-mod & cowsay : required by the app
# - netcat-openbsd       : the script uses `nc -lN` (OpenBSD netcat syntax)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        cowsay \
        netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# IMPORTANT: fortune and cowsay are installed in /usr/games,
# which is NOT in the default PATH inside the container.
ENV PATH="/usr/games:${PATH}"

WORKDIR /app

COPY wisecow.sh .

RUN chmod +x wisecow.sh

# App listens on port 4499 by default
EXPOSE 4499

CMD ["./wisecow.sh"]
