#ifndef HELPER_H
#define HELPER_H

#include <stdio.h>
#include <stdlib.h>

// Function to scan a directory for viruses
void scan_directory(const char *directory_path);

// Function to scan a file for viruses
void scan_file(const char *file_path);

// Function to remove a detected virus
int remove_virus(const char *virus_path);

// Function to log scan results
void log_scan_results(const char *log_path, const char *results);

// Function to initialize virus definitions
void initialize_virus_definitions(const char *definitions_path);

// Function to update virus definitions
void update_virus_definitions(const char *definitions_path);

#endif // HELPER_H
