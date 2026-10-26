#!/usr/bin/env bash


################################################################################
## Environment
################################################################################

set -e						# exit on error
set -o pipefail				# exit on pipeline error
set -u						# treat unset variable as error


################################################################################
## Base Path
################################################################################

BASE_DIR_PATH="$(dirname "$(realpath "${0}")")"


################################################################################
## Init
################################################################################



################################################################################
## Option
################################################################################




################################################################################
## Util
################################################################################




################################################################################
## Module
################################################################################

function mod_software_properties_common_package_install () {

	echo 'apt-get install -y software-properties-common'
	apt-get install -y software-properties-common

}

function mod_firefox_ppa_repository_add () {

	##
	## https://launchpad.net/~mozillateam/+archive/ubuntu/ppa
	##

	##
	## ## sample / source.list
	##
	## ```
	## deb https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu YOUR_UBUNTU_VERSION_HERE main
	## deb-src https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu YOUR_UBUNTU_VERSION_HERE main
	## ```
	##

	echo 'add-apt-repository -y ppa:mozillateam/ppa'
	add-apt-repository -y ppa:mozillateam/ppa

}

function mod_firefox_apt_preferences_config () {

cat << __EOF__ | tee /etc/apt/preferences.d/mozilla-firefox.pref
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap*
Pin-Priority: -1
__EOF__

}

function mod_firefox_package_install () {

	echo 'apt-get update'
	apt-get update

	echo 'apt-get install -y firefox firefox-locale-en firefox-locale-zh-hant firefox-locale-zh-hans firefox-locale-ja firefox-locale-ko'
	apt-get install -y firefox firefox-locale-en firefox-locale-zh-hant firefox-locale-zh-hans firefox-locale-ja firefox-locale-ko

}


################################################################################
## Model
################################################################################

function model_do_tool_web_browser_firefox_install () {

	mod_software_properties_common_package_install

	mod_firefox_ppa_repository_add

	mod_firefox_apt_preferences_config

	mod_firefox_package_install

}


################################################################################
## Portal
################################################################################

function portal_do_tool_web_browser_firefox_install () {

	model_do_tool_web_browser_firefox_install

}


################################################################################
## Main
################################################################################

echo "################################################################################"
echo "## [Sub] run: ${0} "
echo "################################################################################"

echo "==== args:" ${@} "===="

function __main__ () {

	portal_do_tool_web_browser_firefox_install "${@}"

}

__main__ "${@}"


################################################################################
## Test
################################################################################

function __test__ () {

	echo "__test__"

}

##__test__
