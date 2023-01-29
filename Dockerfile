FROM node:19-alpine

LABEL maintainer="Satit Rianpit <rianpit@gmail.com>"

WORKDIR /app

ENV NODE_ENV === 'production'

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  git \
  tzdata \
  build-base \
  libtool \
  autoconf \
  automake \
  g++ \
  make && \
  cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
  echo "Asia/Bangkok" > /etc/timezone

RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm

RUN git clone https://github.com/R7-DataLake/worker.git && \
  cd worker && \
  pnpm i

CMD ["node", "/app/worker/src/worker.js"]
