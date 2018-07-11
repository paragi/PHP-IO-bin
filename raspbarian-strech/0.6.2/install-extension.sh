#!/bin/sh
#
#  Ubuntu / Debian version
#
#  Install PHP extension.
#  By Simon Riget @ Paragi 2018 MIT.
#
#  usage: install_extension.sh <extension name>
#

if [ -z $1 ]
then
    echo "Usages: $0 <extension name>"
    exit 1;
fi

NAME=$1
EXTENSION=$NAME.so
INI=$NAME.ini
SONAME=.2.1
VERSION=.2.1.0
PHP_SHARED_LIBRARY=libphpcpp.so
PHP_STATIC_LIBRARY=libphpcpp.a

# Find PHP extension dir
#
# This is normally a directory like /usr/lib/php5/20121221 (based on the
# PHP version that you use. We make use of the command line 'php-config'
# instruction to find out what the extension directory is, you can override
# this with a different fixed directory

if [ -z `which php-config` ]
then
    echo "Error: php-config not found"
    exit 1;
else
    EXTENSION_DIR=$(php-config --extension-dir)
fi


if [ -z `which ldconfig` ]
then
    echo "Warning: No ldconfig"
else
    sudo ldconfig;
fi

# Install extension .ini file
#
# Php.ini directories
#
# In the past, PHP used a single php.ini configuration file. Today, most
# PHP installations use a conf.d directory that holds a set of config files,
# one for each extension. Use this variable to specify this directory.

for PHP_VERSION in $(ls -1 /etc/php)
do
	INI_DIR="/etc/php/$PHP_VERSION/mods-available/"
    if [ -e "$INI_DIR" ]
    then
        echo "Installing $NAME.ini to $INI_DIR"
        sudo cp -f "$NAME.ini" $INI_DIR
    else
        echo "Warning: Unable to install .ini file to dir: $INI_DIR"
    fi
done

# Install extension library
echo Installing $EXTENSION_DIR/$EXTENSION
sudo cp -f $EXTENSION $EXTENSION_DIR


# check phpenmod
if [ -z `which phpenmod` ]
then
    echo "Warning: phpenmod missing. You must enable the extension mannually"
else
    echo "Enabeling $NAME module"
    phpenmod $NAME
fi
