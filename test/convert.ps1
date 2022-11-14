$varCheminRepertoireScript = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$boucle = 0

$MonFolder = Get-ChildItem -Path $varCheminRepertoireScript -File | Where-Object {$_.Name -match 'xml$'}

foreach ($MyFile in $MonFolder)
{
    $boucle +=1
	Write-Host "$($MyFile.name) Convert..."
    [xml]$inputFile = Get-Content $MyFile.Name
    $inputFile.website.ChildNodes | Export-Csv "website$($boucle).csv" -NoTypeInformation -Delimiter:"," -Encoding:UTF8
}

Get-ChildItem -Recurse -Path *.csv  | Get-Content | Add-Content output.csv