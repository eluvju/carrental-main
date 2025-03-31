@echo off
cd android
call gradlew clean
cd ..
call flutter clean
call flutter pub get
call flutter build apk --no-shrink --verbose 