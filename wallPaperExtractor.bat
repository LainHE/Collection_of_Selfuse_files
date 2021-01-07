@echo off & title Wallpaper Auto Extractor

CALL :CreatVBS

ROBOCOPY %LocalAppdata%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets  %USERPROFILE%\Pictures\WindowsLockscreenPhoto\Temp *.* /min:153600
cd /d %USERPROFILE%\Pictures\WindowsLockscreenPhoto\Temp

ren * *.jpg

for %%a in (*.jpg) do (
    for /f "tokens=1 delims=x" %%i in ('cscript /nologo "%tmp%\GetImgInfo.vbs" "%%~a"') do (
        if "%%~i"=="1920" (
            if not exist "..\%%~a" move "%%~a" ..\
        )
    )
)

cd /d .. & rd /s /q Temp
del /f /q "%tmp%\GetImgInfo.vbs"
echo Widescreen wallpaper extracted
timeout /t 3 /nobreak >nul
exit
 
:CreatVBS
(echo Dim Img
echo Set Img = CreateObject^("WIA.ImageFile"^)
echo Img.LoadFile WScript.Arguments^(0^)
echo Wscript.Echo Img.Width ^& "x" ^& Img.Height ^& "x" ^& Img.HorizontalResolution)>"%tmp%\GetImgInfo.vbs"
goto :eof