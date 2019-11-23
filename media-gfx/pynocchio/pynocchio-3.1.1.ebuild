# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1 eutils gnome2-utils xdg

DESCRIPTION="Qt-based image viewer specialized in manga/comic reading"
HOMEPAGE="https://mstuttgart.github.io/pynocchio"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mstuttgart/pynocchio"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mstuttgart/pynocchio/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/rarfile[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-qt/linguist:5
	dev-qt/linguist-tools:5
	dev-python/PyQt5[gui,multimedia,sql,${PYTHON_USEDEP}]
	app-arch/unrar
	dev-qt/qtsql:5[sqlite]
"
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	mv ./${PN}-client.py ./scripts/${PN}
	sed -i "s#pynocchio-client.py#scripts/pynocchio#" setup.py
	default
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
