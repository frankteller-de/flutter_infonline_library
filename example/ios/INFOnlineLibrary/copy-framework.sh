#
# This script copies the correct framework over to the build product (i.e. it copies the
# framework for the current platform [iOS, tvOS, watchOS]).
# 
# After this it strips the framework from all unneeded architectures. This is neccessary
# due to an issue where the archive process in Xcode does not automatically strip unneeded
# architectures from dynamic frameworks and thus submitting to the App Store will fail. (rdar://19209161)
#
# The last part of the script then codesigns the framework with the same identity as the
# host app, so that the framework can be submitted to the App Store.
#

echoerr() { (>&2 echo "$@"); }
cmd=`echo ${0##*/}`

SCRIPTPATH=$(dirname "$BASH_SOURCE")

FRAMEWORK_FILENAME="INFOnlineLibrary.framework"
FRAMEWORK_SRC_PATH="${SCRIPTPATH}/${PLATFORM_NAME}/${FRAMEWORK_FILENAME}/"

# Check if path to Lib is valid
if [ ! -d "${FRAMEWORK_SRC_PATH}" ]; then
    echoerr "$cmd Error: ${FRAMEWORK_FILENAME} not found at path ${FRAMEWORK_SRC_PATH}!"
    echoerr "Make sure to setup the INFOnlineLibrary according IntegrationGuide!"
    exit 1
fi

# Check if Info.plist exists
if [ ! -f "${FRAMEWORK_SRC_PATH}Info.plist" ]; then
    echoerr "$cmd Error: Info.plist not found at path ${FRAMEWORK_SRC_PATH}Info.plist!"
    exit 2
fi


FRAMEWORK_BINARY=$(/usr/libexec/PlistBuddy -c 'Print CFBundleExecutable' "${FRAMEWORK_SRC_PATH}Info.plist")

# Check if CFBundleExecutable Key is set
if [ -z "${FRAMEWORK_BINARY}" ]; then
    echoerr "$cmd Error: CFBundleExecutable Key not found in ${FRAMEWORK_SRC_PATH}Info.plist!"
    exit 3
fi

# Check if CFBundleExecutable file exists and is executable
if [ ! -f "${FRAMEWORK_SRC_PATH}${FRAMEWORK_BINARY}" ]; then
    echoerr "$cmd Error: Executable File '${FRAMEWORK_BINARY}' not found at path ${FRAMEWORK_SRC_PATH}!"
    exit 4
elif [ ! -x "${FRAMEWORK_SRC_PATH}${FRAMEWORK_BINARY}" ]; then
    echoerr "$cmd Error: Executable File not found! File '${FRAMEWORK_BINARY}' exists at path ${FRAMEWORK_SRC_PATH} but is not executable!"
    exit 5
fi



FRAMEWORK_DST_PATH="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/${FRAMEWORK_FILENAME}/"
FRAMEWORK_DST_BINARY="${FRAMEWORK_DST_PATH}${FRAMEWORK_BINARY}"

echo "Copying INFOnlineLibrary.framework into product..."
[ -d "${FRAMEWORK_DST_PATH}" ] || mkdir -p "${FRAMEWORK_DST_PATH}"
cp -R "${FRAMEWORK_SRC_PATH}" "${FRAMEWORK_DST_PATH}" || exit 6

echo "Stripping non-valid architectures in INFOnlineLibrary.framework..."
FRAMEWORK_ARCHS="$(lipo -info "${FRAMEWORK_DST_BINARY}" | rev | cut -d ':' -f1 | rev)"
for arch in $FRAMEWORK_ARCHS; do
    if ! [[ "${VALID_ARCHS}" == *"${arch}"* ]]; then
      lipo -remove "${arch}" -output "${FRAMEWORK_DST_BINARY}" "${FRAMEWORK_DST_BINARY}" || exit 7
    fi
done

if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
	echo "Codesigning INFOnlineLibrary.framework..."
    /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "${FRAMEWORK_DST_BINARY}" || exit 8
fi
