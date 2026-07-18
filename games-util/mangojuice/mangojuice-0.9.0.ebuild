EAPI=8

inherit meson vala xdg

DESCRIPTION="A convenient alternative for setting up MangoHud"
HOMEPAGE="https://github.com/radiolamp/mangojuice"
SRC_URI="https://github.com/radiolamp/mangojuice/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="
	gui-libs/gtk:4
	>=gui-libs/libadwaita-1.2:1
	media-libs/fontconfig
	games-util/mangohud
"

BDEPEND="
	$(vala_depend)
"

PATCHES=(
	"${FILESDIR}"/${PN}-desktop.patch
)

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
