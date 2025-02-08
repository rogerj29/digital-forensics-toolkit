# Digital Forensics Toolkit - Automated Installer
# This script downloads, installs, and extracts all forensic tools.

# Set installation directory
$installPath = "C:\ForensicTools"

# Ensure the directory exists
If (!(Test-Path -Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force
}

Write-Host "Installing tools to: $installPath"
Start-Sleep -Seconds 2

# Function to Download and Install Tools
Function Install-Tool {
    param (
        [string]$toolName,
        [string]$url,
        [string]$installerPath,
        [string]$installCommand
    )

    If (Test-Path $installerPath) {
        Write-Host "$toolName is already downloaded. Skipping."
    } else {
        Write-Host "Downloading: $toolName..."
        try {
            Invoke-WebRequest -Uri $url -OutFile $installerPath -UseBasicParsing -ErrorAction Stop -Verbose
            Write-Host "Download successful: $installerPath"
        } catch {
            Write-Host "ERROR: Failed to download $toolName from $url"
            return
        }
    }

    If ($installCommand -ne "") {
        Write-Host "Installing $toolName..."
        try {
            Start-Process -FilePath $installerPath -ArgumentList $installCommand -Wait -NoNewWindow
            Write-Host "$toolName installed successfully!"
        } catch {
            Write-Host "ERROR: Installation failed for $toolName"
        }
    }
}

# Function to Download and Extract ZIP Files
Function Extract-Tool {
    param (
        [string]$toolName,
        [string]$url,
        [string]$zipPath,
        [string]$extractPath
    )

    If (Test-Path $zipPath) {
        Write-Host "$toolName is already downloaded. Skipping."
    } else {
        Write-Host "Downloading: $toolName..."
        try {
            Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing -ErrorAction Stop -Verbose
            Write-Host "Download successful: $zipPath"
            Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
            Write-Host "$toolName extracted successfully!"
        } catch {
            Write-Host "ERROR: Failed to download $toolName"
        }
    }
}

# List of tools with silent install
$installTools = @(
    @{Name="Wireshark"; URL="https://2.na.dl.wireshark.org/win64/Wireshark-4.4.3-x64.exe"; Installer="C:\ForensicTools\Wireshark.exe"; Command="/S"},
    @{Name="WinHex"; URL="https://www.x-ways.net/winhex.zip"; Installer="C:\ForensicTools\WinHex.exe"; Command="/silent"}
)

# List of tools that need extraction
$extractTools = @(
    @{Name="Network Miner"; URL="https://www.netresec.com/?download=NetworkMiner"; Zip="C:\ForensicTools\NetworkMiner.zip"; Extract="C:\ForensicTools\NetworkMiner"},
    @{Name="John the Ripper"; URL="https://www.openwall.com/john/k/john-1.9.0-jumbo-1-win64.zip"; Zip="C:\ForensicTools\john.zip"; Extract="C:\ForensicTools\john"},
    @{Name="Bulk Extractor"; URL="https://github.com/simsong/bulk_extractor/archive/refs/tags/v2.1.1.zip"; Zip="C:\ForensicTools\bulk_extractor.zip"; Extract="C:\ForensicTools\bulk_extractor"},
    @{Name="PhotoRec/TestDisk"; URL="https://www.cgsecurity.org/testdisk-7.2.win.zip"; Zip="C:\ForensicTools\testdisk.zip"; Extract="C:\ForensicTools\testdisk"},
    @{Name="Elasticsearch"; URL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.1-windows-x86_64.zip"; Zip="C:\ForensicTools\elasticsearch.zip"; Extract="C:\ForensicTools\elasticsearch"}
)

# Install Silent-Install Tools
foreach ($tool in $installTools) {
    Install-Tool -toolName $tool.Name -url $tool.URL -installerPath $tool.Installer -installCommand $tool.Command
}

# Extract Tools
foreach ($tool in $extractTools) {
    Extract-Tool -toolName $tool.Name -url $tool.URL -zipPath $tool.Zip -extractPath $tool.Extract
}

Write-Host "The following tools require manual download:"
Write-Host "   - FTK Imager → https://www.exterro.com/ftk-product-downloads"
Write-Host "   - Autopsy → https://www.autopsy.com/download/"
Write-Host "   - Volatility → https://github.com/volatilityfoundation/volatility3/releases"
Write-Host "   - Splunk → https://www.splunk.com/en_us/download.html"
Write-Host "   - GrayLog → https://www.graylog.org/download"

Write-Host "Installation complete! All tools are now installed or extracted in: $installPath"
Start-Sleep -Seconds 3
