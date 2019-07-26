set CUR_NAME=<your_backup_name>
set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set SUBFILENAME=%CUR_NAME%_%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
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
