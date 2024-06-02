EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/andeen171/hentaifetch.git"

DESCRIPTION="neofetch but with hentai"
HOMEPAGE="https://github.com/andeen171/hentaifetch"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	net-misc/curl
	app-misc/neofetch
	media-gfx/jp2a
"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-jp2a.patch"
)

src_install() {
	dobin "${S}/${PN}" || die "Install failed!"
}
