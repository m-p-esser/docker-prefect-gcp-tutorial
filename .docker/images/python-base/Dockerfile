# ARG ALPINE_VERSION
# ARG COMPOSER_VERSION
# FROM composer:${COMPOSER_VERSION} as composer
# FROM alpine:${ALPINE_VERSION} as base

FROM composer:${COMPOSER_VERSION} as composer
FROM alpine:${ALPINE_VERSION} as base
FROM python:${PYTHON_VERSION} as python

# WORKDIR /src

# RUN pip install poetry
# RUN poetry shell