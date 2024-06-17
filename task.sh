# For your convenience 
alias PlistBuddy=/usr/libexec/PlistBuddy

if [ -d "Exported_CATS" ]; then
  rm -rf "Exported_CATS"
  echo "Exported_CATS is deleted"
else
  echo "Exported_CATS  isn`t exist"
fi

if [ -d "Exported_DOGS" ]; then
  rm -rf "Exported_DOGS"
  echo "Exported_DOGS is deleted"
else
  echo "Exported_DOGS isn`t exist"
fi

cp exportOptionsTemplate.plist exportOptionsTemplate_temp.plist
PLIST="exportOptionsTemplate_temp.plist"
INFO="CatsAndDogs/Info.plist"
ANIMALS="$1"

if [ "$ANIMALS" = "CATS" ] || [ "$ANIMALS" = "DOGS" ]; then
    PlistBuddy -c "Set :ANIMALS $ANIMALS" $INFO
    echo "The user entered: $ANIMALS"
else
    echo "Invalid input. Please enter either 'CATS' or 'DOGS'."
    exit 1
fi

PlistBuddy -c "Set :destination export" $PLIST
PlistBuddy -c "Set :method development" $PLIST
PlistBuddy -c "Set :signingStyle automatic" $PLIST
PlistBuddy -c "Set :teamID D85QWSUNYA" $PLIST
PlistBuddy -c "Set :signingCertificate Phone Developer: Анастасія Лиса (CDFK9TBXDC)" $PLIST
PlistBuddy -c "Delete :provisioningProfiles:%BUNDLE_ID%" $PLIST
PlistBuddy -c "Add :provisioningProfiles:ua.edu.ukma.apple-env.lysa.CatsAndDogs string 62c9acc3-4eb0-47dd-9a71-b7090a59ea36" $PLIST

# IMPLEMENT:
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS

# IMPLEMENT:
# Clean build folder
PROJECT=CatsAndDogs.xcodeproj
SCHEME=CatsAndDogs
CONFIG=Debug
DEST="generic/platform=iOS"
VERSION="v1.0.0"
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"
EXPORT_PATH="./Exported_${ANIMALS}"

xcodebuild clean -project "${PROJECT}" -scheme "${SCHEME}" -configuration "${CONFIG}"


# IMPLEMENT:
# Create archive
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-project "${PROJECT}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

# IMPLEMENT:
# Export archive
xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${PLIST}" # обовʼязково!

rm exportOptionsTemplate_temp.plist
echo "Good!"
