EAPI=8

inherit xdg-utils git-r3

EGIT_REPO_URI="https://gitlab.com/kalilinux/packages/kali-themes.git"

DESCRIPTION="Themes for GTK, grub, and plymouth included with Kali Linux"
HOMEPAGE="https://gitlab.com/kalilinux/packages/kali-themes"

LICENSE="GPL-3"
SLOT="0"
IUSE="+themes icons grub plymouth"

S=${WORKDIR}

RESTRICT="binchecks strip"

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
		plymouth-set-default-theme -R kali || die "Setting plymouth theme failed!"
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
}