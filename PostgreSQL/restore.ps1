Connect-AzAccount

$destination = ''

$pgserver = ''
$userName = ''

function RestorePGserver {
    Param
    (

        [Parameter(Mandatory = $true)]
        [string]$pgserver,

        [Parameter(Mandatory = $true)]
        [string]$destination,

        [Parameter(Mandatory = $true)]
        [string]$userName

    )

    $files = Get-ChildItem -Path $destination

    foreach ($file in $files) {
        $fileName = [io.path]::GetFileNameWithoutExtension("$file")
        pg_restore.exe -v --no-owner --host=$pgserver --port=5432 --username=$userName --dbname=$fileName $file
    }