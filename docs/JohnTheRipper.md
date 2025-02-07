# John the Ripper - Password Cracking Tool

## Overview
John the Ripper is an open-source password cracking tool designed for penetration testing and forensic analysis.

## Installation
Download John the Ripper from:
[Official John the Ripper Website](https://www.openwall.com/john/)

## Usage
1. Identify the hash type using:
   john --list=formats
2. Run a dictionary attack:
   john --wordlist=rockyou.txt --format=nt hashes.txt
3. Perform a brute-force attack:
   john --incremental=All hashes.txt
4. View cracked passwords:
   john --show hashes.txt

## Features
- Supports various password hash formats
- Customizable cracking rules
- Optimized for CPU-based attacks

## Screenshots
*(Insert relevant screenshots here)*
