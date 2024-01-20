EAPI=8

DESCRIPTION="Launcher for Diablo 2, Median XL and D2 Stats"
HOMEPAGE="https://github.com/murkl/d2launcher"
SRC_URI="https://github.com/murkl/d2launcher/archive/refs/tags/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-emulation/wine-staging
	gnome-extra/zenity
	net-misc/curl
	app-arch/p7zip
	app-arch/unrar
	app-misc/jq
	x11-misc/wmctrl
	=sys-fs/fuse-2.9.9-r2
	app-arch/zip
	>=dev-util/xdelta-3.0.11-r1
"

RDEPEND="${DEPEND}"

BDEPEND=""

PATCHES=(
	"${FILESDIR}"/${PN}-zenity.patch
)

src_install() {
	dodir /opt/
	cp -R "${S}/" "${D}/opt" || die "Install failed!"
	fperms +x "/opt/${PN}-${PV}/d2launcher"

	insinto /usr/share/applications
	doins "${FILESDIR}/d2launcher.desktop"
}
