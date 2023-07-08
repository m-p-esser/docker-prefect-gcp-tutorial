##### This Base Layer contains all software to run in all environments #####

ARG ALPINE_VERSION
ARG COMPOSER_VERSION
ARG PYTHON_VERSION

FROM composer:${COMPOSER_VERSION} as composer
FROM alpine:${ALPINE_VERSION} as base

# install git-secret
# @see https://git-secret.io/installation#alpine
ADD https://gitsecret.jfrog.io/artifactory/api/security/keypair/public/repositories/git-secret-apk /etc/apk/keys/git-secret-apk.rsa.pub

# @see https://www.pascallandau.com//blog/git-secret-encrypt-repository-docker/
RUN echo "https://gitsecret.jfrog.io/artifactory/git-secret-apk/all/main" >> /etc/apk/repositories  && \
   apk add --update --no-cache \
   bash \
   git \
   git-secret \
   # required for git-secret
   gawk \
   gnupg \
   make \
   strace \
   sudo

##### This Layer installs Python and all dependencies #####

FROM base as local
FROM python:${PYTHON_VERSION}

ARG POETRY_VERSION
RUN pip install poetry==${POETRY_VERSION}
# RUN python -m venv /venv
RUN rm -f pyproject.toml
RUN poetry init -n
RUN poetry add black flake8 pre-commit ipykernel -G dev
RUN poetry add prefect pandas



# COPY pyproject.toml poetry.lock ./
# RUN poetry export -f requirements.txt | /venv/bin/pip install -r /dev/stdin

# COPY . .
# RUN poetry build && /venv/bin/pip install dist/*.whl