FROM python:3

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Jakarta \
    GECKO_URL=https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-linux64.tar.gz

RUN echo "invoke >= 0.20" > requirements.txt && \
    echo "rellu >= 0.6" >> requirements.txt && \
    echo "docutils >= 0.14" >> requirements.txt && \
    echo "robotframework >= 3.1.1" >> requirements.txt && \
    echo "robotframework-seleniumlibrary >= 3.3.1" >> requirements.txt && \
    echo "robotframework-selenium2library >= 3.0.0" >> requirements.txt && \
    python -m pip install --upgrade pip && \
    pip3 install -r requirements.txt && \
    apt update && \
    apt install --no-install-recommends --force-yes -y firefox-esr curl && \
    curl -sSL -o gecko.tar.gz $GECKO_URL && \
    tar -xvf gecko.tar.gz -C /bin && \
    apt clean && \
    apt autoremove -y && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache/apt/archives -type f -delete && \
    mkdir -p /opt/robot /opt/log


VOLUME [ "/opt/robot", "/opt/log" ]
WORKDIR /opt/robot