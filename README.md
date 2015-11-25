# Docker Drupal8 Dev
Docker files for running a drupal 8 dev environment.

## Setup
- Install and setup [Docker Toolbox](https://www.docker.com/docker-toolbox)
- Clone this repo: `git clone sepal/docker_d8_dev`
- Clone drupal 8 into the src sub folder: `git clone --branch 8.0.x http://git.drupal.org/project/drupal.git ./src`
- Set the mysql passwords in the docker-compose.yml file.
- Run `docker-composer up`

After this steps you should be able to install to your drupal8 site under [docker-machine ip]:8080/core/install.php.
You can get the docker machine ip using the command `docker-machine ip dev`
replacing dev with whatever you named your machine.
When you get to the database install step you should only have to enter the
mysql password, all other settings should be prefilled.

## Environment
The folders core, modules, profiles, themes and vendor are mounted as volumes,
which allows you to instantly make changes.
The sites folder is currently not mounted as volume, since drupal needs write
access for simpletest and other stuff, for which you currently can not configure
the folder.
Therefore you also can't change the files of the root folder instantly. 
