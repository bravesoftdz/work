# NAME: apply-migrations.ps1 - applies all SQL migrations to the database
# USAGE: DB\utils\apply-migrations.ps1 -server "(local)\Pinogy" -database MainRetailDB_Master -mig_dir .\DB\changes\V6\323
# The server and database name parameters will use the above values as
# defaults if no value is given for them.
# See notes/how-to-run-powershell-scripts.txt

param (
    [string]$server = "(local)\Pinogy",
    [string]$database = "MainRetailDB_Master",
    [string]$migrations_path
)

Write-Host "Starting" $MyInvocation.MyCommand.Name
Write-Host "Apply SQL migrations in directory '$migrations_path' to server '$server', database '$database'."
Write-Host

# SqlCmd notes:
#    -E for trusted connection
#    -S for server
#    -b on error batch abort
#    -i input file(s)
Start-Process SqlCmd -NoNewWindow -Wait -Args `
    @(@("-E -S $server -d $database -b -i") + (ls "$migrations_path/*.sql" | sort -property Name))

Write-Host
Write-Host "Done applying SQL migrations."
Write-Host "Exiting" $MyInvocation.MyCommand.Name