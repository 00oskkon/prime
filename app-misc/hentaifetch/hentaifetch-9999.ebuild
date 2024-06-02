EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/StaringLongingly/hentaifetch.git"

DESCRIPTION="neofetch but with hentai"
HOMEPAGE="https://github.com/StaringLongingly/hentaifetch"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	net-misc/curl
	app-misc/neofetch
	media-gfx/chafa
"

RDEPEND="${DEPEND}"

src_install() {
	dobin "${S}/${PN}" || die "Install failed!"
}
