FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY /bin/* .
USER 65532:65532

ENTRYPOINT ["/webapp"]
