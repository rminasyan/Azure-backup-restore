$pgserver = ''
$userName = ''

$rootPath = ''

$dbs = @(

#add db names here

)
$destination = New-Item -Path $rootPath -ItemType Directory -Name 'backup'

function BackupPGserver {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]$pgserver,
        
        [Parameter(Mandatory = $true)]
        [string]$userName,
        
        [Parameter(Mandatory = $true)]
        [array[]]$dbs,
        
        [Parameter(Mandatory = $true)]
        [string[]]$destination
    )