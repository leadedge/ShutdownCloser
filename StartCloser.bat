@echo off
rem
rem Start with low priority and one core affinity
rem
rem START /low /affinity 01 cmd /C closer.bat
rem
rem Option - hours, minutes and seconds
rem
rem hours + minutes - set time for shutdown
rem hour + minutes + seconds - set timer for shutdown
rem
rem Example : shut down at 10:30 pm
START /low /affinity 01 cmd /C closer.bat 22 30
rem




