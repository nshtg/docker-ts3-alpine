FROM frolvlad/alpine-glibc:alpine-3.10
MAINTAINER nshtg <mail@msch.pw>

ENV TS_DIR="/opt/teamspeak" \
    TS_RELEASE="https://files.teamspeak-services.com/releases/server/3.9.1/teamspeak3-server_linux_amd64-3.9.1.tar.bz2" \
    TS_SHA256="0a0497d6a8e5f3f48e10db8f89875286d6aa3388f171f828cf5d426cf305f16f" \
    TS_ARTIFACT="teamspeak.tar.bz2" \
    TS_DATA="/data"

RUN apk --no-cache add tar \
    && mkdir -p "${TS_DIR}" \
    && wget "${TS_RELEASE}" -O "${TS_ARTIFACT}" \
    && if [ $(sha256sum "${TS_ARTIFACT}" | cut -d" " -f 0) != $TS_SHA ]; then echo "CHECKSUM FAILED"; exit 1; fi \
    && tar -xjf "${TS_ARTIFACT}" -C "${TS_DIR}" --strip-components=1 \
    && rm "${TS_ARTIFACT}" "${TS_DIR}/CHANGELOG" "${TS_DIR}/libts3db_mariadb.so" \
    && rm -r "${TS_DIR}/doc" "${TS_DIR}/redist" "${TS_DIR}/serverquerydocs" "${TS_DIR}/tsdns"

COPY data/ ${TS_DATA}
VOLUME ${TS_DATA}
RUN for file in $(find ${TS_DATA} -mindepth 1 -maxdepth 1); do \
    ln -s "${file}" $(echo $file | sed 's@^'"${TS_DATA}"'@'"${TS_DIR}"'@g') \
    ; done

EXPOSE 9987/udp 10011 30033

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
