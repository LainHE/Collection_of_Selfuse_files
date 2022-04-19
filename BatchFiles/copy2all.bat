@echo off
set fn=PUTYOURFILENAMEHERE
for /f "tokens=*" %%i in ('dir/s/b/ad') do copy %fn% "%%i"
pause
