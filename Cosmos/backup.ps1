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