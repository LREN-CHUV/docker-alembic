[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/docker-alembic/blob/master/LICENSE) [![DockerHub](https://img.shields.io/badge/docker-hbpmip%2Falembic-008bb8.svg)](https://hub.docker.com/r/hbpmip/alembic/) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/TODO)](https://www.codacy.com/app/hbp-mip/alembic?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/alembic&amp;utm_campaign=Badge_Grade)
[![CircleCI](https://circleci.com/gh/LREN-CHUV/docker-alembic.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/docker-alembic)

# Docker image for Alembic database migrations

Base image to create SQL migrations using [Alembic](http://alembic.zzzcomputing.com/en/latest/).

## Introduction

The goal of this project is to provide a Docker container including Alembic.

To use migrations with Alembic, you need either to mount a folder /db_migrations containing the migrations or create a child image including the migrations in its /db_migrations folder.

## Usage

Example:

`docker run --rm -e "DB_URL=postgresql://postgres:postgres@localhost:5432/postgres" hbpmip/alembic upgrade head`

## Build

Run: `./build.sh`

## Test

Run: `.tests/test.sh`

## Publish on Docker Hub

Run: `./publish.sh`

## License

### docker-alembic

(This project)

Copyright (C) 2010-2017 [LREN CHUV](https://www.unil.ch/lren/en/home.html)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Alembic

This is the MIT license: http://www.opensource.org/licenses/mit-license.php

Copyright (C) 2009-2017 by Michael Bayer.
Alembic is a trademark of Michael Bayer.

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
