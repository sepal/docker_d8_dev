# Docker Drupal8 Dev
Docker files for running a drupal 8 dev environment.

## Setup
- Install and setup [Docker Toolbox](https://www.docker.com/docker-toolbox)
- Clone this repo: `git clone sepal/docker_d8_dev`
- Clone drupal 8 into the src sub folder: `git clone --branch 8.0.x http://git.drupal.org/project/drupal.git ./src`
- Set the mysql passwords in the docker-compose.yml file.
- Run `docker-composer up`

After this steps you should be able to navigate to your drupal8 site under [docker-machine ip]:8080/drupal.
