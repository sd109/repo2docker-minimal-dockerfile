# FROM python:3.9-slim
# Use a more complete base image
FROM ubuntu:22.04

# Install arbitrary OS packages
RUN apt-get update && apt-get install -y \
    curl \
    netcat

# Install other programming languages
RUN curl -fsSL https://install.julialang.org | sh -s -- -y

# install the required notebook packages
RUN apt-get update && apt-get install -y python3-pip
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab


# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
