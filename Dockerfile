FROM alpine:edge AS builder

RUN apk add --update --no-cache perl perl-dev perl-utils make wget curl
RUN curl -sL --compressed https://git.io/cpm > cpm \
    && chmod +x cpm \
    && ./cpm install -L /usr/local TAP::Parser::SourceHandler::pgTAP

FROM alpine:edge
RUN apk add --update perl postgresql-client
COPY --from=builder /usr/local /usr/local
ENV PERL5LIB /usr/local/lib/perl5
WORKDIR /tmp
