FROM creiscomputing/xpbwalletman_appbase

ARG BUILD_BRANCH=develop

# Install requirements
RUN \
    # add deploy keys
    eval "$(ssh-agent -s)" \
    && ssh-add "${WWW_PATH}"/creis-build-key \
    # accept github as a host
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    && cd ${APP_PATH} \
    && git checkout --detach \
    && (git branch -D ${BUILD_BRANCH} || true) \
    && git fetch -p \
    && git checkout ${BUILD_BRANCH} \
    && git submodule update --recursive --remote \
    # check for new required packages
    && pip install -b /pipbuild --no-cache-dir --upgrade -r requirements.txt \
    && rm -rf /pipbuild

# Remove .pyc files / __pycache__ folders
RUN find . | grep -E "(__pycache__|\.pyc$)" | xargs rm -rf
