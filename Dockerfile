ARG APPLICATION="custom-jre-docker-example" JDK_VERSION="21.0.5"

FROM docker.io/debian:bookworm-slim AS jdk
ARG JDK_VERSION
ENV JAVA_HOME="/opt/jdk-${JDK_VERSION}" PATH="/opt/jdk-${JDK_VERSION}/bin:${PATH}"
RUN apt update && apt upgrade -y && apt install curl binutils -y && \
    mkdir -p ${JAVA_HOME} && \
    # Set all the required variables for JDK installation
    case $(arch) in \
      "x86_64") OS_ARCH="x64";; \
      "aarch64") OS_ARCH="aarch64";; \
      "arm64") OS_ARCH="aarch64";; \
      *) log ERROR "Unsupported architecture '$(arch)'"; exit 1;; \
    esac && \
    JDK_MAYOR_VERSION="${JDK_VERSION%%.*}" && JDK_FILE_NAME="jdk-${JDK_VERSION}_linux-${OS_ARCH}_bin.tar.gz" && \
    # Download the JDK and checksum \
    cd ${JAVA_HOME} && \
    curl --silent --output ${JDK_FILE_NAME} https://download.oracle.com/java/${JDK_MAYOR_VERSION}/archive/${JDK_FILE_NAME} && \
    curl --silent --output ${JDK_FILE_NAME}.sha256 https://download.oracle.com/java/${JDK_MAYOR_VERSION}/archive/${JDK_FILE_NAME}.sha256 && \
    # Verify the checksum and delete all the non required files
    echo "$(cat ${JDK_FILE_NAME}.sha256) ${JDK_FILE_NAME}" | sha256sum --quiet --strict --check - && \
    tar --extract --file ${JDK_FILE_NAME} --strip-components 1 --no-same-owner && \
    rm ${JDK_FILE_NAME} ${JDK_FILE_NAME}.sha256;

FROM jdk AS jre
ARG APPLICATION JDK_VERSION
# Search and copy the ${APPLICATION}.jar from the build/target (gradle/maven build) path
COPY **/**/${APPLICATION}.jar /application/${APPLICATION}.jar
RUN mkdir -p /application/${APPLICATION} &&  \
    cd /application/${APPLICATION} && \
    jar --extract --file /application/${APPLICATION}.jar && \
    cd /application/${APPLICATION} && \
    jdeps --ignore-missing-deps \
        -quiet  \
        --recursive  \
        --multi-release ${JDK_VERSION%%.*}  \
        --print-module-deps  \
        --class-path /application/${APPLICATION}/BOOT-INF/lib/* /application/${APPLICATION}.jar > /application/${APPLICATION}/deps.info && \
    jlink --add-modules $(cat /application/${APPLICATION}/deps.info) \
        --strip-debug \
        --compress zip-9 \
        --no-header-files \
        --no-man-pages \
        --output /opt/java/jre-${JDK_VERSION} && \
    rm -rf /application/${APPLICATION} /application/${APPLICATION}/deps.info;

FROM docker.io/debian:bookworm-slim
ARG APPLICATION JDK_VERSION
COPY --from=jre /opt/java/jre-${JDK_VERSION} /opt/java/jre-${JDK_VERSION}
COPY --from=jre /application/${APPLICATION}.jar /application/${APPLICATION}.jar
ENTRYPOINT /opt/java/$(ls /opt/java | grep jre | head)/bin/java -jar ${JAVA_OPTS} /application/$(ls /application | grep .jar | head)