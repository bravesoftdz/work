@echo off
echo.
cd "C:\Program Files\MainRetail\"
echo "Checking sql version"
echo "Change cmd window to have 9999 history lines"
pause
osql -E -Q "SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')"
echo "2000.8.00.2039 is SP4"
echo "Scroll up to check version"
pause
cls
echo "Check MRAppServer"
echo "Check that it is pointing to the right location"
"C:\Program Files\MainRetail\MRAppServer"
pause
cls
echo "Check MRImportExport"
echo "Check that you can login"
"C:\Program Files\MainRetail\MRImportExport"
pause
cls
echo "Check MRReport"
echo "Run Tools - Report Update"
echo "Run Daily Summary for yesterday"
"C:\Program Files\MainRetail\MRReport"
pause
cls
echo "Check Pet Center"
echo "List puppies"
"C:\Program Files\MainRetail\MRPet"
pause
cls
echo "Check MainRetail"
echo "Confirm that it launches"
echo "Confirm that receipts are pointing locally and to the right place."
echo "Confirm that the PO format is set correctly and to a local copy."
echo "Confirm barcode print is pointing locally to the labels still."
echo "Confirm Pet Center is pointing to the MRPet.exe in client settings."
echo "Fix the links to MRPet, MRReport and MRImportExport (Maintenance->Menu Items)."
"C:\Program Files\MainRetail\MainRetail"
pause
cls
echo "Confirm Antivirus is installed and up to date."
pause
cls
echo "If this is a Replication store, remove any ServerMonitor or RepMonitor icons or startups.  Use AutoRuns for startups."
pause
cls
echo "Confirm IZArc is set to 7z for default compression, with SuperFast ratio."
pause
cls
echo "If store is replication, update ini files and make sure they are setup under C:\Program Files\MainRetail\Replication"
pause
cls
echo "Did you update the ftp client (Corp Replication) for the new location under MainRetail?"
pause
cls
echo "Confirm catalogs are up to date and there are no errors in the logs."
pause
cls
echo "Confirm the Pinogy folder is Shared ReadOnly."
pause
cls
echo "Update Images"
pause
rmdir "C:\Program Files\MainRetail\new"
del "C:\Program Files\MainRetail\update.bat"
