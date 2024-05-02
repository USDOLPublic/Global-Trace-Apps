#!/bin/bash
# Set the Flutter project directory (change this to your project directory)
PROJECT_DIR="../"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# Check if the new bundle identifier is provided as an argument
if [ -n "$1" ]; then
  echo -e "SET Bundle ID to: $GREEN $1 $NC"
else
  echo -e "$RED Usage: $0 <env_file> $NC"
  exit 1
fi

if [ -n "$1" ]; then
  echo -e "SET App Name to: $GREEN $2 $NC"
else
  echo -e "$RED Usage: $0 <env_file> $NC"
  exit 1
fi

NEW_BUNDLE_IDENTIFIER=$1
NEW_APP_NAME=$2
rem Change to the project directory
cd "$PROJECT_DIR"

dart pub global activate rename
echo "======= Old Package Name ======="
rename getBundleId --targets android
rename getBundleId --targets ios
echo "======= New Package Name ======="
echo "======= $NEW_BUNDLE_IDENTIFIER ======="
rename setBundleId --targets android --value "$NEW_BUNDLE_IDENTIFIER"
rename setBundleId --targets ios --value "$NEW_BUNDLE_IDENTIFIER"

####
# Change app name
# Specify the list of env files to modify
files='_env/dev.env _env/uat.env _env/prod.env'

# Define the old and new values
old_value="APP_NAME=.*$"
new_value="APP_NAME=\"$NEW_APP_NAME\""

# Convert the list of files into an array
file_array=($files)
# Loop through each file
for file in "${file_array[@]}"; do
  # Check if the file exists before attempting to modify it
  if [ -f "$file" ]; then
    # Use grep to search for the old value in the file
    if grep -q "$old_value" "$file"; then
      # Use sed to replace the text, escaping the $ in the regular expression
      sed "s/$old_value/$new_value/" "$file" > tmp && mv tmp "$file"
      echo "Replacement completed successfully."
    else
      echo "The old value '$old_value' was not found in the file."
    fi
  else
    echo "File $file not found. Please make sure the file exists in the current directory."
  fi
done

#vscode launch
vscode_new_value="APP_NAME=$NEW_APP_NAME\","
sed "s/$old_value/$vscode_new_value/" ".vscode/launch.json" > tmp && mv tmp ".vscode/launch.json"

fvm flutter clean
fvm flutter pub get
echo "======= Completed ======="
