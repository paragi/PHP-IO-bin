#
#	Makefile template
#
#	This is an example Makefile that can be used by anyone who is building
#	his or her own PHP extensions using the PHP-CPP library.
#
#	In the top part of this file we have included variables that can be
#	altered to fit your configuration, near the bottom the instructions and
#	dependencies for the compiler are defined. The deeper you get into this
#	file, the less likely it is that you will have to change anything in it.
#

#
#	Name of your extension
#
#	This is the name of your extension. Based on this extension name, the
#	name of the library file (name.so) and the name of the config file (name.ini)
#	are automatically generated
#

NAME				=	io

#
#   Php-config utility
#
#   PHP comes with a standard utility program called 'php-config'. This program
#   can be used to find out in which directories PHP is installed. Inside this
#   makefile this utility program is used to find include directories, shared
#   libraries and the path to the binary file. If your php-config is not
#   installed in the default directory, you can change that here.
#

PHP_CONFIG			=	php-config
UNAME 				:= 	$(shell uname)

#
#   Installation directory
#
#   When you install the PHP-CPP library, it will place a number of C++ *.h
#   header files in your system include directory, and a libphpcpp.so shared
#   library file in your system libraries directory. Most users set this to
#   the regular /usr/include and /usr/lib directories, or /usr/local/include
#   and /usr/local/lib. You can of course change it to whatever suits you best
#

# Since OSX 10.10 Yosemite, /usr/include gives problem
# So, let's switch to /usr/local as default instead.
ifeq ($(UNAME), Darwin)
  INSTALL_PREFIX		=	/usr/local
else
  INSTALL_PREFIX		=	/usr
endif

INSTALL_HEADERS			=	${INSTALL_PREFIX}/include
INSTALL_LIB			=	${INSTALL_PREFIX}/lib


#
#   SONAME and version
#
#   When ABI changes, soname and minor version of the library should be raised.
#   Otherwise only release verions changes. (version is MAJOR.MINOR.RELEASE)
#

SONAME					=	2.0
VERSION					=	2.0.0


#
#   Name of the target library name and config-generator
#
#   The PHP-CPP library will be installed on your system as libphpcpp.so.
#   This is a brilliant name. If you want to use a different name for it,
#   you can change that here.
#

PHP_SHARED_LIBRARY		=	libphpcpp.so.$(VERSION)
PHP_STATIC_LIBRARY		=	libphpcpp.a.$(VERSION)


#
#	Php.ini directories
#
#	In the past, PHP used a single php.ini configuration file. Today, most
#	PHP installations use a conf.d directory that holds a set of config files,
#	one for each extension. Use this variable to specify this directory.
#

#INI_DIR				=	/etc/php/7.1/cli/conf.d
INI_DIR     =   /etc/php/7.0/mods-available/

#
#	The extension dirs
#
#	This is normally a directory like /usr/lib/php5/20121221 (based on the
#	PHP version that you use. We make use of the command line 'php-config'
#	instruction to find out what the extension directory is, you can override
#	this with a different fixed directory
#

EXTENSION_DIR		=	$(shell php-config --extension-dir)

#
#	Command to remove files, copy files and create directories.
#
#	I've never encountered a *nix environment in which these commands do not work.
#	So you can probably leave this as it is
#

RM						=	rm -fr
CP						=	cp -f
LN						=	ln -f -s
MKDIR					=	mkdir -p

#
#	The name of the extension and the name of the .ini file
#
#	These two variables are based on the name of the extension. We simply add
#	a certain extension to them (.so or .ini)
#

EXTENSION 	=	${NAME}.so
INI 				=	${NAME}.ini


install:
						${MKDIR} ${INSTALL_LIB}
	          if [ -e ${PHP_SHARED_LIBRARY} ]; then \
		          ${CP} ${PHP_SHARED_LIBRARY} ${INSTALL_LIB}/; \
		          ${LN} ${INSTALL_LIB}/${PHP_SHARED_LIBRARY} ${INSTALL_LIB}/libphpcpp.so.$(SONAME); \
		          ${LN} ${INSTALL_LIB}/${PHP_SHARED_LIBRARY} ${INSTALL_LIB}/libphpcpp.so; \
	          fi
	          if [ -e ${PHP_STATIC_LIBRARY} ]; then ${CP} ${PHP_STATIC_LIBRARY} ${INSTALL_LIB}/; \
		          ${LN} ${INSTALL_LIB}/${PHP_STATIC_LIBRARY} ${INSTALL_LIB}/libphpcpp.a; \
	          fi
	          if `which ldconfig`; then \
		          ldconfig; \
	          fi

						${CP} ${EXTENSION} ${EXTENSION_DIR}
						${CP} ${INI} ${INI_DIR}

remove:
						${RM} ${EXTENSION_DIR}/${EXTENSION} 
						${RM} ${INI_DIR}/${INI}
						
	          if [ -e ${PHP_SHARED_LIBRARY} ]; then \
		          ${RM} ${INSTALL_LIB}/${PHP_SHARED_LIBRARY}
	          fi
	          if [ -e ${PHP_STATIC_LIBRARY} ]; then 
	            ${RM} ${INSTALL_LIB}/${PHP_STATIC_LIBRARY} 
	          fi

