FROM alpine:edge

ENV NAME=uarmsolver-container VERSION=0 ARCH=x86_64

LABEL org.label-schema="$NAME" \
     name="$FGC/$NAME" \
     version="$VERSION" \
     architecture="$ARCH" \
     run="podman run -it IMAGE" \
     maintainer="Iztok Fister, Jr. <iztok@iztok-jr-fister.eu>" \
     url="https://codeberg.org/firefly-cpp/uarmsolver-container" \
     summary="uarmsolver container" \
     description="uarmsolver container"

WORKDIR /var/uarmsolver/

ENV PACKAGES="\
    uarmsolver \
"

RUN apk update \
    && apk upgrade && apk add --no-cache \
    $PACKAGES \
    && rm -rf /var/cache/apk/*

COPY dataset.csv arm.set .

RUN uARMSolver -s arm.set

CMD ["/bin/sh"]
