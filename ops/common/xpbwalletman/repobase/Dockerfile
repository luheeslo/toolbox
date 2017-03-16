FROM python:2.7

ENV WWW_PATH    /var/www
ENV APP_NAME    xpbwalletman
ENV APP_PATH    ${WWW_PATH}/${APP_NAME}


# Install dependencies
RUN apt-get -y update \
    && apt-get install --no-install-recommends -y \
                        ca-certificates \
                        openssh-client \
                        git


# Create working directory
RUN mkdir -p "${WWW_PATH}"
WORKDIR "${WWW_PATH}"

# Get repository keys to be able to clone them
COPY creis-build-key ${WWW_PATH}

RUN chmod 600 ${WWW_PATH}/creis-build-key

# Clone latest source from repository
RUN \
    # add deploy key
    eval "$(ssh-agent -s)" \
    && ssh-add ${WWW_PATH}/creis-build-key \
    # accept github as a host
    && mkdir ~/.ssh \
    && touch ~/.ssh/known_hosts \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    && git clone --recursive git@github.com:creiscomputing/${APP_NAME}.git \
    && cd ${APP_NAME}


WORKDIR "${APP_PATH}"
