#!/usr/bin/env bash
# ClientFlow Tracker - Android APK Build Script
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=========================================================="
echo " Building ClientFlow Android APK"
echo "=========================================================="

export JAVA_HOME="$HOME/.jdk21"
export PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"

# 1. Build React web application
echo "▶ 1. Building React production bundle..."
npm --prefix frontend run build

# 2. Sync web assets into Android project
echo "▶ 2. Syncing assets with Capacitor Android..."
cd frontend
npx cap sync android
cd ..

# 3. Compile Android APK using Gradle
echo "▶ 3. Compiling Android APK with Gradle..."
cd frontend/android
./gradlew assembleDebug
cd ../..

# 4. Copy APK to convenient root directory
mkdir -p apks
cp frontend/android/app/build/outputs/apk/debug/app-debug.apk apks/clientflow-tracker.apk

echo "=========================================================="
echo " ✅ Android APK Build Complete!"
echo " Location: $DIR/apks/clientflow-tracker.apk"
echo ""
echo " To install on a connected phone or emulator:"
echo "   adb install $DIR/apks/clientflow-tracker.apk"
echo "=========================================================="
