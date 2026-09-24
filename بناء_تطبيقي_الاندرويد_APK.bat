@echo off
chcp 65001 >nul
title بناء تطبيقي أندرويد (APK) - مؤسسة سويقات أبو طالب
color 0b

echo ================================================================
echo    مؤسسة سويقات أبو طالب للنقل - بناء تطبيقي أندرويد (APK)
echo ================================================================
echo.
echo  1. لوحة تحكم الإدارة (Souikat-Admin-Dashboard.apk)
echo  2. بوابة حجز المسافرين (Souikat-Passenger-Booking.apk)
echo.
echo ================================================================
echo.

cd /d "%~dp0bus_driver_tracker_app"

echo [1/3] جلب الحزم والمكتبات اللازمة (flutter pub get)...
call flutter pub get

if errorlevel 1 (
    echo.
    echo [تنبيه] لم يتم العثور على أداة Flutter مثبتة محلياً أو فشل الأمر.
    echo يمكنك تنزيل ملفات الـ APK مباشرة وبشكل آلي عبر GitHub Actions!
    pause
    exit /b
)

echo.
echo [2/3] بناء التطبيق الأول: لوحة تحكم الإدارة...
call flutter build apk -t lib/main.dart --release
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    if not exist "..\dist-apks" mkdir "..\dist-apks"
    copy /y "build\app\outputs\flutter-apk\app-release.apk" "..\dist-apks\Souikat-Admin-Dashboard.apk" >nul
    echo  [+] تم إنشاء: dist-apks\Souikat-Admin-Dashboard.apk بنجاح!
)

echo.
echo [3/3] بناء التطبيق الثاني: بوابة حجز المسافرين...
call flutter build apk -t lib/main_booking.dart --release
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    if not exist "..\dist-apks" mkdir "..\dist-apks"
    copy /y "build\app\outputs\flutter-apk\app-release.apk" "..\dist-apks\Souikat-Passenger-Booking.apk" >nul
    echo  [+] تم إنشاء: dist-apks\Souikat-Passenger-Booking.apk بنجاح!
)

echo.
echo ================================================================
echo  اكتمل البناء بنجاح!
echo  الملفات موجودة الآن داخل المجلد: dist-apks\
echo ================================================================
explorer "..\dist-apks"
pause
