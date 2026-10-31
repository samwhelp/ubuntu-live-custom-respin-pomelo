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

function is_exist_deb_by_dir () {

	local dir_path="${1}"
	ls "${dir_path}"/*.deb

}

function mod_desktop_pomelo_install () {

	##
	## ## https://pomelo.fedora.tw/download/pomelo-0.34-ubuntu26.04-amd64.tar.gz
	##

	local dist_dir_path="/opt/pomelo/dist"
	local port_dir_path="/opt/pomelo/port"
	local tmp_dir_path="/opt/pomelo/tmp"

	local pkg_archive_version="0.34"
	local pkg_archive_name="pomelo-${pkg_archive_version}-ubuntu26.04-amd64.tar.gz"
	local pkg_archive_url="https://pomelo.fedora.tw/download/${pkg_archive_name}"
	local pkg_archive_file_path="${tmp_dir_path}/${pkg_archive_name}"

	local pkg_extract_dir_name="pomelo-${pkg_archive_version}-ubuntu26.04"
	local pkg_extract_dir_path="${tmp_dir_path}/${pkg_extract_dir_name}"




	##
	## ## Preare folder of all debs
	##

	echo
	echo "rm -f ${pkg_archive_file_path}"
	echo
	rm -f "${pkg_archive_file_path}"


	echo
	echo "rm -rf ${pkg_extract_dir_path}"
	echo
	rm -rf "${pkg_extract_dir_path}"


	echo
	echo "mkdir -p ${tmp_dir_path}"
	echo
	mkdir -p "${tmp_dir_path}"


	echo
	echo "rm -rf ${dist_dir_path}"
	echo
	rm -rf "${dist_dir_path}"

	echo
	echo "mkdir -p ${dist_dir_path}"
	echo
	mkdir -p "${dist_dir_path}"


	##
	## ## Preare all debs
	##

	if [[ -d "${port_dir_path}" && $(is_exist_deb_by_dir "${port_dir_path}") ]]; then

		##
		## ## Copy debs to dist_dir_path from port_dir_path
		##

		echo
		echo 'cp -f ${port_dir_path}/*.deb ${dist_dir_path}/'
		echo
		cp -f "${port_dir_path}"/*.deb "${dist_dir_path}"/

	else

		##
		## ## Download debs archive
		##

		echo
		echo "wget -c ${pkg_archive_url} -O ${pkg_archive_file_path}"
		echo
		wget -c "${pkg_archive_url}" -O "${pkg_archive_file_path}"


		##
		## ## Extract debs archive
		##

		echo
		echo "tar xf ${pkg_archive_file_path}" -C "${tmp_dir_path}"
		echo
		tar xf "${pkg_archive_file_path}" -C "${tmp_dir_path}"


		##
		## ## Copy debs to dist_dir_path from pkg_extract_dir_path
		##

		echo
		echo 'cp -f ${pkg_extract_dir_path}/*.deb ${dist_dir_path}/'
		echo
		cp -f "${pkg_extract_dir_path}"/*.deb "${dist_dir_path}"/


	fi




	##
	## ## Install all debs
	##

	pushd "${dist_dir_path}" > /dev/null

		##
		## ## Install
		##

		echo
		echo "##"
		echo "## ## Install all debs about pomelo"
		echo "##"
		echo

		apt install ./*.deb || true

	popd




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
