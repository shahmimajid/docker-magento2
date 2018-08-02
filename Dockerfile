FROM mshahmi/docker-magento2-base
LABEL maintainer="Shahmi Majid"
LABEL version="2.2.5"
LABEL description="Magento 2.2.5"

CMD ./usr/local/bin/install-magento

COPY ./install-sampledata /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata

CMD ./usr/local/bin/install-sampledata
