set SUBFILENAME=%date:~-4%-%date:~-7,2%-%date:~-10,2%---%time:~-11,2%-%time:~-8,2%-%time:~-5,2%
setlocal enabledelayedexpansion
set SUBFILENAME=!SUBFILENAME:^ =0!
setlocal disabledelayedexpansion
net use \\<your smb IP address here> /delete /yes >> C:\backupskripte\log_stuendlich_%SUBFILENAME%.txt
timeout 1
net use \\<your smb IP address here>\<folder>\<folder> /user:<username> <password> >> C:\backupskripte\log_stuendlich_%SUBFILENAME%.txt
timeout 1
robocopy /r:2 /w:5 D:\<folder>\<folder>\<folder>\<folder> \\<your smb IP address here>\<folder>\<folder>\<folder> /MIR >> C:\backupskripte\log_stuendlich_%SUBFILENAME%.txt
IF NOT EXIST C:\backupskripte\log_stuendlich.zip (
C:\backupskripte\zipjs.bat zipItem -source C:\backupskripte\log_stuendlich_%SUBFILENAME%.txt -destination C:\backupskripte\log_stuendlich.zip -keep no
) ELSE (
C:\backupskripte\zipjs.bat addToZip -source C:\backupskripte\log_stuendlich_%SUBFILENAME%.txt -destination C:\backupskripte\log_stuendlich.zip -keep no
)
exit 0
