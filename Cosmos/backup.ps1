#local path where the files will be downloaded
$rootPath = ''

#cosmosDB
$cosmosDb = ''
$cosmosConnStr = ''

#storage account
$SASToken = ''
$containerName = ''
$storageAccount = ''

$collections = @(

'add collection names'

)

$destination = New-Item -Path $rootPath -ItemType Directory -Name ''

function BackupCosmosDB { 
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]$destination,

        [Parameter(Mandatory = $true)]
        [string]$cosmosDb,
    
        [Parameter(Mandatory = $true)]
        [string]$cosmosConnStr,

        [Parameter(Mandatory = $true)]
        [array]$collections
    )

    foreach ($collection in $collections) {
        Write-Host("INFO: $(Get-Date): Importing $collection collection")
        dt.exe /s:DocumentDB /s.ConnectionString:"Database=$cosmosDb;$cosmosConnStr" /s.Collection:$collection /t:JsonFile /t.File:"$destination\$collection.json" /t.Overwrite
    }

    Write-Host ("INFO: $(Get-Date): Finished collections backup")
}

function ArchiveToBlob {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]$destination,
        
        [Parameter(Mandatory = $true)]
        [string]$SASToken,
                
        [Parameter(Mandatory = $true)]
        [string]$containerName,
        
        [Parameter(Mandatory = $true)]
        [string]$storageAccount
    )

    Write-Host ("INFO: $(Get-Date): Starting to Archive")
    $compress = @{
        Path             = $destination
        CompressionLevel = "Fastest"
        DestinationPath  = $destination
    }
    Compress-Archive @compress

    Write-Host ("INFO: $(Get-Date): Sending to Blob storage")
    $uri = "https://$storageAccount.blob.core.windows.net/$containerName/$SASToken"