<#
.SYNOPSIS
    Create or re-create the database and apply migrations.
.DESCRIPTION
    Provides a consistent, reproducible way to make and test database changes.

    Takes the MainRetailDB backup zip file, extracts the backup file, deletes
    the database, restores the database, applies all the SQL migrations, then
    removes the backup file.

    If you get Powershell execution warnings, see the following file:
    DB/notes/how-to-run-powershell-scripts.txt.

    Do not rename the .7z backup file - the script currently assumes that the
    .BAK file basename will be the same basename as its .7z container, only
    the extensions will be different.

    Currently uses 7-zip. Download from http://www.7-zip.org/download.html
    and set the -zip_program_dir to the path you used during installation.
.EXAMPLE
    Copy DB\utils\my-restore.ps1.example to DB\utils\my-restore.ps1,
    customize the parameters for your environment, then run them from
    within powershell, e.g. .\utils\my-restore.ps1
.PARAMETER db_path
    The location where SQL Server's internal data files (e.g. .MDF) should be
    created.
.PARAMETER temp_path
    Path to a temporary directory where the backup file can be extracted from
    the zip file.
.PARAMETER zip_program_dir
    Path to where you installed 7-zip.
.PARAMETER zip_password
    Password to decrypt the MainRetail backup zip file.
.PARAMETER delete_bak_when_done
    Delete the extracted MainRetailDB backup file (.BAK) when done.
.PARAMETER migrations_path
    Path to the directory containing all of the SQL migration files.
.PARAMETER server
    SQL Server name
.PARAMETER db_name
    Database name to create or recreate using the backup file.
.PARAMETER db_zipfile
    Path to the MainRetail backup zip file.
#>

param (
    [string]$db_path = 'C:\MSSQL_Data',
    [string]$temp_path = "C:\Temp",
    [string]$zip_program_dir = "C:\Program Files\7-Zip",
    [string]$zip_password = "MR_DB_User",
    [bool]$delete_bak_when_done = $true,

    [ValidateScript({Test-Path $_ -PathType 'Container'})]
    [string]
    $migrations_path = $(throw "-migrations_path is required."),

    [string]$server = '(local)',
    [string]$db_name = $(throw "-db_name (no brackets) is required."),
    [string]$db_zipfile = $(throw "-db_zipfile is required.")
)

$timer_start = Get-Date

Write-Host "Starting" $MyInvocation.MyCommand.Name "Parameters are:"
Write-Host "server: $server"
Write-Host "db_path: $db_path"
Write-Host "db_zipfile: $db_zipfile"
Write-Host "migrations_path: $migrations_path"
Write-Host "zip_program_dir: $zip_program_dir"
Write-Host "temp_path: $temp_path"
Write-Host

if (-Not(Test-Path ($temp_path))) {
    New-Item -ItemType directory -Path $temp_path
}

if (-Not(Test-Path ($db_path))) {
    New-Item -ItemType directory -Path $db_path
}

$bak_basename = Get-ChildItem $db_zipfile | % {$_.BaseName}
$bak_filename = $bak_basename + ".BAK"
$bak_fullpath = $temp_path + "\" + $bak_filename
if (Test-Path ($bak_fullpath)) {
    Write-Host "Skip database unzip, extracted database backup already exists."
    # Or we could remove it and extract anyway, with this command:
    # Remove-Item $bak_fullpath -Confirm
}
else {
    Write-Host "Extract zipfile."
    Push-Location -Path $temp_path
    Start-Process "$zip_program_dir\7z.exe" -NoNewWindow -Wait -Args `
        @("x -p$zip_password $db_zipfile")
    Pop-Location
}

Write-Host "Disconnect users if there are any."
$single_user = "alter database [$db_name] set Single_User with rollback immediate"
SqlCmd -b -E -S $server -Q "$single_user"

Write-Host "Restore database."
# Hopefully we've standardized everywhere on MainRetailDB_Data and MainRetailDB_Log
# so that these "move" options will work.
$restore_sql = "restore database [$db_name] from disk='$bak_fullpath' " `
    + "with recovery, move 'MainRetailDB_Data' to '$db_path\MainRetailDB_Data.mdf', " `
    + "move 'MainRetailDB_Log' to '$db_path\MainRetailDB_Data.log'"
SqlCmd -b -E -S $server -Q "$restore_sql"
if ($LastExitCode) {
	Write-Host "Error restoring database, exit early."
	Exit
}

#Exit

$mycwd = Convert-Path .
Write-Host $mycwd
Write-Host "Apply migrations"
#Push-Location -Path $migrations_path
Invoke-Expression -Command ".\utils\apply-migrations.ps1 -server '$server' -database $db_name -migrations_path '$migrations_path'"
#Pop-Location


if ($delete_bak_when_done) {
    Write-Host "Remove unzipped database backup file"
    Remove-Item $bak_fullpath
}

$timer_end = Get-Date
$duration = ($timer_start - $timer_end).TotalSeconds
Write-Host "Total wall-clock time taken: $duration"

Write-Host
Write-Host "Exiting" $MyInvocation.MyCommand.Name