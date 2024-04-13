EAPI=8

DESCRIPTION="Launcher for Diablo 2, Median XL and D2 Stats"
HOMEPAGE="https://github.com/murkl/d2launcher"
SRC_URI="https://github.com/murkl/d2launcher/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"

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

PATCHES=(
        "${FILESDIR}"/${PN}-zenity.patch
)

src_install() {
        dodir /opt/d2launcher/
	insinto /opt/d2launcher
        doins -r ${S}/* || die "Install failed!"
	fperms +x "/opt/${PN}/${PN}"

        insinto /usr/share/applications
        doins "${FILESDIR}/${PN}.desktop" || die "Install failed!"
}