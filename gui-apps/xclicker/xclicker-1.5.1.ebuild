EAPI=8

inherit xdg-utils

DESCRIPTION="A blazing fast gui autoclicker for linux"
HOMEPAGE="https://xclicker.xyz/"
SRC_URI="https://github.com/robiot/xclicker/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gtk+
"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-build/meson
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	dev-util/pkgconf
"

src_compile() {
	emake release || die "emake failed"
}

src_install() {
	dobin ${S}/build/release/src/${PN} || die "Install failed!"

	dodir /usr/share/applications/
	insinto /usr/share/applications
	doins ${S}/assets/xclicker.desktop || die "Install failed!"

	dodir /usr/share/icons/hicolor/256x256/apps/
	insinto /usr/share/icons/hicolor/256x256/apps
	insopts -m644
	doins ${S}/assets/icon.png || die "Install failed!"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
