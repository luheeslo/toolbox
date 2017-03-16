FROM creiscomputing/xpbwalletman_repobase

ENV APP_ADDRESS 0.0.0.0
ENV APP_PORT 9500
ENV APP_BIND_ADDRESS ${APP_ADDRESS}:${APP_PORT}

# Install requirements
RUN \
    # add deploy keys
    eval "$(ssh-agent -s)" \
    && ssh-add "${WWW_PATH}"/creis-build-key \
    # accept github as a host
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    # install
    && pip install -b /pipbuild --no-cache-dir -r requirements.txt \
    && rm -rf /pipbuild

# Remove .pyc files / __pycache__ folders
RUN find . | grep -E "(__pycache__|\.pyc$)" | xargs rm -rf

EXPOSE ${APP_PORT}

CMD gunicorn --bind=${APP_BIND_ADDRESS} --error-logfile - --access-logfile - --log-level debug --workers=2 xpbwalletman:app
