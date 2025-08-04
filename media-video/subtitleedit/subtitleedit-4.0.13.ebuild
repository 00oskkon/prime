EAPI=8

DESCRIPTION="An advanced subtitle editor and converter"
HOMEPAGE="https://www.nikse.dk/SubtitleEdit"
SRC_URI="https://github.com/SubtitleEdit/subtitleedit/releases/download/${PV}/SE${PV//./}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="mpv vlc tesseract ffmpeg"

S=${WORKDIR}

RDEPEND="
	dev-lang/mono
	mpv? ( media-video/mpv )
	vlc? ( media-video/vlc )
	tesseract? ( app-text/tesseract )
	ffmpeg? ( media-video/ffmpeg )
"

DEPEND="${RDEPEND}"

src_prepare() {
	rm -r ${S}/Tesseract302 || die "Prepare failed!"
	rm ${S}/Hunspell{x86,x64}.dll || die "Prepare failed!"

	default || die "Prepare failed!"
}

src_install() {
	dodir /opt/subtitleedit/
	insinto /opt/subtitleedit
	doins -r ${S}/* || die "Install failed!"

	dobin ${FILESDIR}/subtitleedit || die "Install failed!"

	dodir /usr/share/applications/
	insinto /usr/share/applications
	doins ${FILESDIR}/subtitleedit.desktop || die "Install failed!"

	dodir /usr/share/pixmaps/
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/subtitleedit.png || die "Install failed!"
}
