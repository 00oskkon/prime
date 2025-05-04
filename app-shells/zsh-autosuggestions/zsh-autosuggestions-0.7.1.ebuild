EAPI=8

USE_RUBY="ruby31 ruby32"
RUBY_OPTIONAL="yes"

inherit readme.gentoo-r1

DESCRIPTION="Fish-like autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
SRC_URI="https://github.com/zsh-users/zsh-autosuggestions/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/all/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-shells/zsh-4.3.11"
BDEPEND="${RDEPEND}"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/${PN}.zsh
at the end of your ~/.zshrc"

src_install() {
	insinto "/usr/share/zsh/site-functions/"
	doins "${PN}.zsh"

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
