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