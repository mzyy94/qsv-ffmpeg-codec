#!/bin/sh

SRC_DIR="src"
FFMPEG_DIR="FFmpeg-2.2"
PATCH_FILE="ffmpeg-2.2.12.patch"

function info() {
    echo -e "\033[1m$@\033[0;39m"
}

function error() {
    echo -e "\033[1;31m$@\033[0;39m"
}

function success() {
    echo -e "\033[1;32m$@\033[0;39m"
}

function run() {
    info "> $@"
    eval $@
    if [ $? -ne 0 ]; then
        error "Error: failed to run sript. Quitting."
        exit 1
    else
        info "done."
    fi
}

info 'Getting FFmpeg 2.2 source code...'
run git submodule init
run git submodule update

info 'Applying the patch...'
( patch -N -p1 --dry-run -s -d ${FFMPEG_DIR} < ${PATCH_FILE} ) &&
run patch -N -p1 -d ${FFMPEG_DIR} \< ${PATCH_FILE} || info 'Already patched.'

info 'Copying source codes...'
run cp ${SRC_DIR}/* ${FFMPEG_DIR}/libavcodec/

info 'Changing current directory...'
run cd ${FFMPEG_DIR}

info 'Configuring FFmpeg...'
run ./configure --extra-libs=\"-lsupc++ -lstdc++ -ldl -lva -lva-drm\" --extra-ldflags=\"-L/opt/intel/mediasdk/lib64\" --extra-cflags=\"-I/opt/intel/mediasdk/include\" --prefix=\"/opt/intel/mediasdk\"

info 'Checking QSV option in config.h...'
(grep -i qsv config.h | grep 1 > /dev/null) &&
    success "Build setup is done. Type \`make\` in ${FFMPEG_DIR} directory." ||
    error "EROOR: QSV encoding option is disabled. Please check the Intel Media SDK installation status.\nThen, please re-run this $0 script."

