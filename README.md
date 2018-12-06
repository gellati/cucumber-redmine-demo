# Cucumber demo on redmine

## Setup

Initial requirements for this to work are Docker and Selenium webdriver installed on the computer. The project dependencies can be installed with [Bundler](https://bundler.io/). The dependencies are listed in the `Gemfile` and can be installed with

    bundler install

The file `docker-compose.yml` contains a Dockerized container for Redmine. The dockerfile builds up a small microservice architecture consisting of two services, Redmine and a MariaDB database. Build and start the containers with

    docker-compose up

Once the containers are up and running, the Redmine service can be tested with Robot Framework.

Shut down the containers with

    docker-compose down

The `-v` option can be added to remove the volumes after shutdown.

For security reasons, the permissions of the MariaDB container volumes need to be changed before the container can be used. This is done with an [additional container than only does the changing of permissions and then exits](https://github.com/bitnami/bitnami-docker-mariadb/issues/136#issuecomment-354644226). Because [SELinux might not allow the container to start](https://github.com/tomav/docker-mailserver/issues/753), the [z tag](https://docs.docker.com/storage/bind-mounts/#configure-mount-consistency-for-macos) has been added to the volumes.
