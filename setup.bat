@echo off
setlocal
title YouTube Connector - One Time Setup
cd /d "%~dp0"

echo.
echo ==========================================================
echo   YouTube Connector - One Time Setup (Windows)
echo ==========================================================
echo.

rem --- Node.js check ------------------------------------------------
where node >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Node.js aapke computer par install nahi hai.
  echo.
  echo Pehle yeh page kholein aur Node.js install karein:
  echo     https://nodejs.org/
  echo.
  echo Install hone ke baad computer restart karein aur
  echo phir se yeh setup.bat double-click karein.
  echo.
  pause
  exit /b 1
)

echo [1/3] Dependencies install ho rahi hain (1-2 minute lag sakte hain)...
call npm install --no-fund --no-audit
if errorlevel 1 (
  echo.
  echo [ERROR] npm install fail ho gayi. Internet connection check karein
  echo aur phir se try karein.
  echo.
  pause
  exit /b 1
)

echo.
echo [2/3] Connector build ho raha hai...
call npm run build
if errorlevel 1 (
  echo.
  echo [ERROR] Build fail ho gayi.
  echo.
  pause
  exit /b 1
)

echo.
echo [3/3] Claude Desktop mein connector set ho raha hai...
node scripts\setup-claude-desktop.mjs
if errorlevel 1 (
  echo.
  echo [ERROR] Claude Desktop config set nahi ho saki. Upar ka error dekhein.
  echo.
  pause
  exit /b 1
)

echo.
echo ==========================================================
echo   SETUP COMPLETE
echo ==========================================================
echo.
pause
exit /b 0
