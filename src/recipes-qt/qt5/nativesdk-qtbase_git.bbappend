FILESEXTRAPATHS_prepend := "${THISDIR}/qtbase:"

SRC_URI += "\
    file://0001-Add-win32-g-oe-mkspec-that-uses-the-OE_-environment.patch \
    "

PACKAGECONFIG += "openssl"
PACKAGECONFIG_remove_mingw32 += "openssl"

PACKAGECONFIG[openssl] = "-openssl,-no-openssl,openssl,libssl"

fakeroot do_generate_qt_environment_file_mingw32() {
}
