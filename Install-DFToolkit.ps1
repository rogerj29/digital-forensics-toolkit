<# 
    Digital Forensics Toolkit Installer for Windows

    This script will:
      • Create a folder at C:\Digital-Forensic-Toolkit to store downloaded installers, extracted files, and cloned repositories.
      • Automatically download and install tools that support silent installation:
          - Wireshark (Network Forensics)
          - Autopsy (Imaging & Disk Analysis)
      • Attempt to install Volatility (Memory Analysis) via pip if Python is available.
      • Use Git to clone repositories for:
          - Log2Timeline/Plaso (Timeline Reconstruction)
          - John the Ripper (Password Cracking)
      • Download and extract:
          - Hayabusa (Log Analysis & File Integrity)
          - NetworkMiner (Network Forensics)
      • For tools that cannot be automatically installed, open their download pages in your browser.
      • Note: FTK Imager, WinHex/HxD, Hashcat, HashCalc, and TestDisk (PhotoRec) require manual installation.
      
    Usage:
      1. Run PowerShell as Administrator.
      2. If necessary, adjust the execution policy:
         Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
      3. Execute the script:
         .\Install-DFToolkit.ps1

    Prerequisites:
      - Operating System: Windows (tested on Windows 10/11)
      - Administrator Rights: Run this script from an elevated PowerShell prompt ("Run as Administrator")
      - PowerShell Execution Policy: If necessary, set to RemoteSigned by running:
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
      - Internet Connection: Required for downloading installers, ZIP files, and cloning repositories
      - Git for Windows: Install from https://git-scm.com/download/win if you wish to clone repositories
      - Python (Optional): Required to install Volatility via pip; ensure Python is installed and in the PATH
      - Manual Installation: Some tools (e.g., FTK Imager, WinHex/HxD, Hashcat, HashCalc, TestDisk) must be installed manually. Their download pages will be opened automatically.

    Usage:
      1. Run PowerShell as Administrator.
      2. If needed, adjust the execution policy with:
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
      3. Execute the script:
            .\Install-DFToolkit.ps1
#>

# Ensure TLS 1.2 is enabled for secure downloads
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script must be run as an Administrator!"
    exit
}

# Define base directory for downloads, extractions, and clones
$baseDir = "C:\Digital-Forensic-Toolkit"
if (!(Test-Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir | Out-Null
}
Write-Output "Download and working folder: $baseDir"
Write-Output ""

# Function to download a file
function Download-File {
    param(
        [Parameter(Mandatory=$true)][string]$url,
        [Parameter(Mandatory=$true)][string]$destination
    )
    Write-Output "Downloading from $url ..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $destination
        Write-Output "Downloaded to $destination"
    } catch {
        Write-Error "Failed to download $url"
    }
}

# Check if Git is installed (for cloning repositories)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Warning "Git is not installed. Please install Git for Windows from https://git-scm.com/download/win."
    Write-Warning "Repositories for some tools will not be cloned until Git is available."
} else {
    Write-Output "Git is installed. Proceeding with repository cloning..."
}
Write-Output ""

##########################
# 1. Installer-Based Tools
##########################

# --- Wireshark (Network Forensics) ---
$wiresharkUrl = "https://2.na.dl.wireshark.org/win64/Wireshark-4.4.5-x64.exe"
$wiresharkInstaller = Join-Path $baseDir "WiresharkInstaller.exe"
Download-File -url $wiresharkUrl -destination $wiresharkInstaller

Write-Output "`nInstalling Wireshark..."
if (Test-Path $wiresharkInstaller) {
    try {
        # Many Wireshark installers support silent mode using /S.
        Start-Process -FilePath $wiresharkInstaller -ArgumentList "/S" -Wait -NoNewWindow
        Write-Output "Wireshark installation complete."
    } catch {
        Write-Error "Wireshark installation failed."
    }
} else {
    Write-Error "Wireshark installer was not downloaded. Skipping installation."
}
Write-Output ""

# --- Autopsy (Imaging & Disk Analysis) ---
$autopsyUrl = "https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.21.0/autopsy-4.21.0-64bit.msi"
$autopsyInstaller = Join-Path $baseDir "AutopsyInstaller.msi"
Download-File -url $autopsyUrl -destination $autopsyInstaller

