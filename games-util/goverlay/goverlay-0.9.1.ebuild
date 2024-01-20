EAPI=8

DESCRIPTION="A GUI to help manage Vulkan/OpenGL overlays"
HOMEPAGE="https://github.com/benjamimgois/goverlay"
SRC_URI="https://github.com/benjamimgois/goverlay/archive/refs/tags/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/libqt5pas
	games-util/mangohud
	media-libs/glu
	dev-util/vulkan-tools
"

RDEPEND="${DEPEND}"

BDEPEND="
	>=dev-lang/lazarus-2.2.4-r1
	dev-vcs/git
"



src_compile() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]]; then
		make LAZBUILDOPTS=--lazarusdir=/usr/share/lazarus || die "emake failed"
	fi
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi

	if ! declare -p DOCS >/dev/null 2>&1 ; then
		local d
		for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
				FAQ CREDITS CHANGELOG ; do
			[[ -s "${d}" ]] && dodoc "${d}"
		done
	elif [[ $(declare -p DOCS) == "declare -a"* ]] ; then
		dodoc "${DOCS[@]}"
	else
		dodoc ${DOCS}
	fi
}

src_test() {
	if nonfatal emake check -n &> /dev/null; then
		emake check
	elif nonfatal emake test -n &> /dev/null; then
		emake tests
	fi
}
