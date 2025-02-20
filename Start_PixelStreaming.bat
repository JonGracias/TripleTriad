@echo off
echo Starting Pixel Streaming and Triple Triadzzz...

:: Get the current directory dynamically
set "GAME_DIR=%~dp0"

:: Define the Pixel Streaming Server and Commands directories
set "PS_SERVER_DIR=%GAME_DIR%Windows\TripleTriad\Samples\PixelStreaming2\WebServers"
set "PS_CMD_DIR=%PS_SERVER_DIR%\SignallingWebServer\platform_scripts\cmd"

:: Define the game executable location (inside Windows folder)
set "GAME_EXE=%GAME_DIR%Windows\TripleTriad.exe"


:: Start Pixel Streaming with STUN
if exist "%PS_CMD_DIR%\start_with_stun.bat" (
    echo Starting Pixel Streaming with STUN...
    start "PixelStreamingSTUN" cmd /c "%PS_CMD_DIR%\start_with_stun.bat"
) else (
    echo ERROR: Could not find start_with_stun.bat in %PS_CMD_DIR%
    pause
    exit /b 1
)

:: Wait for the Pixel Streaming Server to fully initialize
timeout /t 10 /nobreak

:: Start the Triple Triad game with Pixel Streaming in a new window
if exist "%GAME_EXE%" (
    echo Starting Triple Triad Game with Pixel Streaming...
    start "TripleTriadGame" "%GAME_EXE%" -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8888 -RenderOffscreen
) else (
    echo ERROR: Could not find TripleTriad.exe in %GAME_DIR%Windows\
    pause
    exit /b 1
)

echo Pixel Streaming Server and Game have started successfully!
pause