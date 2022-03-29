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