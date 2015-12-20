#!/bin/bash
# Executing supervisord and mysql_user
# Author : Kaushal Kishore <kaushal.rahuljaiswal@gmail.com>

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    mysql_install_db > /dev/null 2>&1
    /mysql_user.sh
fi

if [[ ! "$(ls -A $DIR)" ]]; then
	curl -sS https://getcomposer.org/installer | php
	php composer.phar config -g github-oauth.github.com d43ff619641df064390404ee419c921d5206d2a4
	php composer.phar create-project -sdev --repository-url="http://packages.zendframework.com" zendframework/skeleton-application /var/www/html/
fi

exec supervisord -n

