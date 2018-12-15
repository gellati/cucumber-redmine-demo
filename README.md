# Cucumber demo on redmine


This project uses Cucumber and Capybara to test the workings of a project management tool.

## Setup

Initial requirements for this to work are [Docker](https://www.docker.com/), [Ruby](https://www.ruby-lang.org/en/) and [Bundler](https://bundler.io/) installed on the computer. The project dependencies can be installed with [Bundler](https://bundler.io/). The dependencies are listed in the `Gemfile` and can be installed with

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


## Debugging tips

If you want to print out the (html contents of the page)[https://www.stefanwille.com/2010/12/printing-the-page-content-in-capybara/], you can write this in the step definition

    puts page.body

You can also open a web browser with the content of the page with

    save_and_open_page

## Resources

[Capybara tutorial](https://www.sitepoint.com/basics-capybara-improving-tests/)

[Capybara at Github](https://github.com/teamcapybara/capybara)

[Capybara documentation](https://www.rubydoc.info/github/jnicklas/capybara)

[Capybara cheatsheet](https://devhints.io/capybara)

[Another Capybara cheatsheet](https://kapeli.com/cheat_sheets/Capybara.docset/Contents/Resources/Documents/index)

[Capybara cheatsheet 3](https://gist.github.com/zhengjia/428105)

[Capybara examples](https://github.com/sferik/rails_admin/wiki/Rspec-with-capybara-examples)

## Todos
- how to set preconditions needed for test?
- headless testing
