EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/helpmeplsfortheloveofgod/hentaifetch.git"

DESCRIPTION="neofetch but with hentai"
HOMEPAGE="https://github.com/helpmeplsfortheloveofgod/hentaifetch"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	net-misc/curl
	media-gfx/jp2a
	app-misc/neofetch
	media-gfx/imagemagick
"

RDEPEND="${DEPEND}"

src_compile() {
	return
}

src_install() {
	dodir /usr/bin
	insinto /usr/bin
	insopts -m755
	doins ${S}/${PN} || die "Install failed!"
}