Write-Output "`nInstalling Autopsy..."
if (Test-Path $autopsyInstaller) {
    try {
        # Use msiexec for MSI installations in silent mode.
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$autopsyInstaller`" /qn" -Wait -NoNewWindow
        Write-Output "Autopsy installation initiated in silent mode."
    } catch {
        Write-Error "Autopsy installation failed."
    }
} else {
    Write-Error "Autopsy installer was not downloaded. Skipping installation."
}
Write-Output ""

# --- Volatility (Memory Analysis) via pip ---
Write-Output "Checking for Python installation..."
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pythonCmd) {
    Write-Output "Python detected. Attempting to install Volatility via pip..."
    try {
        python -m pip install volatility -ErrorAction Stop
        Write-Output "Volatility installed successfully via pip."
    } catch {
        Write-Output "Failed to install Volatility via pip. Please install manually."
    }
} else {
    Write-Output "Python not found. Please install Python and then install Volatility manually."
}
Write-Output ""

##########################
# 2. Git-Cloned Tools
##########################

if (Get-Command git -ErrorAction SilentlyContinue) {
    # --- Log2Timeline / Plaso (Timeline Reconstruction) ---
    $plasoDir = Join-Path $baseDir "plaso"
    if (!(Test-Path $plasoDir)) {
        Write-Output "Cloning Log2Timeline/Plaso repository..."
        git clone https://github.com/log2timeline/plaso.git $plasoDir
        if ($LASTEXITCODE -eq 0) {
            Write-Output "Plaso repository cloned to $plasoDir"
        } else {
            Write-Error "Failed to clone Plaso repository."
        }
    } else {
        Write-Output "Plaso repository already exists at $plasoDir"
    }
    Write-Output ""

    # --- John the Ripper (Password Cracking) ---
    $johnDir = Join-Path $baseDir "john"
    if (!(Test-Path $johnDir)) {
        Write-Output "Cloning John the Ripper repository..."
        git clone https://github.com/openwall/john.git $johnDir
        if ($LASTEXITCODE -eq 0) {
            Write-Output "John the Ripper repository cloned to $johnDir"
        } else {
            Write-Error "Failed to clone John the Ripper repository."
        }
    } else {
        Write-Output "John the Ripper repository already exists at $johnDir"
    }
    Write-Output ""
} else {
    Write-Warning "Git is not installed; skipping cloning of repositories."
}

##########################
# 3. Download & Extract Tools
##########################

# --- Hayabusa (Log Analysis & File Integrity) ---
$hayabusaUrl = "https://github.com/Yamato-Security/hayabusa/releases/download/v3.1.0/hayabusa-3.1.0-win-x64.zip"
$hayabusaZip = Join-Path $baseDir "hayabusa-3.1.0-win-x64.zip"
$hayabusaDir = Join-Path $baseDir "Hayabusa"
Download-File -url $hayabusaUrl -destination $hayabusaZip

if (Test-Path $hayabusaZip) {
    try {
        if (!(Test-Path $hayabusaDir)) {
            New-Item -ItemType Directory -Path $hayabusaDir | Out-Null
        }
        Write-Output "`nExtracting Hayabusa..."
        Expand-Archive -Path $hayabusaZip -DestinationPath $hayabusaDir -Force
        Write-Output "Hayabusa extracted to $hayabusaDir"
    } catch {
        Write-Error "Failed to extract Hayabusa ZIP file."
    }
} else {
    Write-Error "Hayabusa ZIP file was not downloaded. Skipping extraction."
}
Write-Output ""

# --- NetworkMiner (Network Forensics) ---
$networkMinerUrl = "https://www.netresec.com/?download=NetworkMiner"
$networkMinerZip = Join-Path $baseDir "NetworkMiner.zip"
$networkMinerDir = Join-Path $baseDir "NetworkMiner"
Download-File -url $networkMinerUrl -destination $networkMinerZip

if (Test-Path $networkMinerZip) {
    try {
        if (!(Test-Path $networkMinerDir)) {
            New-Item -ItemType Directory -Path $networkMinerDir | Out-Null
        }
        Write-Output "`nExtracting NetworkMiner..."
        Expand-Archive -Path $networkMinerZip -DestinationPath $networkMinerDir -Force
        Write-Output "NetworkMiner extracted to $networkMinerDir"
    } catch {
        Write-Error "Failed to extract NetworkMiner ZIP file."
    }
} else {
    Write-Error "NetworkMiner ZIP file was not downloaded. Skipping extraction."
}
Write-Output ""

##########################
# 4. Manual Download Tools
##########################

# Define download pages for tools that require manual installation
$manualDownloads = @{
    "FTK Imager"         = "https://www.exterro.com/ftk-product-downloads/ftk-imager-4-7-3-81"
    "HxD"       	= "https://mh-nexus.de/en/hxd/"
    "WinHex"       	= "https://x-ways.net/winhex/"
    "Hashcat"            = "https://hashcat.net/hashcat/"
    "HashCalc"           = "https://hashcalc.en.softonic.com/download"
    "TestDisk (PhotoRec)" = "https://www.cgsecurity.org/wiki/TestDisk_Download"
}

Write-Output "Opening download pages for tools requiring manual installation..."
foreach ($tool in $manualDownloads.Keys) {
    $url = $manualDownloads[$tool]
    Write-Output "Opening $tool download page: $url"
    Start-Process $url
    Start-Sleep -Seconds 1  # slight delay between pages
}
Write-Output ""

Write-Output "Digital Forensics Toolkit installation script completed."
