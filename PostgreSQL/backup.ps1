$pgserver = ''
$userName = ''

$rootPath = ''

$dbs = @(

#add db names here

)
$destination = New-Item -Path $rootPath -ItemType Directory -Name ''

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
            
    Write-Host ("INFO: $(Get-Date): $($dbs.Count) dbs should be backup")
    