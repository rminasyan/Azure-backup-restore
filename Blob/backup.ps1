$rootPath = ''
$storageAccount = ''
$SASToken = ''

$destination = New-Item -Path $rootPath -ItemType Directory -Name ''

$collections = @(

'add names'

)

foreach($collection in $collections)
    {
     azcopy copy "https://$storageAccount.blob.core.windows.net/$collection/$SASToken" $rootPath --recursive=true
    }