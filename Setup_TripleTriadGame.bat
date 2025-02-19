@echo off
echo Starting Pixel Streaming Server...

:: Change to current directory
echo Changing to current directory...
cd /d "%~dp0"

:: Get the current directory dynamically
set "GAME_DIR=%~dp0"

:: Define the Pixel Streaming Server directory relative to the current folder
set "PS_SERVER_DIR=%GAME_DIR%Windows\TripleTriad\Samples\PixelStreaming2\WebServers"

:: Define the game executable location (inside Windows folder)
set "GAME_EXE=%GAME_DIR%Windows\TripleTriad.exe"

:: Setup the Pixel Streaming Server in a new window
if exist "%PS_SERVER_DIR%\get_ps_servers.bat" (
    echo Found get_ps_servers. Starting...
    start "PixelStreamingServer" cmd /c "%PS_SERVER_DIR%\get_ps_servers.bat"
	:: Start the signalling server
	if exist "%PS_SERVER_DIR%\SignallingWebServer\platform_scripts\cmd\start_with_stun.bat" (
		echo Found start_with_stun. Starting...
		start "Stun Script" cmd /c "%PS_SERVER_DIR%\SignallingWebServer\platform_scripts\cmd\start_with_stun.bat"
	) else (
		echo ERROR: Could not find start_with_stun.bat in %PS_SERVER_DIR%
		pause
		exit /b
	)
) else (
    echo ERROR: Could not find get_ps_servers.bat in %PS_SERVER_DIR%
    pause
    exit /b
)

:: Wait for the server to initialize
timeout /t 10 /nobreak

:: Start the Triple Triad game with Pixel Streaming in a new window
if exist "%GAME_EXE%" (
    echo Starting Triple Triad Game with Pixel Streaming...
    start "TripleTriadGame" cmd /c "%GAME_EXE%" -PixelStreamingURL=ws://127.0.0.1:8888 -RenderOffScreen
) else (
    echo ERROR: Could not find TripleTriad.exe in %GAME_DIR%Windows\
    pause
    exit /b
)

echo Pixel Streaming Server and Game have started!
pause
