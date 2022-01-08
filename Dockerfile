FROM alpine:latest as build

RUN apk --no-cache add ca-certificates py-pygments py-setuptools wget jq

COPY host.sh /bin

RUN HUGO_VER="$(wget -q -O - https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r .name | awk -F 'v' '{print $2}')" &&\
  ARCH="$(sh /bin/host.sh)" && rm /bin/host.sh && \
  mkdir /tmp/hugo &&\
  cd /tmp/hugo &&\
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_${HUGO_VER}_Linux-${ARCH}.tar.gz &&\
  tar zxvf hugo_${HUGO_VER}_Linux-${ARCH}.tar.gz

# -------------------------------------------------------

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=build /tmp/hugo/hugo /usr/local/bin/hugo

RUN chmod +x /usr/local/bin/hugo &&\
    mkdir /data

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/hugo"]
CMD [""]