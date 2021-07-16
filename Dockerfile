FROM udacimak/udacimak:latest
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Add Tini init
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# API vars
ENV NODE_TAG v11.1.0
ENV API_PATH /usr/local/nvm/versions/node/${NODE_TAG}/lib/node_modules/udacimak/lib/api

# Remove old api path
RUN rm -r ${API_PATH}

# Add new patched api path
ADD api ${API_PATH}

# Add entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /downloads
VOLUME /downloads

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
CMD ["udacimak"]
