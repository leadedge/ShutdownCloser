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
rem
set starthrs=0
set startmins=0
set startsecs=0
set endhrs=0
set endmins=0
set endsecs=0
set hrs=0
set mins=0
set secs=0
set input=
set action=
rem
rem Get the time now
rem
set tm=%TIME%
set starthrs=%tm:~0,2%
set startmins=%tm:~3,2%
set secs=%tm:~6,2%
rem
rem Calculate start seconds (time format : 12:07:59.42)
rem
rem set /A startsecs=%starthrs%*3600+%startmins%*60+%secs%
set /A startsecs=starthrs*3600+startmins*60+secs
rem
rem Look for command line arguments
rem No args - user entry
rem
if "%1" == "" goto setaction
if "%2" == "" goto setaction
rem
rem args for shutdown
rem
set action=1
rem
rem 2 args - hours and mins to set time for shutdown
rem
if "%3" NEQ "" goto dotimer
set endhrs=%1%
set endmins=%2%
set secs=0
rem
goto CalcHours
rem
rem 3 args - hours, minutes, seconds until shutdown
rem
:dotimer
set hrs=%1%
set mins=%2%
set secs=%3%
rem
goto CalcTotal
rem
rem User entry to select action
rem
:setaction
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
rem Set the hour and minute to end countdown
rem
:SetTime
set endhrs=0
set endmins=0
set secs=0
echo.
echo Enter the end time (hour and minute)
set /P endhrs=Hour   : 
set /P endmins=Minute : 
rem Check for zero time
if %endhrs%  NEQ 0 goto CalcHours
if %endmins% NEQ 0 goto CalcHours
goto End
rem
rem Allow for a 24 hour cycle. For example :
rem start hour is 18 (6pm) and end hour is 1am the next day
rem If end < start. Add 24 hours to the end hour.
rem
:CalcHours
if %endhrs% GTR %starthrs% goto CalcEndTime
rem
rem Next day
set /A endhrs=endhrs+24
rem
rem
rem Calculate end seconds
rem
:CalcEndTime
set /A endsecs = %endhrs%*3600+%endmins%*60+%secs%
rem
rem Calculate timer for end hour entry
rem
set /A timer    = endsecs-startsecs
rem
if %timer% EQU 0 goto End
if %timer% GTR 0 goto CountDown
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
if %hrs%  NEQ 0 goto CalcTotal
if %mins% NEQ 0 goto CalcTotal
if %secs% NEQ 0 goto CalcTotal
goto End
rem
rem Calculate timer - total seconds entered
rem
:CalcTotal
set /A timer=%hrs%*3600+%mins%*60+%secs%
set /A endhrs=starthrs+%hrs%
set /A endmins=startmins+%mins%
rem
if %timer% EQU 0 goto End
if %timer% GTR 0 goto CountDown
goto End
rem
:CountDown
rem
rem timeout limits
rem
if %timer% GTR 99999 set /A timer=99999
if %timer% LSS 0 set /A timer=0
rem
rem echo timer limited [%timer%]
rem
rem Show the timer and end time 
rem
set /A hrs=%timer%/3600
set /A mins=(%timer%-%hrs%*3600)/60
set /A secs=(%timer%-%hrs%*3600-%mins%*60)
rem
rem Show a readable end time
rem
rem Set am to start
set amp=am
rem Allow for the next day e.g. 25hrs = 1am
if %endhrs% LSS 24 goto amorpm
set /A endhrs=%endhrs%-24
rem Work out am or pm
:amorpm
if %endhrs% GEQ 12 set amp=pm
rem non-24hr hour format e.g. 18hrs = 6pm
if %endhrs% GTR 12 set /A endhrs=%endhrs%-12
rem format minutes with 2 digit numerals
:formatmins
if 1%endmins% LSS 100 set endmins=0%endmins%
set tm=%endhrs%:%endmins% %amp%
rem
rem Show end time and timer
rem
echo.
if %action% EQU 1 echo Shutdown at %tm% after %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 2 echo Log off at %tm% after %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 3 echo Sleep at %tm% after %timer% seconds (%hrs% hours %mins% mins %secs% secs)
if %action% EQU 4 echo Hibernate at %tm% after %timer% seconds (%hrs% hours %mins% mins %secs% secs)
rem
set tm=
set starthrs=
set starmins=
set startsecs=
set endhrs=
set endmins=
set endsecs=
set hrs=
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
set starthrs=
set startmins=
set startsecs=
set endhrs=
set endmins=
set endsecs=
set hrs=
set mins=
set secs=
set timer=
set input=
set action=
rem
rem End Closer
rem
