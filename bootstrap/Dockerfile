FROM ubuntu:jammy AS builder
RUN apt-get update && apt-get install -y wget

RUN wget -O /tmp/kubectl https://dl.k8s.io/release/v1.25.3/bin/linux/amd64/kubectl && chmod +x /tmp/kubectl
RUN wget -O /tmp/ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.43.0/ytt-linux-amd64 && chmod +x /tmp/ytt
RUN wget -O /tmp/kbld https://github.com/vmware-tanzu/carvel-kbld/releases/download/v0.35.0/kbld-linux-amd64 && chmod +x /tmp/kbld
RUN wget -O /tmp/imgpkg https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/v0.33.0/imgpkg-linux-amd64 && chmod +x /tmp/imgpkg
RUN wget -O /tmp/kapp https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.53.0/kapp-linux-amd64 && chmod +x /tmp/kapp

FROM ubuntu:jammy
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates && apt-get clean && /bin/rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 bootstrap && useradd -g 1000 -u 1000 -m bootstrap
COPY entrypoint.sh /home/bootstrap/entrypoint.sh
RUN chmod +x /home/bootstrap/entrypoint.sh && chown bootstrap:bootstrap /home/bootstrap/entrypoint.sh

USER bootstrap
WORKDIR /home/bootstrap

COPY --from=builder /tmp/kubectl /usr/local/bin/kubectl
COPY --from=builder /tmp/ytt ytt
COPY --from=builder /tmp/kbld kbld
COPY --from=builder /tmp/imgpkg imgpkg
COPY --from=builder /tmp/kapp kapp

CMD ["/bin/bash", "-c", "/home/bootstrap/entrypoint.sh"]
