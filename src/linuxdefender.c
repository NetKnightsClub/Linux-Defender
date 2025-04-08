#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>
#include <openssl/sha.h>

// Function to compute the SHA256 hash of a file.
void compute_sha256_hash(const char *filename, unsigned char *hash) {
    FILE *file = fopen(filename, "rb");
    if (!file) {
        perror("Error opening file");
        return;
    }

    SHA256_CTX sha256;
    SHA256_Init(&sha256);

    const int bufSize = 32768;
    unsigned char *buffer = malloc(bufSize);
    int bytesRead = 0;

    if (!buffer) {
        fclose(file);
        return;
    }

    while ((bytesRead = fread(buffer, 1, bufSize, file)) > 0) {
        SHA256_Update(&sha256, buffer, bytesRead);
    }

    SHA256_Final(hash, &sha256);

    fclose(file);
    free(buffer);
}

// Returns 1 if the file’s SHA256 hash matches any signature; else returns 0.
int scan_file(const char *filename, char **signatures, size_t signature_count) {
    unsigned char hash[SHA256_DIGEST_LENGTH];
    compute_sha256_hash(filename, hash);

    char hash_string[SHA256_DIGEST_LENGTH * 2 + 1] = {0};
    for (int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        sprintf(hash_string + (i * 2), "%02x", hash[i]);
    }

    for (size_t i = 0; i < signature_count; i++) {
        if (strcmp(hash_string, signatures[i]) == 0) {
            return 1; // Signature match found.
        }
    }

    return 0; // No matching signature.
}

// Placeholder: Fetch malware signatures from a user‐provided API endpoint.
// The API key and the API URL are passed in as parameters.
void fetch_signatures(const char *api_url, const char *api_key) {
    // You need to implement this function to use curl to query your API.
    // For example, add the API key as a header or a query parameter, etc.
    // This function should download the signature database.
    printf("Fetching signatures from %s with API key %s...\n", api_url, api_key);
    // TODO: Implement actual fetching code.
}

// Placeholder: Load malware signatures from a local file (or data store).
// Returns an array of strings; update signature_count to the number of signatures.
char **load_signatures(size_t *signature_count) {
    // You need to implement this function to load the downloaded signatures into memory.
    // For now, return a dummy array for demonstration.
    *signature_count = 2;
    char **signatures = malloc(*signature_count * sizeof(char *));
    signatures[0] = strdup("dummy_signature_1");
    signatures[1] = strdup("dummy_signature_2");
    return signatures;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file_to_scan>\n", argv[0]);
        return 1;
    }

    // Get the malware API URL and API key from environment variables.
    const char *api_url = getenv("MALWARE_API_URL");
    const char *api_key = getenv("MALWARE_API_KEY");

    if (!api_url || !api_key) {
        fprintf(stderr, "Error: Please set both MALWARE_API_URL and MALWARE_API_KEY environment variables.\n");
        return 1;
    }

    // Fetch the latest signatures from the provided API.
    fetch_signatures(api_url, api_key);

    // Load the signatures into memory.
    size_t signature_count;
    char **signatures = load_signatures(&signature_count);

    // Scan the provided file.
    if (scan_file(argv[1], signatures, signature_count)) {
        printf("Alert: File %s matched a known signature!\n", argv[1]);
    } else {
        printf("File %s appears to be clean.\n", argv[1]);
    }

    // Clean up allocated memory.
    for (size_t i = 0; i < signature_count; i++) {
        free(signatures[i]);
    }
    free(signatures);

    return 0;
}
