FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV EMACS_VERSION=30.1

# -----------------------------
# System dependencies for Emacs + LaTeX (Tectonic) + search tools
# -----------------------------
RUN sed -i 's/^# deb/deb/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential autoconf automake texinfo pkg-config libncurses-dev \
        libgtk-3-dev libgnutls28-dev \
        libxml2-dev libjpeg-dev libpng-dev libtiff-dev libgif-dev libxpm-dev \
        libharfbuzz-dev libjansson-dev libmagickwand-dev \
        curl git locales sudo \
        silversearcher-ag ripgrep fd-find aspell aspell-en \
        xclip xsel imagemagick x11-apps \
        fonts-dejavu ca-certificates \
	tj3 \
	inotify-tools \
        ssh \
    && rm -rf /var/lib/apt/lists/*
# Install Tectonic pdflatex with dynamic modules
RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh && \
    mv tectonic /usr/local/bin/tectonic && \
    chmod +x /usr/local/bin/tectonic


# -----------------------------
# Locales (UTF-8) and Timezone
# -----------------------------
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Europe/Brussels

RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /root
ENV HOME=/root
ENV PATH="/root/.local/bin:${PATH}"

# -----------------------------
# Download and build Emacs 30.1 from source
# -----------------------------
RUN curl -L -o /tmp/emacs.tar.gz https://ftp.gnu.org/gnu/emacs/emacs-$EMACS_VERSION.tar.gz \
    && cd /tmp \
    && tar -xzf emacs.tar.gz \
    && cd emacs-$EMACS_VERSION \
    && ./configure --with-x-toolkit=gtk3 --with-xft --with-imagemagick --without-selinux \
    && make -j$(nproc) \
    && sudo make install \
    && cd / \
    && rm -rf /tmp/emacs-$EMACS_VERSION /tmp/emacs.tar.gz

# -----------------------------
# Install Spacemacs (develop) and Org 9.7
# -----------------------------
# Install Spacemacs
RUN git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
# Install Org
RUN emacs --batch \
    --eval "(require 'package)" \
    --eval "(add-to-list 'package-archives '(\"org\" . \"https://orgmode.org/elpa/\"))" \
    --eval "(package-initialize)" \
    --eval "(package-refresh-contents)" \
    --eval "(package-install 'org)"

# -----------------------------
# Copy your Spacemacs config & private layers
# -----------------------------
COPY ./.spacemacs /root/.spacemacs
COPY ./ox-taskjuggler.el /root/.emacs.d/private/local/taskjuggler/ox-taskjuggler.el

# -----------------------------
# Pre-refresh package archives
# -----------------------------
RUN emacs --batch --eval '(package-refresh-contents)' || true

# -----------------------------
# Spacemacs sync helper
# -----------------------------
RUN cat > /root/spacemacs-sync.el <<'EOF'
(setq dotspacemacs-scratch-mode (quote text-mode))
(configuration-layer/initialize)
(condition-case err
    (progn
      (configuration-layer/sync)
      (kill-emacs 0))
  (error
   (message "Caught error: %s" err)
   (kill-emacs 1)))
EOF

# Retry loop (3 attempts)
RUN for i in 1 2 3; do \
      echo "=== Spacemacs preinstall attempt $i ==="; \
      if emacs --batch -l ~/.emacs.d/init.el -l /root/spacemacs-sync.el; then \
        echo "=== Spacemacs preinstall succeeded on attempt $i ==="; \
        break; \
      else \
        echo "=== Attempt $i failed; retrying in 10 seconds... ==="; \
        sleep 10; \
      fi; \
    done || true

# -----------------------------
# Workspace dir
# -----------------------------
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["emacs"]

