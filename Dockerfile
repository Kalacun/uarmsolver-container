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

ENV PACKAGES="uarmsolver"

RUN apk update \
      && apk upgrade \
      && apk add --no-cache $PACKAGES \
      && rm -rf /var/cache/apk/*

COPY dataset.csv /opt/dataset.csv
COPY arm.set /opt/arm.set

RUN chmod -R 777 /opt

RUN cp /opt/dataset.csv /var/uarmsolver/ && cp /opt/arm.set /var/uarmsolver/

RUN ls -l /var/uarmsolver && cat /var/uarmsolver/arm.set

RUN mkdir -p /mnt/output && chmod -R 777 /mnt/output

CMD ["sh", "-c", "uARMSolver -s /var/uarmsolver/arm.set > /var/uarmsolver/solver.log 2>&1 || { echo 'uARMSolver failed with exit code $?'; cat /var/uarmsolver/solver.log; }; cp /var/uarmsolver/rules.txt /mnt/output/rules.txt"]
