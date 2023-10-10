source trap_ctrlc.sh

# build_ios
#   ENV             : staging|production
#   BUILD_NAME      : (example 1.0.0)
#   BUILD_NUMBER    : (example 1)
#   MODE            : [obfuscate]
declare ENV=$1
declare BUILD_NAME=$2
declare BUILD_NUMBER=$3
declare MODE=$4

declare APP_NAME="Skybase"

if [ "$BUILD_NUMBER" == "i" ]
then
    declare LAST_BUILD_NUMBER=`sed -n 's/FLUTTER_BUILD_NUMBER=//p' ios/Flutter/Generated.xcconfig`
    BUILD_NUMBER=$(( LAST_BUILD_NUMBER + 1 ))
fi

# validate mode
if [ ! "$MODE" == "obfuscate" ]
then
    MODE=
fi

# flutter build
echo "🟦 Starting Flutter build..."
echo "⬜️ Platform     : iOS"
echo "⬜️ Env          : $ENV"
echo "⬜️ Build name   : $BUILD_NAME"
echo "⬜️ Build number : $BUILD_NUMBER"
echo "⬜️ Mode         : $MODE"
if [ "$MODE" == "obfuscate" ]
then
    flutter build ios -t "lib/main_$ENV.dart" --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" --obfuscate --split-debug-info=.debug-info-ios --no-codesign
else
    flutter build ios -t "lib/main_$ENV.dart" --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" --no-codesign
fi

if [ ! $? == 0 ]
then
    echo "🟥 build failed"
    exit 1
fi

# sync build name and build number
sed -i '' 's|FLUTTER_BUILD_NAME=.*|FLUTTER_BUILD_NAME='"$BUILD_NAME"'|g' ios/Flutter/Generated.xcconfig
sed -i '' 's|FLUTTER_BUILD_NUMBER=.*|FLUTTER_BUILD_NUMBER='"$BUILD_NUMBER"'|g' ios/Flutter/Generated.xcconfig

declare BLDCODE="${APP_NAME}_${BUILD_NAME}_${BUILD_NUMBER}_$ENV"
declare ARCHIVE_PATH="~/Library/Developer/Xcode/Archives/${BLDCODE}.xcarchive"

# archiving
rm -rf "$ARCHIVE_PATH"
echo "🟦 Archiving...";
echo "⬜️ Archive path: $ARCHIVE_PATH";
echo "⬜️ Please wait...";
xcrun xcodebuild -configuration "Release" VERBOSE_SCRIPT_LOGGING=YES -workspace ios/Runner.xcworkspace -scheme "Runner" -sdk iphoneos FLUTTER_SUPPRESS_ANALYTICS=true COMPILER_INDEX_STORE_ENABLE=NO -archivePath "$ARCHIVE_PATH" archive  > .build_ios_archive.log

if [ ! $? == 0 ]
then
    echo "🟥 build failed"
    exit 1
fi

# open xcode
ARCHIVE_PATH=$(printf %q "$ARCHIVE_PATH")
eval open "$ARCHIVE_PATH"

echo "🟩 Build done"
