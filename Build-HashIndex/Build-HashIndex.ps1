$outputFileName = "Files_" + (Get-Date -Format "yyyyMMddHHmmss") + ".txt"

$outputFilePath = Join-Path -Path (Get-Location) -ChildPath $outputFileName
New-Item -Path $outputFilePath -ItemType File -Force

Get-ChildItem -Path (Get-Location) -Recurse -File | ForEach-Object {
	Write-Host $_.FullName

    $filePath = $_.FullName
    $fileSize = $_.Length
    $fileHash = Get-FileHash -Path $filePath -Algorithm MD5

    # Write the file details to the output file
    "$filePath, $fileSize, $($fileHash.Hash)" | Out-File -FilePath $outputFilePath -Append
}

Write-Host "File details written to $outputFilePath"
