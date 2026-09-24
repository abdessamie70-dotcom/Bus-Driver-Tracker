@echo off
chcp 65001 > nul
title تشغيل رابط إنترنت عام لبرنامج متابعة سائق الحافلة
powershell -ExecutionPolicy Bypass -File "%~dp0tunnel.ps1"
pause
