EAPI=8

DESCRIPTION="Collection of computer programs for CD and DVD authoring that work on Unix-like systems"
HOMEPAGE="https://packages.ubuntu.com/source/noble/cdrkit"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-arch/bzip2
	sys-libs/zlib
	dev-build/cmake
	sys-libs/libcap
	sys-apps/file
"

RDEPEND="${DEPEND}"

BDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${PN}-genisoimage.patch"
