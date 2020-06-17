FROM alpine:latest
MAINTAINER Alex Miranda<alexmirandamoraes@gmail.com>

WORKDIR /root

RUN apk add --no-cache git make musl-dev go vim && \
  mkdir -p $HOME/.vim/pack/minpac/opt && \
  git clone https://github.com/k-takata/minpac.git \
    $HOME/.vim/pack/minpac/opt/minpac \
    --depth 1 \
    --shallow-submodules \
    --no-tags

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV TERM xterm-256color

ADD vimrc .vimrc
ADD vim/ .vim/
RUN vim -n +"call minpac#update('',{'do':'qa!'})"

ENTRYPOINT ["vim"]
