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

function mod_desktop_pomelo_install () {

	##
	## ## https://pomelo.fedora.tw/download/pomelo-0.34-ubuntu26.04-amd64.tar.gz
	##

	local pkg_version="0.34"
	local pkg_name="pomelo-${pkg_version}-ubuntu26.04-amd64.tar.gz"
	local pkg_url="https://pomelo.fedora.tw/download/${pkg_name}"
	local tmp_dir_path="/opt/pomelo/build"
	local tmp_file_path="${tmp_dir_path}/${pkg_name}"

	local deb_dir_name="pomelo-${pkg_version}-ubuntu26.04"


	echo
	echo "rm -f ${tmp_file_path}"
	echo
	rm -f "${tmp_file_path}"


	echo
	echo "mkdir -p ${tmp_dir_path}"
	echo
	mkdir -p "${tmp_dir_path}"


	echo
	echo "wget -c ${pkg_url} -O ${tmp_file_path}"
	echo
	wget -c "${pkg_url}" -O "${tmp_file_path}"


	pushd "${tmp_dir_path}" > /dev/null


	##
	## ## Extract
	##

	echo
	echo "tar xf ${pkg_name}"
	echo
	tar xf "${pkg_name}"


		pushd "${deb_dir_name}" > /dev/null

			##
			## ## Install
			##

			apt install ./*.deb || true

		popd


	popd > /dev/null


	return 0

}


################################################################################
## Model
################################################################################

function model_do_desktop_pomelo_install () {

	mod_desktop_pomelo_install

}


################################################################################
## Portal
################################################################################

function portal_do_desktop_pomelo_install () {

	model_do_desktop_pomelo_install

}


################################################################################
## Main
################################################################################

echo "################################################################################"
echo "## [Sub] run: ${0} "
echo "################################################################################"

echo "==== args:" ${@} "===="

function __main__ () {

	portal_do_desktop_pomelo_install "${@}"

}

__main__ "${@}"


################################################################################
## Test
################################################################################

function __test__ () {

	echo "__test__"

}

##__test__
