# Foremost - File Carving & Recovery Tool

## Overview
Foremost is an open-source forensic tool used for file recovery by scanning disk images.

## Installation
Install Foremost using:
sudo apt install foremost

## Usage
1. Run Foremost on a disk image:
   foremost -i disk_image.dd -o output_directory
2. Extract recovered files from the output directory.
3. View Foremost logs:
   cat output_directory/audit.txt

## Features
- Recovers files based on headers and footers
- Supports multiple file formats (JPEG, PDF, ZIP, etc.)
- Simple command-line interface

## Screenshots
*(Insert relevant screenshots here)*
