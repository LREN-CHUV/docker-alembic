FROM python:3.6.1-alpine

MAINTAINER mirco.nasuti@chuv.ch

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

########################################################################################################################
# Install Dockerize
########################################################################################################################

ENV DOCKERIZE_VERSION=v0.6.0
RUN apk update && apk add wget postgresql-dev \
    && wget -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz \
    && rm -rf /var/cache/apk/* /tmp/*

########################################################################################################################
# Install Alembic and Psycopg2
########################################################################################################################
ENV ALEMBIC_VERSION='0.9.1' \
    PSYCOPG2_VERSION='2.7.4'

RUN apk update \
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  && pip install --no-cache-dir alembic==$ALEMBIC_VERSION psycopg2-binary==$PSYCOPG2_VERSION \
  && apk del build-deps gcc

########################################################################################################################
# Copy project files
########################################################################################################################

COPY alembic.ini.tmpl /alembic.ini.tmpl
#COPY db_migrations/ /db_migrations/


########################################################################################################################
# Setup entrypoint and cmd
########################################################################################################################

WORKDIR /
ENTRYPOINT ["dockerize", "-template", "/alembic.ini.tmpl:/alembic.ini", "alembic"]
CMD ["help"]

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="hbpmip/alembic" \
      org.label-schema.description="Database setup with Alembic" \
      org.label-schema.url="https://github.com/LREN-CHUV/alembic" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/LREN-CHUV/alembic" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="$VERSION" \
      org.label-schema.vendor="LREN CHUV" \
      org.label-schema.license="Apache2.0" \
      org.label-schema.docker.dockerfile="Dockerfile" \
      org.label-schema.schema-version="1.0"
