# Step 1: Define servers
$servers = @(
    "10.0.0.59",
    "10.0.0.62",
    "10.0.0.63",
    "10.0.0.64",
    "10.0.0.65",
    "10.0.0.66",
    "10.0.254.8"
)

# Step 3: Define the route command
$routeCommand = 'route add 10.27.0.0 mask 255.255.0.0 10.0.0.1 -p'

# Step 4: Request credentials
$cred = Get-Credential -UserName "poznyakov" -Message "Enter password for admin"

# Step 5: Loop through servers and add route
foreach ($server in $servers) {
    Write-Host "Connecting to $server..."
    try {
        $result = Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
            param($cmd)
            cmd.exe /c $cmd
            "ExitCode=$LASTEXITCODE"
        } -ArgumentList $routeCommand -ErrorAction Stop

        Write-Host "$server $result"
    }
    catch {
        Write-Host "ERROR on $server $_"
    }
}

Write-Host "All done."