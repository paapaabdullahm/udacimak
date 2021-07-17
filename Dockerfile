FROM udacimak/udacimak:latest
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Eenvironment vars
ENV NODE_TAG v11.1.0
ENV TINI_TAG v0.19.0
ENV YT_DL_TAG latest
ENV NODE_PATH /usr/local/nvm/versions/node/${NODE_TAG}/lib/node_modules
ENV UDACIMAK_API_PATH ${NODE_PATH}/udacimak/lib/api
ENV YT_DL_PATH ${NODE_PATH}/udacimak/node_modules/youtube-dl

# Add Tini init
ADD https://github.com/krallin/tini/releases/download/${TINI_TAG}/tini /tini
RUN chmod +x /tini

# Add latest Youtube-DL
ADD https://yt-dl.org/downloads/${YT_DL_TAG}/youtube-dl ${YT_DL_PATH}/bin/youtube-dl
RUN chmod a+rx ${YT_DL_PATH}/bin/youtube-dl

# Install and configure locale
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt install -y locales libc-l10n; \
    #
    # uncomment en_US.UTF-8 and generate locale
    sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen; \
    locale-gen; \
    #
    # export locale env vars
    export LC_ALL=en_US.UTF-8; \
    export LANG=en_US.UTF-8; \
    export LANGUAGE=en_US.UTF-8; \
    #
    # persist locale env vars
    echo 'LC_ALL="en_US.UTF-8"' | tee -a /etc/environment > /dev/null; \
    echo 'LANG="en_US.UTF-8"' | tee -a /etc/environment > /dev/null; \
    echo 'LANGUAGE="en_US.UTF-8"' | tee -a /etc/environment > /dev/null

# Replace old udacimak api with patched version
RUN rm -r ${UDACIMAK_API_PATH}
ADD api ${UDACIMAK_API_PATH}

# Add entrypoint script
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /downloads
VOLUME /downloads

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
CMD ["udacimak"]
