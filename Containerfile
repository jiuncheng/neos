FROM quay.io/fedora/fedora-kinoite:40 AS neos-next

COPY usr /usr

RUN rpm-ostree install bootc distrobox fish neovim gnome-console libgda libgda-sqlite \
    htop fzf libratbag-ratbagd libva-utils lshw \
    google-noto-sans-cjk-fonts solaar-udev openssl zstd wireguard-tools xwaylandvideobridge

RUN rpm-ostree install kate kio-admin

RUN rpm-ostree override remove firefox firefox-langpacks

COPY etc/yum.repos.d/ /etc/yum.repos.d/

RUN rpm-ostree install code jetbrains-mono-fonts-all \
    google-go-mono-fonts google-droid-sans-mono-fonts \
    fira-code-fonts mozilla-fira-sans-fonts powerline-fonts

RUN systemctl enable rpm-ostreed-automatic.timer

RUN rm -f /etc/yum.repos.d/vscode.repo && \
    rm -rf /tmp/* /var/* && \
    ostree container commit
