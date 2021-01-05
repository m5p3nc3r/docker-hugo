FROM alpine:latest

RUN apk --no-cache add ca-certificates py-pygments py-setuptools wget

COPY host.sh /bin

RUN apk --no-cache add jq &&\
  HUGO_VER="$(wget -q -O - https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r .name | awk -F 'v' '{print $2}')" &&\
  ARCH="$(sh /bin/host.sh)" && rm /bin/host.sh && \
  mkdir /tmp/hugo &&\
  cd /tmp/hugo &&\
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_${HUGO_VER}_Linux-${ARCH}.tar.gz &&\
  tar zxvf hugo_${HUGO_VER}_Linux-${ARCH}.tar.gz &&\
  mv hugo /usr/local/bin/hugo &&\
  cd / &&\
  rm -rf /tmp/hugo &&\
  chmod +x /usr/local/bin/hugo &&\
  mkdir /data &&\
  apk --no-cache del jq

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/hugo"]
CMD [""]