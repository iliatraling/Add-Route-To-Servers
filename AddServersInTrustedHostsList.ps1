# Define the array of IP addresses to add
$serversToAdd = @(
    "10.0.0.59",
    "10.0.0.62",
    "10.0.0.63",
    "10.0.0.64",
    "10.0.0.65",
    "10.0.0.66",
    "10.0.254.8"
)

# Get the current TrustedHosts list
$current = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value

# Combine the current list with new IPs, remove duplicates and trim spaces
$newList = ($current -split ',') + $serversToAdd
$newList = $newList | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" } | Select-Object -Unique

# Convert the list back to a comma-separated string
$newValue = $newList -join ','

# Update the TrustedHosts list
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $newValue

# Verify the updated TrustedHosts list
Get-Item WSMan:\localhost\Client\TrustedHosts
