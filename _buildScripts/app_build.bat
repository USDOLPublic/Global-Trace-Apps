@echo off
rem Set the Flutter project directory (change this to your project directory)
set "PROJECT_DIR=..\"
set "ENV_DIR=..\_env\"

set "RED=[31m"
set "GREEN=[32m"
set "NC=[0m"

rem Check if an environment file argument is provided
if not "%~1"=="" (
  rem Source the specified environment file
  set "ENV_SOURCE=%ENV_DIR%%~1.env"
  echo LOAD ENV: %GREEN% %ENV_SOURCE% %NC%
  call "%ENV_SOURCE%"
) else (
  echo %RED% Usage: %0 ^<env_file^> %NC%
  exit /b 1
)

rem Check build platform
if not "%~2"=="" (
  set "PLATFORM=%~2"
  echo PLATFORM EXPORT: %GREEN% %PLATFORM% %NC%
) else (
  echo %RED% Usage: %0 ^<env_file^> %NC%
  exit /b 1
)

rem check build mode
if not "%~3"=="" (
  set "BUILD_MODE=%~3"
) else (
  set "BUILD_MODE=debug"
)
echo "BUILD MODE: %GREEN% %BUILD_MODE% %NC%"

rem Change to the project directory
cd /d "%PROJECT_DIR%"

if not "%APP_SUFFIX%"=="" (
  set APP_SUFFIX_DEF="APP_SUFFIX=%APP_SUFFIX%"
) else (
  set APP_SUFFIX_DEF="APP_"
)

if "%ENV_TYPE%"=="production"(
  echo -e "PRODUCTION BUILD: %GREEN% %BUILD_MODE% %NC%"
) else (
  set APP_NAME="[%ENV_TYPE%]%APP_NAME%"
)

rem Run the Flutter command
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter clean
if "%BUILD_MODE%"=="release" (
  fvm flutter build %PLATFORM% --release --no-tree-shake-icons ^
    --dart-define="APP_NAME=%APP_NAME%" ^
    --dart-define="%APP_SUFFIX_DEF%" ^
    --dart-define="APP_VERSION=%APP_VERSION%" ^
    --dart-define="APP_VERSION_CODE=%APP_VERSION_CODE%" ^
    --dart-define="APP_IS_DEBUG=%APP_IS_DEBUG%" ^
    --dart-define="APP_IS_ENABLE_SWITCH_ENV=%APP_IS_DEBUG%" ^
    --dart-define="APP_ENVIRONMENT_TYPE=%ENV_TYPE%" ^
    --dart-define="APP_AOS_GOOGLE_SERVICE_KEY=%AOS_GOOGLE_SERVICE_KEY%" ^
    --dart-define="APP_IOS_GOOGLE_SERVICE_KEY=%IOS_GOOGLE_SERVICE_KEY%"
)else(
  fvm flutter build %PLATFORM% --debug --no-tree-shake-icons ^
    --dart-define="APP_NAME=%APP_NAME%" ^
    --dart-define="%APP_SUFFIX_DEF%" ^
    --dart-define="APP_VERSION=%APP_VERSION%" ^
    --dart-define="APP_VERSION_CODE=%APP_VERSION_CODE%" ^
    --dart-define="APP_IS_DEBUG=%APP_IS_DEBUG%" ^
    --dart-define="APP_IS_ENABLE_SWITCH_ENV=%APP_IS_DEBUG%" ^
    --dart-define="APP_ENVIRONMENT_TYPE=%ENV_TYPE%" ^
    --dart-define="APP_AOS_GOOGLE_SERVICE_KEY=%AOS_GOOGLE_SERVICE_KEY%" ^
    --dart-define="APP_IOS_GOOGLE_SERVICE_KEY=%IOS_GOOGLE_SERVICE_KEY%"
)
