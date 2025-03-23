EAPI=8

inherit qmake-utils

MY_P="4_0RC3"

DESCRIPTION="Free Pascal Qt6 bindings library updated by lazarus IDE."
HOMEPAGE="https://gitlab.com/freepascal.org/lazarus/lazarus/-/tree/main/lcl/interfaces/qt6/cbindings"
SRC_URI="https://gitlab.com/freepascal.org/lazarus/lazarus/-/archive/lazarus_${MY_P}/lazarus-lazarus_${MY_P}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="LGPL-3"
SLOT="0/2.2"

DEPEND="
	dev-qt/qtbase:6=[network,gui,widgets]
"

S="${WORKDIR}/lazarus-lazarus_${MY_P}"

src_configure() {
	eqmake6 lcl/interfaces/qt6/cbindings/Qt6Pas.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
