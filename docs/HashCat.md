# Hashcat - Password Cracking Tool

## Overview
Hashcat is an open-source, high-performance password recovery tool that utilizes CPU and GPU acceleration.

## Installation
Download Hashcat from:  
[Official Hashcat Website](https://hashcat.net/hashcat/)

## Usage
1. Identify the hash type.
2. Run Hashcat with the appropriate attack mode:
   ```sh
   hashcat -m 0 -a 3 hash.txt ?a?a?a?a?a?a

## Features
GPU-accelerated password cracking
Supports multiple attack modes
Works with numerous hash types