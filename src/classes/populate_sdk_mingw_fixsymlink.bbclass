
inherit populate_sdk

##
# Scan through all files and replace symlinks as they cant exist on windows
##
replace_sysroot_symlink() {
        # Where should we replace to
        SYMLINK_SYSROOT=$1

        # Where should we search
        SEARCH_FOLDER=$2

        # Find all symlinks
        for SOURCE in `find ${SEARCH_FOLDER} -type l`
        do
                TARGET=`readlink -m "${SOURCE}"`
                #check whether TARGET is inside the sysroot when not prepend the sysroot
                TARGET=`echo ${TARGET} | grep "^${SYMLINK_SYSROOT}" || echo ${SYMLINK_SYSROOT}${TARGET}`
                rm "${SOURCE}"
                if [ -f "${TARGET}" ]; then
                        cp "${TARGET}" "${SOURCE}"
                elif [ -e "${TARGET}" ]; then
                        touch "${SOURCE}"
                fi
        done
}

# Replace symlinks and create zip
fakeroot tar_sdk_sdkmingw32() {
        # Replace symlinks
        replace_sysroot_symlink ${SDK_OUTPUT}${SDKTARGETSYSROOT} ${SDK_OUTPUT}${SDKTARGETSYSROOT}
        replace_sysroot_symlink ${SDK_OUTPUT}${SDKPATHNATIVE} ${SDK_OUTPUT}${SDKPATHNATIVE}
        
        # Ensure sdk dir exists and enter
        mkdir -p ${SDK_DEPLOY}
        cd ${SDK_OUTPUT}/${SDKPATH}

        # Remove prvious builds of sdk
        if [ -e ${SDK_DEPLOY}/${TOOLCHAIN_OUTPUTNAME}.tar.xz ]; then
                rm ${SDK_DEPLOY}/${TOOLCHAIN_OUTPUTNAME}.tar.xz
        fi

        # Package it up the sdk
        tar ${SDKTAROPTS} -cf - . | pixz > ${SDK_DEPLOY}/${TOOLCHAIN_OUTPUTNAME}.tar.xz
}
