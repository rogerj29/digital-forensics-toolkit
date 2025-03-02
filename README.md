# digital-forensics-toolkit

## Overview
The digital-forensic-toolkit is a collection of open-source digital forensic tools used for disk imaging, memory analysis, network forensics, password cracking, and timeline reconstruction. This repository provides documentation and practical usage guidelines for each tool.

## Tools Included

### **1. Imaging & Disk Analysis**
- **FTK Imager** - Acquires forensic images and verifies integrity.
- **Autopsy** - Open-source forensic suite for file system analysis.
- **WinHex / HxD** - Hex editors for low-level disk analysis.

### **2. Memory Analysis**
- **Volatility** - Extracts and analyzes memory artifacts.

### **3. Network Forensics**
- **Wireshark** - Captures and analyzes network packets.
- **Network Miner** - Extracts metadata, files, and credentials from PCAP files.

### **4. Timeline Reconstruction**
- **Log2Timeline / Plaso** - Builds an event-based forensic timeline.

### **5. Password Cracking**
- **Hashcat** - GPU-based password cracking.
- **John the Ripper** - Brute-force and dictionary attack tool.

### **6. File Carving & Recovery**
- **PhotoRec** - Extracts lost digital media files.

### **7. Log Analysis & File Integrity**
- **Hayabusa** - Log analysis tools.
- **CertUtil / HashCalc** - File integrity verification tools.

## Repository Structure
```
Forensic-Toolkit/
│── README.md  (Project description)
│── docs/  (Tool documentation & usage guides)
│── InstallationScript/  (Toolkit Installation Script)

```

## Getting Started
### **Clone the Repository**
```sh
git clone https://github.com/YOUR-USERNAME/Forensic-Toolkit.git
cd Forensic-Toolkit
```
# Digital Forensics Toolkit Installer for Windows

## Overview

This script automatically downloads and installs a set of digital forensic tools and clones repositories into a single folder (`C:\Digital-Forensic-Toolkit`) on Windows. Some tools are installed silently, while others require manual download/installation. The script also clones repositories for selected tools.

## Prerequisites

Before running the script, ensure you have met the following prerequisites:

- **Operating System:** Windows (tested on Windows 10/11)
- **Administrator Rights:** Run the script from an elevated PowerShell prompt ("Run as Administrator").
- **PowerShell Execution Policy:**  
  If script execution is disabled, set your policy to `RemoteSigned` by running:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Internet Connection: A stable connection is required for downloading installers, ZIP files, and cloning repositories.
Git for Windows:
Install Git from https://git-scm.com/download/win if you wish to clone repositories for Log2Timeline/Plaso and John the Ripper.
Python (Optional):
If you want to install Volatility via pip, ensure Python is installed and added to your system's PATH.
Manual Installation Tools:
Some tools (FTK Imager, WinHex/HxD, Hashcat, HashCalc, and TestDisk/PhotoRec) require manual download/installation. The script will automatically open their download pages.
Tools Covered
The script handles the following tools:

Installer-Based Tools:

Wireshark (Network Forensics):
Downloads from the provided URL and installs silently.
Autopsy (Imaging & Disk Analysis):
Downloads an MSI and installs via msiexec in silent mode.
Volatility (Memory Analysis):
Installed via pip if Python is available.
Git-Cloned Tools:

Log2Timeline/Plaso (Timeline Reconstruction):
Cloned from GitHub.
John the Ripper (Password Cracking):
Cloned from GitHub.
Downloaded & Extracted Tools:

Hayabusa (Log Analysis & File Integrity):
Downloads and extracts from the provided ZIP URL.
NetworkMiner (Network Forensics):
Downloads and extracts from the provided URL.
Manual Download Tools:

FTK Imager
WinHex/HxD
Hashcat
HashCalc
TestDisk (PhotoRec)

Usage
1. Run PowerShell as Administrator.
2. Set the Execution Policy (if needed):

''' Set-ExecutionPolicy RemoteSigned -Scope CurrentUser '''

3. Execute the script:

''' .\Install-DFToolkit.ps1 '''

Script Workflow
Folder Setup:
The script creates a folder at C:\Digital-Forensic-Toolkit for all downloads, extractions, and repository clones.

Installer-Based Tools:

Wireshark is downloaded from the specified URL and installed silently.
Autopsy is downloaded as an MSI and installed using msiexec in silent mode.
Volatility:
The script checks for Python and installs Volatility via pip if available.

Git-Cloned Tools:
The script clones the repositories for Log2Timeline/Plaso and John the Ripper.

Downloaded & Extracted Tools:
The script downloads and extracts Hayabusa and NetworkMiner.

Manual Download Tools:
The script opens the download pages for FTK Imager, WinHex/HxD, Hashcat, HashCalc, and TestDisk (PhotoRec) in your default browser for manual installation.

Notes
## Operating System Compatibility
All tools in this toolkit are available for use on Windows. Some tools, such as CertUtil, are built into Windows, while others may require additional installations. Refer to each tool’s documentation in the /docs folder for detailed setup instructions.

### **Using the Tools**
Each tool's documentation can be found in the `/docs` folder, with installation steps and forensic workflows.

## Contribution
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch (`feature-tool-name`).
3. Commit changes and push.
4. Submit a pull request.

## License
This repository is open-source and available for educational forensic research purposes.
