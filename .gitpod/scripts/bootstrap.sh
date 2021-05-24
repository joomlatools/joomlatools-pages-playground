#!/bin/bash

set -e

#Ensure that we can upgrade insecure requests via the apache conf
ln -sfn /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load

if [ -d "$GITPOD_REPO_ROOT/joomla" ]; then
    apachectl start
    exit 0
fi;

#load up user predefine variables
source $GITPOD_REPO_ROOT/.gitpod/config/config.sh

echo "* About to set up the gitpod area"

export PATH=/home/gitpod/.composer/vendor/bin/:$PATH

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

#wait for the database to ready
while ! mysqladmin ping --silent; do
    sleep 1
done

joomla database:install  ${APACHE_DOCROOT_IN_REPO} --www=$GITPOD_REPO_ROOT --drop --mysql-login=root: $custom_install

if [ -n "$composer" ]; then

  echo "* Installing user defined composer requirements"

  composer require $composer --working-dir=$GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO} --ignore-platform-reqs > /dev/null
fi

if [ -d "$GITPOD_REPO_ROOT/joomla/web" ]; then

  echo "* Platform detected, proceed to configure"

  cp "$GITPOD_REPO_ROOT/.gitpod/migrations/platform_migrations.php" "$GITPOD_REPO_ROOT/joomla/install/mysql/migrations/v1.1.0/20200521123445_platform_migrations.php"

  rm -Rf "$GITPOD_REPO_ROOT/joomla/install/mysql/migrations/v2.0.0/"

  cd "$GITPOD_REPO_ROOT/joomla/" && php vendor/bin/phinx migrate;

  sed -i 's/1/0/g' $GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO}/config/environments/development.php

  cp $GITPOD_REPO_ROOT/.gitpod/config/configuration-pages.php $GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO}/config/configuration-pages.php

  apachectl restart
fi;

if [ -e "$GITPOD_REPO_ROOT/.gitpod/migrations/migrations.sql" ] && [ ! -d "$GITPOD_REPO_ROOT/joomla/web" ]; then
  mysql sites_joomla < $GITPOD_REPO_ROOT/.gitpod/migrations/migrations.sql
fi;

echo "* Set the site to look for joomlatools-pages within the .gitpod folder"
cp $GITPOD_REPO_ROOT/.gitpod/config/configuration-pages.php $GITPOD_REPO_ROOT/${APACHE_DOCROOT_IN_REPO}/configuration-pages.php

apachectl start