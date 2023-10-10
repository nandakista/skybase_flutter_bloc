source trap_ctrlc.sh

# build_aab
#   ENV             : staging|production
#   MODE            : [obfuscate]
declare ENV=$1
declare MODE=$2

declare PUB_VERSION=$(sed -n 's/version: //p' pubspec.yaml)

declare BUILD_NAME=$(echo "$PUB_VERSION" | sed -n 's/\+.*//p')

declare BUILD_NUMBER=$(echo "$PUB_VERSION" | sed -n 's/[0-9a-zA-Z.-]*+//p')

sh build_aab.sh $ENV $BUILD_NAME $BUILD_NUMBER $MODE
