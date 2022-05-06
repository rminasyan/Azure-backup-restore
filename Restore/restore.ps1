#storage account information
Connect-AzAccount
$rg = ''
$storageaccount = ''
$containerName = ''

#local path where the files will be downloaded
$destination = ''

#destination cosmosDB
$cosmosbackup = ''
$cosmosDb = ''
$cosmosConnStr = ''

#destination pg server
$backuppg = ''
$pgserver = ''
$userName = ''

#download backup files
Write-Host ("INFO: $(Get-Date): Getting storage account context")

$key = (Get-AzStorageAccountKey -ResourceGroupName $rg -Name $storageaccount)[0].Value
$context = New-AzStorageContext -StorageAccountName $storageaccount -StorageAccountKey $key
Write-Host ("INFO: $(Get-Date): Downloading cosmos backup file from SA")
Get-AzStorageBlobContent -Container $containerName -blob "$cosmosbackup.zip" -Destination $destination -Context $context
Write-Host ("INFO: $(Get-Date): Downloading PG backup file from SA")
Get-AzStorageBlobContent -Container $containerName -blob "$backuppg.zip" -Destination $destination -Context $context
Write-Host ("INFO: $(Get-Date): Finished downloading files")
function RestoreCosmosDb
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$containerName,
    
        [Parameter(Mandatory=$true)]
        [string]$cosmosbackup,

        [Parameter(Mandatory=$true)]
        [string]$destination,

        [Parameter(Mandatory=$true)]
        [string]$cosmosDb,

        [Parameter(Mandatory=$true)]
        [string]$cosmosConnStr
    )

    Expand-Archive -LiteralPath "$destination\$cosmosbackup.zip" -DestinationPath "$destination\$cosmosbackup"
    Write-Host ("INFO: $(Get-Date): Finished downloading $cosmosbackup zip")
    $files = Get-ChildItem -Path "$destination\$cosmosbackup\"
    Write-Host ("INFO: $(Get-Date): Got $($files.count) files to restore")

    foreach($file in $files)
    {
        $fileName = [io.path]::GetFileNameWithoutExtension("$file")
        Write-Host("INFO: $(Get-Date): Importing $fileName items")
        dt.exe /s:JsonFile /s.Files:$file /t:DocumentDB /t.ConnectionString:"Database=$cosmosDb;$cosmosConnStr" /t.UpdateExisting /t.IdField:id /t.Collection:$fileName /t.PartitionKey:"/PartitionKey"
    }
    Write-Host ("INFO: $(Get-Date): Finished restoring CosmosDb data")
}

function RestorePGserver
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$backuppg,

        [Parameter(Mandatory=$true)]
        [string]$containerName,
    
        [Parameter(Mandatory=$true)]
        [string]$pgserver,

        [Parameter(Mandatory=$true)]
        [string]$destination,

        [Parameter(Mandatory=$true)]
        [string]$userName

    )

    Expand-Archive -LiteralPath "$destination\$backuppg.zip" -DestinationPath "$destination\$backuppg"
    Write-Host ("INFO: $(Get-Date): Finished downloading $backuppg zip") 
    $files = Get-ChildItem -Path "$destination\$backuppg\"
    Write-Host ("INFO: $(Get-Date): Got $($files.count) files to restore")