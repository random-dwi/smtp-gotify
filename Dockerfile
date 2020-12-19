ARG ARCH

FROM alpine:latest as certs
RUN apk --update --no-cache add ca-certificates && update-ca-certificates

FROM ${ARCH}/alpine

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY smtp-gotify /usr/bin/smtp-gotify

USER daemon

ENV SG_SMTP_LISTEN "0.0.0.0:2525"
EXPOSE 2525

ENTRYPOINT ["/usr/bin/smtp-gotify"]
