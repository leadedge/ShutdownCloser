# ShutdownCloser
A Windows batch script scheduler for un-attended shutdown with quick and easy entry for either a timer or end time that shows the countdown progress and allows terminaton at any time. An addition to the many other variants. Here to share in case it is useful.

## Closer.bat

A batch file to set a timer or the time to Shutdown, Log off, Sleep or Hibernate.

Time entry - with protection against empty or incorrect entry
- To set a timer - enter the hours, minutes and seconds before action
- To set a time  - enter the hour and minute for action
 
The timer is managed using [timeout](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/timeout) which shows the seconds counting down and gives the option to abort at any time using "Ctrl-C".

## StartCloser.vbs

The command console for Closer.bat is started with low affinity and lowest prority so that it is has minimal impact on the system while running. 

## Closer.lnk

A handy shortcut for the desktop.
