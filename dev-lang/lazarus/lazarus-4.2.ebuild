EAPI=8

inherit desktop

MY_P="4_2"

DESCRIPTION="Feature rich visual programming environment emulating Delphi"
HOMEPAGE="https://www.lazarus-ide.org/"
SRC_URI="https://gitlab.com/freepascal.org/lazarus/lazarus/-/archive/lazarus_${MY_P}/lazarus-lazarus_${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui extras"
REQUIRED_USE="extras? ( gui )"

# Pascal ignores CFLAGS and does its own stripping. Nothing else can be done about it.
QA_FLAGS_IGNORED="
/usr/share/lazarus/startlazarus \
/usr/share/lazarus/lazarus \
/usr/share/lazarus/tools/lazres \
/usr/share/lazarus/tools/lrstolfm \
/usr/share/lazarus/tools/updatepofiles \
/usr/share/lazarus/tools/svn2revisioninc \
/usr/share/lazarus/lazbuild \
/usr/share/lazarus/components/chmhelp/lhelp/lhelp"

QA_PRESTRIPPED=${QA_FLAGS_IGNORED}

DEPEND="
	>=dev-lang/fpc-3.2.2[source]
	>=sys-devel/binutils-2.19.1-r1:=
	gui? ( dev-libs/libqt6pas )
"

BDEPEND="net-misc/rsync"
RDEPEND="${DEPEND}"

RESTRICT="strip" #269221

S="${WORKDIR}/lazarus-lazarus_${MY_P}"

src_prepare() {
	default
	# Use default configuration (minus stripping) unless specifically requested otherwise
	if ! test ${PPC_CONFIG_PATH+set} ; then
		local FPCVER=$(fpc -iV)
		export PPC_CONFIG_PATH="${WORKDIR}"
		sed -e 's/^FPBIN=/#&/' /usr/lib/fpc/${FPCVER}/samplecfg |
			sh -s /usr/lib/fpc/${FPCVER} "${PPC_CONFIG_PATH}" || die
	fi
}

src_compile() {
	if ( use gui ) ; then
		export LCL_PLATFORM=qt6
		emake all -j1 || die "emake failed!"
	else
		emake lazbuild -j1 || die "emake failed!"
	fi
}

src_install() {
	diropts -m0755
	dodir /usr/share/lazarus
	# Using rsync to avoid unnecessary copies and cleaning...
	# Note: *.o and *.ppu are needed
	rsync -a \
		--exclude="CVS"     --exclude=".cvsignore" \
		--exclude="*.ppw"   --exclude="*.ppl" \
		--exclude="*.ow"    --exclude="*.a"\
		--exclude="*.rst"   --exclude=".#*" \
		--exclude="*.~*"    --exclude="*.bak" \
		--exclude="*.orig"  --exclude="*.rej" \
		--exclude=".xvpics" --exclude="*.compiled" \
		--exclude="killme*" --exclude=".gdb_hist*" \
		--exclude="debian"  --exclude="COPYING*" \
		--exclude="*.app" \
		"${S}/" "${ED}"/usr/share/lazarus \
		|| die "Unable to copy files!"

	if ( use gui ) ; then
		dosym ../share/lazarus/startlazarus /usr/bin/startlazarus
		dosym ../share/lazarus/startlazarus /usr/bin/lazarus
	fi
	dosym ../share/lazarus/lazbuild /usr/bin/lazbuild
	use extras && dosym ../share/lazarus/components/chmhelp/lhelp/lhelp /usr/bin/lhelp
	dosym ../lazarus/images/ide_icon48x48.png /usr/share/pixmaps/lazarus.png

	use gui && make_desktop_entry startlazarus "Lazarus IDE" "lazarus"
}
