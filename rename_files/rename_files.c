#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <dirent.h>

#define FILENAME_LENGTH 8
#define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

void generate_random_filename(char *filename, int length) {
    const int charset_len = strlen(CHARSET);
    for (int i = 0; i < length; i++) {
        filename[i] = CHARSET[rand() % charset_len];
    }
    filename[length] = '\0'; // Null-terminate the string
}

void get_file_extension(const char *filename, char *extension) {
    const char *dot = strrchr(filename, '.');
    if (dot) {
        strcpy(extension, dot);  // Copy the extension (including the dot)
    } else {
        extension[0] = '\0';  // No extension
    }
}

int main() {
    DIR *dir;
    struct dirent *entry;
    char new_filename[FILENAME_LENGTH + 1];  // For 8 chars + null terminator
    char old_filename[256];  // Max path length
    char new_filepath[512];  // Max path length for new file
    char extension[16];  // To hold the file extension (if any)

    srand(time(NULL));  // Seed the random number generator

    // Open the current directory
    dir = opendir(".");
    if (dir == NULL) {
        perror("opendir");
        return 1;
    }

    // Loop through all the files in the directory
    while ((entry = readdir(dir)) != NULL) {
        // Skip the special directories "." and ".."
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        // Get the file extension
        get_file_extension(entry->d_name, extension);

        // Generate a random 8-character filename
        generate_random_filename(new_filename, FILENAME_LENGTH);

        // Construct the old and new file paths, keeping the extension
        snprintf(old_filename, sizeof(old_filename), "./%s", entry->d_name);
        snprintf(new_filepath, sizeof(new_filepath), "./%s%s", new_filename, extension);

        // Rename the file
        if (rename(old_filename, new_filepath) != 0) {
            perror("rename");
        } else {
            printf("Renamed '%s' to '%s'\n", old_filename, new_filepath);
        }
    }

    closedir(dir);  // Close the directory
    system("pause");
    return 0;
}
