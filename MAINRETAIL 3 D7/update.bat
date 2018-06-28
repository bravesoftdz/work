@echo off
echo.
echo "Confirm that all MR programs are not running.  Check in Task Manager."
pause
cls
echo "Registering Midas.DLL"
regsvr32 C:\Progra~1\MainRetail\midas.dll
echo "Stopping Services"
echo "PCMaintSvc"
"C:\Progra~1\MainRetail\PCMaintSvc.exe" --remove
echo "scktsrvr"
net stop SocketServer
"C:\Progra~1\MainRetail\scktsrvr.exe" "/uninstall"
echo "Please kill scktsrvr at this point if it was already installed."
pause
cls
xcopy /E /T "C:\Progra~1\MainRetail\Shortcuts\*" "C:\Documents and Settings\All Users\Desktop"
echo .
echo "Creating Services"
echo "PCMaintSvc"
move "C:\Progra~1\MainRetail\new\PCMaintSvc.exe" "C:\Progra~1\MainRetail\"
"C:\Progra~1\MainRetail\PCMaintSvc.exe" --install auto
echo "scktsrvr"
move "C:\Progra~1\MainRetail\new\scktsrvr.exe" "C:\Progra~1\MainRetail\"
"C:\Progra~1\MainRetail\scktsrvr.exe" "/install"
net start SocketServer
echo "Done Creating Services"
pause
cls
echo.
echo "Next step is do create scheduled tasks.  Remove any existing MR scheduled task, then press any key"
"C:\Progra~1\MainRetail\schtasks.exe" /Query
pause
echo "Creating MRBackup Task"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "MRBackup" /tr "C:\Progra~1\MainRetail\MRBackup.exe 1" /ru System /sc daily /st 23:01:00
echo "Creating MRDailyMaintenance Task"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "MRDailyMaintenance" /tr "C:\Progra~1\MainRetail\MRDailyMaintenance.exe" /ru System /sc daily /st 03:01:00
echo "Backup Tasks Created"
pause
cls
SET /P CATALOG=Is this a catalog server (Y/N)?
if not {%CATALOG%}=={Y} goto :nocat
echo "Creating Catalog Tasks"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "MRCatalog - Full" /tr "C:\Pinogy\bin\miniupdate.exe" /ru System /sc weekly /st 00:01:00
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "MRCatalog - Daily" /tr "C:\Pinogy\bin\miniupdate.bat" /ru System /sc daily /st 06:01:00
echo "Catalog Tasks Created"
pause
:nocat
cls
SET /P CORP=Is this a corporate server (replication) (Y/N)?
if not {%CORP%}=={Y} goto :nocorp
echo "Creating ServerMonitor Task"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "ServerMonitor" /tr "C:\Progra~1\MainRetail\Replication\ServerMonitor.exe" /ru System /sc daily /st 23:31:00
echo "Make sure ServerMonitor is setup at C:\Progra~1\MainRetail\Replication\ServerMonitor.exe"
pause
goto :sql_setup
:nocorp
echo.
SET /P REP=What number client server (replication) is this (2/3/4/5/6/7/8/9/10/N)?
if {%REP%}=={2} goto :rep2
if {%REP%}=={3} goto :rep3
if {%REP%}=={4} goto :rep4
if {%REP%}=={5} goto :rep5
if {%REP%}=={6} goto :rep6
if {%REP%}=={7} goto :rep7
if {%REP%}=={8} goto :rep8
if {%REP%}=={9} goto :rep9
if {%REP%}=={10} goto :rep10
if {%REP%}=={N} goto :end
:rep2
echo "Creating RepMonitor Task - Store 2"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 2" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:01:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep3
echo "Creating RepMonitor Task - Store 3"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 3" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:11:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep4
echo "Creating RepMonitor Task - Store 4"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 4" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:21:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep5
echo "Creating RepMonitor Task - Store 5"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 5" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:31:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep6
echo "Creating RepMonitor Task - Store 6"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 6" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:41:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep7
echo "Creating RepMonitor Task - Store 7"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 7" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 00:51:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep8
echo "Creating RepMonitor Task - Store 8"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 8" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 01:01:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep9
echo "Creating RepMonitor Task - Store 9"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 9" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 01:11:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:rep10
echo "Creating RepMonitor Task - Store 10"
"C:\Progra~1\MainRetail\schtasks.exe" /create /tn "RepMonitor - 10" /tr "C:\Progra~1\MainRetail\Replication\RepMonitor.exe" /ru System /sc daily /st 01:21:00
echo "Make sure RepMonitor is setup at C:\Progra~1\MainRetail\Replication\RepMonitor.exe"
pause
goto :sql_setup
:sql_setup
cls
SET /P SQL=Is this server running SQL (not MSDE)? (Y/N)?
if {%SQL%}=={N} goto :end
echo "Removing MRDailyMaintenance and MRBackup Scheduled Tasks.
"C:\Progra~1\MainRetail\schtasks.exe" /Delete /tn "MRDailyMaintenance"  /F
"C:\Progra~1\MainRetail\schtasks.exe" /Delete /tn "MRBackup"  /F
echo.
echo "Check 'Disable update system qty' in ServerMonitor or RepMonitor (under Schedule task)."
pause
mkdir C:\SQL_Backup
copy "C:\Progra~1\MainRetail\MRZip.exe" "C:\SQL_Backup\"
echo "Creating Database MRMaintenanceDB and SP"
osql -E -Q "create database MRMaintenanceDB"
osql -E -d MRMaintenanceDB -i "C:\Progra~1\MainRetail\SQL_Scripts\Backup_Database.sql"
REM del "C:\Progra~1\MainRetail\SQL_Scripts\Backup_Database.sql"
REM echo "Running Backup"
REM osql -E -Q "EXEC sp_Sis_Backup"
REM echo "Checking Backup"
REM dir C:\SQL_Backup\
echo.
echo "Make sure SQL Agent is started and set to auto"
pause
echo "Creating Maintenance Plans"
osql -E -d MRMaintenanceDB -i "C:\Progra~1\MainRetail\SQL_Scripts\MRBackup_Job.sql"
osql -E -d MRMaintenanceDB -i "C:\Progra~1\MainRetail\SQL_Scripts\MRDailyMaintenance_Job.sql"
REM del "C:\Progra~1\MainRetail\SQL_Scripts\MRBackup_Job.sql"
REM del "C:\Progra~1\MainRetail\SQL_Scripts\MRDailyMaintenance_Job.sql"
pause
:end
cls
echo "Generating Image File"
osql -E -d MainRetailDB -i "C:\Progra~1\MainRetail\SQL_Scripts\mr_images.sql" -o C:\Pinogy\logs\img_skus.txt
echo "Image file create as C:\Pinogy\logs\img_skus.txt"
echo "Please upload to portal.pinogy.com under Cust/XXX directory"
pause
echo "Running UpdateMenu to set default settings.  If this is an existing customer, do not select update server parameters.  If it is a new customer, select update server paramters."
C:\Progra~1\MainRetail\sleep.exe 3
C:\Progra~1\MainRetail\UpdateMenu.exe
del C:\Progra~1\MainRetail\UpdateMenu.exe
echo.
echo "Done with updates, starting checks."
rmdir new
"C:\Progra~1\MainRetail\checks.bat"
pause
