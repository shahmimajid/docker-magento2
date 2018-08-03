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

## Quick start

The easiest way to start Magento 2 with MySQL is using [Bash Script - Install.sh]. Just clone this repo and run following command in the root directory. 

~~~
$ bash install.sh
~~~

It will run the docker-compose in detachable and automatic install the Magento Application.

For admin username and password, please refer to the file `env`. You can also update the file `env` to update those configurations. Below are the default configurations.

~~~
MYSQL_HOST=db
MYSQL_ROOT_PASSWORD=myrootpassword
MYSQL_USER=magento
MYSQL_PASSWORD=magento
MYSQL_DATABASE=magento

MAGENTO_LANGUAGE=en_US
MAGENTO_TIMEZONE=Asia/Kuala_Lumpur
MAGENTO_DEFAULT_CURRENCY=MYR
MAGENTO_URL=http://local.magento
MAGENTO_BACKEND_FRONTNAME=admin
MAGENTO_USE_SECURE=0
MAGENTO_BASE_URL_SECURE=0
MAGENTO_USE_SECURE_ADMIN=0

MAGENTO_ADMIN_FIRSTNAME=Admin
MAGENTO_ADMIN_LASTNAME=MyStore
MAGENTO_ADMIN_EMAIL=admin@example.com
MAGENTO_ADMIN_USERNAME=superadm2018
MAGENTO_ADMIN_PASSWORD=2018magento2
~~~

You can change the configuration above according your needs. Example , change `MAGENTO_URL=http://local.magento` to other URL by updating local.magento into other URL, e.g `MAGENTO_URL=http://magento2.online` .


## Installation

After starting the container, you'll see the setup page of Magento 2. You can use the script `install-magento` to quickly install Magento 2. The installation script uses the variables in the `env` file. You can refer `install.sh` content to see where does script `install-magento` stored.


### Why accessing http://local.magento?

For development and testing in the local environment, using `localhost` as Magento 2 URL has some issues. The default `env` file use `http://local.magento` as the value of `MAGENTO_URL`. You need to [edit your `hosts` file](https://support.rackspace.com/how-to/modify-your-hosts-file/) to add the mapping from `local.magento` to `localhost`. You can use any domain names as long as it looks like a real domain, not `localhost`.

If `localhost` doesn't work, try using `127.0.0.1`.

```
127.0.0.1    local.magento
```


# PHP Unit Test

In order to run unit test for our Magento2 Application , we need to run the unit test command within the container it self.

Before we start the PHP Unit test , we need to ensure that we already run `install.sh` command , so that all the services is up and Magento Web is available to test.

Once you've confirm all the services are running , we can start our unit test.

Command to start with :

```
docker exec -it $(docker ps | grep "docker-magento2-base" |awk '{print $1}') bash
```

You will be ssh into the container as below :

```
root@[containerid]:/var/www/html#
```

You can proceed the test using Command Usage as below :

```
bin/magento dev:tests:run <test>
```

For example, to run integration tests:

```
bin/magento dev:tests:run integration
```

## Type of Unit Test that Available

Below is the list of unit test that you can run :
   * all
   * unit
   * integration
   * integration-all 
   * static 
   * static-all 
   * integrity 
   * legacy  
   * default


# Deployment

Deployment will be triggered whenever any changes on master branch.

To ensure our CI able to deploy , we need to :

   * Generate key from Wercker Environment
   * Copy id_rsa.pub content from Wercker and put into our server in ~/.ssh/authorized_keys
   * Ensure no firewall blocking port 22

Variable that need to set :
   * user ( user to ssh)
   * DEVURL ( To update DEV URL with FQDN)
   * devserver ( Server that we want to deploy)

Since we've integrate Wercker as part of our CI (Continuous Integration) , you can rerun the deployment via the Wercker console.

Workflow as below :

```
Any changes on Master Repo --> Triggered Wercker Build --> Build Complete --> Deployed to Server
```

## Requirement for the Server

   * Any linux server with Docker & Docker-composed installed
   * Allow port 22 ( Whitelisted Wercker CI IP Range to secure our ssh port)
   * Memory 2GB & Disk Space 10GB above
   * Preinstalled Wercker public key in authorized_keys
   * FQDN Ready for hostname of the server and the domain name for the docker application

# Monitoring

We need to ensure our server and application is highly availabiliy and if there any issue , we must get informed and able to pinpoint the issue as quickly as possible to ensure no impact to our business.

Thus , this is my suggestion for the monitoring tools which covered for infrastructure level and also application level

## Infrastructure Monitoring Tools

  - [New Relic](https://newrelic.com/) - Infrastructure : Agent installed in our server which collecting server matric such as CPU Usage , memory usage , disk usage , network usage , disk IOPS usage , processes usage and other. Furthermore , we can set policy alert notification to triggered if something happened to our server, e.g : Host not responding , high load more than 10 min , disk usage reach 80% , and other . New relic also has agent that work with Docker container.

  - [Pager Duty](https://www.pagerduty.com/) - Incident management that helps to orchestrate the ideal response to the related party as relying on the email alert is not sufficient. People tend not looking into their email after office hour. Thus , Pager Duty help to notify any incident via all method that we need, e.g : Phone Call , sms , push notifation.

## Application Monitoring Tools

  - [New Relic](https://newrelic.com/) - APM (Application Monitoring : It is a complete view of our application performance , dependencies and bottleneck . Thus , we can ensure our application work very well based average page load time , throughput , Apdex score, response time, error rate , CPU usage and memory usage.

  - [Runscope](https://www.runscope.com/) - It is an API monitoring to ensure all our endpoint is up and working fine. It can also alert us if there any unusual traffic / high load API call toward certain endpoint. We can keep track the performance measurement more details.

   
   
