FROM mshahmi/docker-magento2-base
LABEL maintainer="Shahmi Majid"
LABEL version="2.2.5"
LABEL description="Magento 2.2.5"

RUN ["/bin/bash", "-c", "/usr/local/bin/install-magento"]