# Sourced from GitHub CoPilot

param (
	[string]$Token
)

Write-Host $Token

$parts = $Token -split '\.'
if ($parts.Count -ne 3) {
	Write-Error "Invalid JWT format."
	return
}

$payload = $parts[1]

$payload = $payload -replace "-", "+" -replace "_", "/"

switch ($payload.Length % 4) {
	2 { $payload += '==' }
	3 { $payload += '=' }
}

$base64DecodedBytes = [Convert]::FromBase64String($payload)
$jsonPayload = [Text.Encoding]::UTF8.GetString($base64DecodedBytes)

$jwtObject = $jsonPayload | ConvertFrom-Json

return $jwtObject

# Example usage
# .\Decode-Jwt.ps1 -Token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvZSBCbG9nZ3MiLCJpYXQiOjE1MTYyMzkwMjJ9.XXXXX" | Format-List
