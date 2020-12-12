FROM alpine:latest

RUN apk --update --no-cache add tftp-hpa

EXPOSE 69/udp
ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--secure", "/opt/tftp"]