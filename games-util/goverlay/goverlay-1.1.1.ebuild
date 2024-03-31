EAPI=8

DESCRIPTION="A GUI to help manage Vulkan/OpenGL overlays"
HOMEPAGE="https://github.com/benjamimgois/goverlay"
SRC_URI="https://github.com/benjamimgois/goverlay/archive/refs/tags/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/libqt6pas
	games-util/mangohud
	media-libs/glu
	dev-util/vulkan-tools
"

RDEPEND="${DEPEND}"

BDEPEND="
	>=dev-lang/lazarus-3.2
	dev-vcs/git
"



src_compile() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]]; then
		make LAZBUILDOPTS=--lazarusdir=/usr/share/lazarus || die "make failed"
	fi
}
