EAPI=8

inherit xdg-utils

DESCRIPTION="GTK theme included with Kali Linux"
HOMEPAGE="https://gitlab.com/kalilinux/packages/kali-themes"
SRC_URI="https://gitlab.com/kalilinux/packages/${PN}/-/archive/kali/${PV}/${PN}-kali-master.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+themes icons grub plymouth"

S=${WORKDIR}

RESTRICT="binchecks strip"

DEPEND="
	grub? ( sys-boot/grub )
	plymouth? ( sys-boot/plymouth )
"

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	true
}

src_install() {
	if use themes; then
		dodir /usr/share/themes/
		insinto /usr/share/themes
		doins -r ${S}/*/share/themes/* || die "Install failed!"
	fi

	if use icons; then
		dodir /usr/share/icons/
		insinto /usr/share/icons
		doins -r ${S}/*/share/icons/* || die "Install failed!"
	fi

	if use grub; then
		dodir /boot/grub/themes/
		insinto /boot/grub/themes
		doins -r ${S}/*/share/grub/themes/* || die "Install failed!"
	fi

	if use plymouth; then
		dodir /usr/share/plymouth/themes/
		insinto /usr/share/plymouth/themes
		doins -r ${S}/*/share/plymouth/themes/* || die "Install failed!"

		dodir /etc/plymouth/
		insinto /etc/plymouth
		doins ${S}/*/etc/plymouth/plymouthd.conf || die "Install failed!"
	fi
}

pkg_postinst() {
	if use icons; then
		xdg_icon_cache_update
	fi

	if use grub; then
		ewarn "You must set GRUB_THEME in /etc/default/grub"
		ewarn "to /boot/grub/themes/kali/theme.txt"
		ewarn " "
		ewarn "Then update grub configuration using"
		ewarn "grub-mkconfig -o /boot/grub/grub.cfg"
	fi

	if use plymouth; then
		plymouth-set-default-theme -R kali
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
}
