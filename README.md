# Docker image for Magento 2 

[![wercker status](https://app.wercker.com/status/4cfaeeea9b0b6ea8ea377d32c97e2e21/s/ "wercker status")](https://app.wercker.com/project/byKey/4cfaeeea9b0b6ea8ea377d32c97e2e21)

[![Docker build](http://dockeri.co/image/mshahmi/docker-magento2)](https://hub.docker.com/r/mshahmi/docker-magento2/)

This repo consist of 2 parts which are :
  * Magento Docker Base Image Build  [[check here for the repo]](https://github.com/shahmimajid/docker-magento2-base)
  * Magento Docker Compose & Deployment

  We're separating the Magento Docker Build Image and Magento Docker Compose & Deployment because the to build the docker image is taking longer time. 
  
  Moreover , the docker images that is going to build will be the same version like previous build. The changes won't be that frequency. So, we can save our time and able to focus more on development rather than build.

  
  **Please note: this Docker image is for development and testing only, not for production use. Setting up a Magento 2 production server requires more configurations. Please refer to [official documentations](http://devdocs.magento.com/guides/v2.2/config-guide/deployment/).**


# Magento 2 installation types

Magento 2 has three different ways to [install](http://devdocs.magento.com/guides/v2.2/install-gde/bk-install-guide.html), for users, integrators and developers. This Docker image uses **integrator** as the default installation type, so the **Web Setup Wizard** can be used.

For our setup , we're using composer to install our Magento 2 Application.