#!/bin/bash

set -e

#Ensure that we can upgrade insecure requests via the apache conf
ln -sfn /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load

if [ -d "$GITPOD_REPO_ROOT/joomla" ] || [ -d "$GITPOD_REPO_ROOT/standalone" ]; then
    apachectl restart
    exit 0
fi;

#load up user predefine variables
source $GITPOD_REPO_ROOT/.gitpod/config/config.sh

echo "* About to set up the gitpod area"

export PATH=/home/gitpod/.composer/vendor/bin/:$PATH

if "$standalone" = true; then
  mkdir -p  ${GITPOD_REPO_ROOT}/standalone;

  echo "* create custom composer.json"
  cp $GITPOD_REPO_ROOT/.gitpod/config/standalone-composer.json $GITPOD_REPO_ROOT/standalone/composer.json

  composer install --working-dir=$GITPOD_REPO_ROOT/standalone --ignore-platform-reqs

  echo "* Set the site to look for joomlatools-pages within the .gitpod folder"
  cp $GITPOD_REPO_ROOT/.gitpod/config/configuration-pages.php $GITPOD_REPO_ROOT/standalone/configuration-pages.php

  echo "* lets copy our base configuration"
  cp -R $GITPOD_REPO_ROOT/.gitpod/config/pages/ $GITPOD_REPO_ROOT/standalone/config/

  echo "* create our entry point"
  cp $GITPOD_REPO_ROOT/.gitpod/config/index-entrypoint.php $GITPOD_REPO_ROOT/standalone/index.php

exit 0
fi

joomla plugin:install joomlatools/console-joomlatools:dev-master

echo "* Create a new Joomla site"

release="--release=latest"
repostring=""

if [ -n "$joomla" ]; then
  release="--release=$joomla"
elif [ -n "$repo" ]; then
  release=""
  repostring="--repo=$repo"
fi;

joomla site:download ${APACHE_DOCROOT_IN_REPO} --www=$GITPOD_REPO_ROOT $release $repostring

joomla site:configure ${APACHE_DOCROOT_IN_REPO} --www=$GITPOD_REPO_ROOT --overwrite --mysql-login=root:

if [ -e "$GITPOD_REPO_ROOT/.gitpod/install.sql" ]; then
  custom_install="--sql-dumps=$GITPOD_REPO_ROOT/.gitpod/install.sql";
fi;

#getting rate limits for joomla/backports/less-php use a modified composer.json
cp $GITPOD_REPO_ROOT/.gitpod/config/composer.json $GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO}/composer.json

#wait for the database to ready
while ! mysqladmin ping --silent; do
    sleep 1
done

joomla database:install  ${APACHE_DOCROOT_IN_REPO} --www=$GITPOD_REPO_ROOT --drop --mysql-login=root: $custom_install

if [ -n "$composer" ]; then

  echo "* Installing user defined composer requirements"

  composer require $composer --working-dir=$GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO} --ignore-platform-reqs > /dev/null
fi

if [ -e "$GITPOD_REPO_ROOT/.gitpod/migrations/migrations.sql" ] && [ ! -d "$GITPOD_REPO_ROOT/joomla/web" ]; then
  mysql sites_joomla < $GITPOD_REPO_ROOT/.gitpod/migrations/migrations.sql
fi;

echo "* Set the site to look for joomlatools-pages within the .gitpod folder"
cp $GITPOD_REPO_ROOT/.gitpod/config/configuration-pages.php $GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO}/configuration-pages.php

apachectl start