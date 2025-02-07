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
- **Scalpel / Foremost** - Recovers deleted files.
- **PhotoRec** - Extracts lost digital media files.
- **Bulk Extractor** - Scans for hidden artifacts.

### **7. Log Analysis & File Integrity**
- **Splunk / ELK Stack / GrayLog** - Log analysis tools.
- **CertUtil / HashCalc** - File integrity verification tools.

## Repository Structure
```
Forensic-Toolkit/
│── README.md  (Project description)
│── docs/  (Tool documentation & usage guides)
│── tools/  (Configuration files & scripts)
│── images/  (Screenshots of forensic tools in action)
```

## Getting Started
### **Clone the Repository**
```sh
git clone https://github.com/YOUR-USERNAME/Forensic-Toolkit.git
cd Forensic-Toolkit
```

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
