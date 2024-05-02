#!/bin/bash
# Set the Flutter project directory (change this to your project directory)
PROJECT_DIR="../"
ENV_DIR="../_env/"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# Check if an environment file argument is provided
if [ -n "$1" ]; then
  # Source the specified environment file
  ENV_SOURCE="$ENV_DIR$1.env"
  echo -e "LOAD ENV: $GREEN $ENV_SOURCE $NC"
  source "$ENV_SOURCE"
else
  echo -e "$RED Usage: $0 <env_file> $NC"
  exit 1
fi

#check build platform:c
if [ -n "$2" ]; then
  echo -e "PLATFORM EXPORT: $GREEN $2 $NC"
  PLATFORM="$2"
else
  echo -e "$RED Usage: $0 <env_file> $NC"
  exit 1
fi

#check build mode
if [ -n "$3" ]; then
  BUILD_MODE="$3"
else
  BUILD_MODE=debug
fi
echo -e "BUILD MODE: $GREEN $BUILD_MODE $NC"

# Change to the project directory
cd "$PROJECT_DIR"


if [ -n "$APP_SUFFIX" ]; then
  APP_SUFFIX_DEF="--dart-define=\"APP_SUFFIX=$APP_SUFFIX\""
else
  APP_SUFFIX_DEF=""
fi

if [ "$ENV_TYPE" == "production" ]; then
  echo -e "$GREEN ------[ PRODUCTION BUILD: $BUILD_MODE ]------ $NC"
else
  APP_NAME="[$ENV_TYPE]$APP_NAME"
fi

# Run the Flutter command
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter clean
fvm flutter pub get
if [ "$BUILD_MODE" == "release" ]; then
  fvm flutter build $PLATFORM --release --no-tree-shake-icons \
    --dart-define="APP_NAME=$APP_NAME" \
    $APP_SUFFIX_DEF \
    --dart-define="APP_VERSION=$APP_VERSION" \
    --dart-define="APP_VERSION_CODE=$APP_VERSION_CODE" \
    --dart-define="APP_IS_DEBUG=$APP_IS_DEBUG" \
    --dart-define="APP_IS_ENABLE_SWITCH_ENV=$APP_IS_DEBUG" \
    --dart-define="APP_ENVIRONMENT_TYPE=$ENV_TYPE" \
    --dart-define="APP_AOS_GOOGLE_SERVICE_KEY=$AOS_GOOGLE_SERVICE_KEY" \
    --dart-define="APP_IOS_GOOGLE_SERVICE_KEY=$IOS_GOOGLE_SERVICE_KEY" \
    --dart-define="APP_DEEP_LINK_KEY_LIVE=$APP_DEEP_LINK_KEY_LIVE" \
    --dart-define="APP_DEEP_LINK_KEY_TEST=$APP_DEEP_LINK_KEY_TEST" \
    --dart-define="APP_DEEP_LINK_DOMAIN=$APP_DEEP_LINK_DOMAIN" \
    --dart-define="APP_DEEP_LINK_ALTERNATIVE_DOMAIN=$APP_DEEP_LINK_ALTERNATIVE_DOMAIN"
else
  fvm flutter build $PLATFORM --debug --no-tree-shake-icons \
    --dart-define="APP_NAME=$APP_NAME" \
    --dart-define="$APP_SUFFIX_DEF" \
    --dart-define="APP_VERSION=$APP_VERSION" \
    --dart-define="APP_VERSION_CODE=$APP_VERSION_CODE" \
    --dart-define="APP_IS_DEBUG=$APP_IS_DEBUG" \
    --dart-define="APP_IS_ENABLE_SWITCH_ENV=$APP_IS_DEBUG" \
    --dart-define="APP_ENVIRONMENT_TYPE=$ENV_TYPE" \
    --dart-define="APP_AOS_GOOGLE_SERVICE_KEY=$AOS_GOOGLE_SERVICE_KEY" \
    --dart-define="APP_IOS_GOOGLE_SERVICE_KEY=$IOS_GOOGLE_SERVICE_KEY" \
    --dart-define="APP_DEEP_LINK_KEY_LIVE=$APP_DEEP_LINK_KEY_LIVE" \
    --dart-define="APP_DEEP_LINK_KEY_TEST=$APP_DEEP_LINK_KEY_TEST" \
    --dart-define="APP_DEEP_LINK_DOMAIN=$APP_DEEP_LINK_DOMAIN" \
    --dart-define="APP_DEEP_LINK_ALTERNATIVE_DOMAIN=$APP_DEEP_LINK_ALTERNATIVE_DOMAIN"
fi
./_buildScripts/_notify.sh "$APP_NAME $PLATFORM $ENV_TYPE - $APP_VERSION ($APP_VERSION_CODE)" "Completed Build $APP_NAME"
