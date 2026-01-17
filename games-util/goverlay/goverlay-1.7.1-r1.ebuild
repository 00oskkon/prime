EAPI=8

DESCRIPTION="A GUI to help manage Vulkan/OpenGL overlays"
HOMEPAGE="https://github.com/benjamimgois/goverlay"
SRC_URI="https://github.com/benjamimgois/goverlay/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	games-util/mangohud
	x11-apps/mesa-progs
	dev-util/vulkan-tools[cube]
	media-gfx/vkBasalt
	dev-libs/libqt6pas
	app-arch/p7zip
	net-misc/wget
"

RDEPEND="${DEPEND}"

BDEPEND="
	>=dev-lang/lazarus-3.2:=
"

PATCHES=(
		"${FILESDIR}"/${PN}-fhs.patch
	)

RESTRICT="strip"

src_compile() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]]; then
		make LAZBUILDOPTS=--lazarusdir=/usr/share/lazarus || die "make failed"
	fi
}
