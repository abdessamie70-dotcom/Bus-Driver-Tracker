@echo off
chcp 65001 > nul
title خادم تشغيل برنامج متابعة سائق الحافلة للهاتف
powershell -ExecutionPolicy Bypass -File "%~dp0server.ps1"
pause
