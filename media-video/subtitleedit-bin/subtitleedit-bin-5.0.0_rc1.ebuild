EAPI=8

inherit desktop xdg

MY_PN="${PN/-bin/}"
MY_PV="5.0.0-rc1"

DESCRIPTION="An advanced subtitle editor and converter"
HOMEPAGE="https://www.nikse.dk/SubtitleEdit"
SRC_URI="https://github.com/SubtitleEdit/subtitleedit/releases/download/v${MY_PV}/SubtitleEdit-Linux-x64.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+mpv -vlc -tesseract"

S=${WORKDIR}

RESTRICT="strip"

RDEPEND="
        media-video/ffmpeg
        mpv? ( media-video/mpv )
        vlc? ( media-video/vlc )
        tesseract? ( app-text/tesseract )
"

DESTDIR="/opt/${PN}"

src_install() {
        doicon -s 256 "${FILESDIR}/${MY_PN}.png"

        domenu "${FILESDIR}/${MY_PN}.desktop"

        exeinto "${DESTDIR}"

        doexe SubtitleEdit libHarfBuzzSharp.so libonigwrap.so libSkiaSharp.so

        dosym -r "${DESTDIR}/SubtitleEdit" "/usr/bin/${MY_PN}"
}

pkg_postinst() {
        xdg_icon_cache_update
}

pkg_postrm() {
        xdg_icon_cache_update
}