EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/00oskkon/gambling.git"

DESCRIPTION="Number guessing game written in bash using zenity"
HOMEPAGE="https://github.com/00oskkon/gambling"

LICENSE="GPL-3"
SLOT="0"

DEPEND="gnome-extra/zenity"
RDEPEND="${DEPEND}"

src_install() {
	dodir /opt/gambling/
	insinto /opt/gambling
	doins -r ${S}/* || die "Install failed!"
	fperms +x /opt/${PN}/${PN}.sh

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop" || die "Install failed!"
}
