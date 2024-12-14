Param (
    [Parameter(Position=0, Mandatory=$true)][string]$FilePath,
    [int]$NumBytes = [int]::MaxValue,
    [int]$BytesPerLine = 24
)

function ShowHelp {
    Write-Host "USAGE:`n`nShowBytes.ps1 file.bin [-NumBytes 500] [-BytesPerLine 24]"
    Write-Host "Default: Show all bytes, with 24 bytes per line"
    exit 1
}

if (-not (Test-Path $FilePath)) {
    Write-Host "File $FilePath not found"
    exit 1
}

$Buffer = New-Object byte[] 0x4000
$BytesWritten = 0
$AsciiLine = ""
Write-Host $BytesPerLine

function WriteByte {
    param (
        [byte]$b
    )
    Write-Host -NoNewline ("{0:X2} " -f $b)
    if ($b -ge 33 -and $b -le 126) {
        $script:AsciiLine += [System.Text.Encoding]::ASCII.GetString([byte[]]@($b))
    } else {
        $script:AsciiLine += "."
    }
    if ($AsciiLine.Length -eq $BytesPerLine) {
        Write-Host "  $script:AsciiLine"
        $script:AsciiLine = ""
    }
}

try {
    $fs = [System.IO.File]::OpenRead($filePath)
    while (($count = $fs.Read($buffer, 0, $buffer.Length)) -gt 0) {
        for ($i = 0; $i -lt $count; $i++) {
            WriteByte $buffer[$i]
            if (++$bytesWritten -ge $numBytes) {
                break
            }
        }
        if ($bytesWritten -ge $numBytes) {
            break
        }
    }
    $fs.Close()

    # Last line
    if ($asciiLine.Length -gt 0) {
        $numMissingChars = $bytesPerLine - $asciiLine.Length
        Write-Host -NoNewline (" " * ($numMissingChars * 3) + "  ")
        Write-Host $asciiLine
    }
} catch {
    Write-Host $_.Exception.Message
    ShowHelp
}

Write-Host ""
Write-Host "DONE"
