$rootPath = ''
$storageAccount = ''
$SASToken = ''

$collections = @(

'add collection names here'

)

foreach($collection in $collections)
    {
     azcopy copy "$rootPath/$collection/*" "https://$storageAccount.blob.core.windows.net/$collection/$SASToken" --recursive=true
    }