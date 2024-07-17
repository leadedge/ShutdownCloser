rem
rem Closer
rem
@ECHO OFF
cls
echo.
echo ==================================================================
echo                            Closer
echo  Set a timer or the time to Shutdown, Log off, Sleep or Hibernate
echo ==================================================================
echo.
set hrs=0
set mins=0
set secs=0
set input=
set action=
rem
echo.
echo [1] Shutdown
echo [2] Log off
echo [3] Sleep
echo [4] Hibernate
set /P action=:
if "%action%" == "" goto End
rem
rem Choose to enter a timer or end time
rem
echo.
set input=
echo [1] Set a timer
echo [2] Set the end time
set /P input=:
if "%input%" == "" goto End
if "%input%" == "1" goto SetTimer
rem
rem Calculate start seconds (time format : 12:07:59.42)
rem
set tm=%TIME%
set hrs=%tm:~0,2%
set mins=%tm:~3,2%
set secs=%tm:~6,2%
set /A startsecs=%hrs%*3600+%mins%*60+%secs%
rem 
rem Set the hour and minute to end countdown
rem
set hrs=0
set mins=0
set secs=0
echo.
echo Enter the end time (hour and minute)
set /P hrs=Hour   : 
set /P mins=Minute : 
rem Check for zero time
if "%hrs%" NEQ 0 goto CalcEndTime
if "%mins%" NEQ 0 goto CalcEndTime
goto End
rem
rem Calculate end seconds
rem
:CalcEndTime
set /A endsecs = %hrs%*3600+%mins%*60+%secs%
rem
rem Calculate timer
rem
set /A timer = endsecs-startsecs
if %timer% EQU 0 goto End
if %timer% GTR 0 goto CountDown
echo Negative time
goto End
rem
rem Enter Hours/Minutes/Seconds for a timer
rem
:SetTimer
set hrs=0
set mins=0
set secs=0
echo.
echo Enter timer (Hours/Minutes/Seconds)
set /P hrs=Hours   : 
set /P mins=Minutes : 
set /P secs=Seconds : 
rem Check for no entry
if "%hrs%" NEQ 0 goto CalcTotal
if "%mins%" NEQ 0 goto CalcTotal
if "%secs%" NEQ 0 goto CalcTotal
goto End
rem
rem Calculate total seconds
rem
:CalcTotal
set /A timer = %hrs%*3600+%mins%*60+%secs%
if %timer% EQU 0 goto End
if %timer% GTR 0 goto CountDown
echo Negative time
goto End
rem
rem Show the timer and end time 
rem
:CountDown
echo.
set /A hrs=%timer%/3600
set /A mins=(%timer%-%hrs%*3600)/60
set /A secs=(%timer%-%hrs%*3600-%mins%*60)
rem
if %action% EQU 1 echo Shutdown in %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 2 echo Log off in %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 3 echo Sleep in %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 4 echo Hibernate in %timer% seconds (%hrs% hours %mins% mins %secs% secs)
rem
set tm=
set startsecs=
set endsecs=
set hours=
set mins=
set secs=
set input=
rem
rem Shutdown
rem
if %action% NEQ 1 goto logoff
timeout /t %timer% /NOBREAK
set timer= &set action=
shutdown /s /f
rem
rem Log off
rem
:logoff
if %action% NEQ 2 goto sleep
timeout /t %timer% /NOBREAK
set timer= &set action=
shutdown.exe -l -f
rem
rem Sleep
rem
:sleep
if %action% NEQ 3 goto hibernate
timeout /t %timer% /NOBREAK
set timer= &set action=
rundll32.exe powrprof.dll,SetSuspendState 0,1,0 
rem
rem Hibernate
rem
:hibernate
if %action% NEQ 4 goto End
timeout /t %timer% /NOBREAK
set timer= &set action=
shutdown /h /f
rem
:End
echo.
rem clear all variables
set tm=
set startsecs=
set endsecs=
set hours=
set mins=
set secs=
set input=
set timer=
set action=
rem
rem End Closer
rem


