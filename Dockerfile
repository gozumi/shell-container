FROM ubuntu:latest

RUN apt-get update && apt-get install \
    sudo adduser zsh git iproute2 \
    ansible openssh-server -y

RUN mkdir -p /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ARG USERNAME=developer
ARG HOME_DIR=/home/${USERNAME}

RUN adduser ${USERNAME}
RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# --- Docker Engine (for Docker-in-Docker) ---
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg iptables && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
        https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y --no-install-recommends \
        docker-ce docker-ce-cli containerd.io \
        docker-buildx-plugin docker-compose-plugin && \
    groupadd -f docker && usermod -aG docker ${USERNAME} && \
    rm -rf /var/lib/apt/lists/*

# --- Supabase CLI (binary; npm global is unsupported upstream) ---
RUN SUPABASE_VER="$(curl -fsSL https://api.github.com/repos/supabase/cli/releases/latest \
        | grep -oP '"tag_name":\s*"v\K[^"]+')" && \
    ARCH="$(dpkg --print-architecture)" && \
    curl -fsSL "https://github.com/supabase/cli/releases/download/v${SUPABASE_VER}/supabase_linux_${ARCH}.tar.gz" \
        | tar -xz -C /usr/local/bin supabase && \
    chmod +x /usr/local/bin/supabase

# --- Entrypoint: start dockerd, then hand off to sshd (or the given command) ---
RUN cat > /usr/local/bin/entrypoint.sh <<'EOF' && chmod +x /usr/local/bin/entrypoint.sh
#!/usr/bin/env bash
set -e
if ! docker info >/dev/null 2>&1; then
  dockerd --storage-driver=overlay2 >/var/log/dockerd.log 2>&1 &
  for i in $(seq 1 30); do docker info >/dev/null 2>&1 && break; sleep 1; done
fi
if [ "$#" -gt 0 ]; then exec "$@"; else exec /usr/sbin/sshd -D; fi
EOF

EXPOSE 22

# Generate SSH host keys
RUN ssh-keygen -A

RUN mkdir ${HOME_DIR}/.ssh && chown ${USERNAME}:${USERNAME} ${HOME_DIR}/.ssh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
