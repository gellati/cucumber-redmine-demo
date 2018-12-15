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


## Run project

In order to run the tests, do

    bundle exec cucumber

in the root folder.

The user stories are marked with tags. To run only a specific user story, add the `--tag` switch and and the name of the user story tag you want to run. Eg.

    bundle exec cucumber --tags @RestorePasswordWithUnknownEmail


# Writing further tests

Cucumber can give an outline for new step definitions when new user stories are added. Write a scenario, which has no predefined step definitions (or has some steps that are already work in a desired way), and once the scenario is run, Cucumber will print out an outline that can be copied and pasted into the step definition file. The user then fills in the necessary content for the steps to be carried out.


## Todos
- how to set preconditions needed for test?
- use of variables in tests
