#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <windows.h> // For Sleep function

#define MAX_LINE_LENGTH 2048

char main_line[MAX_LINE_LENGTH] = "the quick brown fox jumped over the lazy dog";

void heading();
void metying();

int main() {
    heading();
    system("pause");
    return 0;
}

void heading() {
    char input[10];

    printf("\n############## Typing Test ##############\n");
    printf("%s\n", main_line);
    printf("You have to type this line above ^ and press Enter\n\n");
    printf("Would you start ? (y/n): ");

    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0; // Remove trailing newline character

    if (strcmp(input, "y") == 0) {
        for (int i = 3; i > 0; i--) {
            Sleep(1000); // Sleep for 1000 milliseconds (1 second)
        }
        metying();
    }
    else if (strcmp(input, "n") == 0) {
        exit(0);
    }
    else {
        printf("Invalid option. Please try again.\n");
        heading();
    }
}

void metying() {
    char type[MAX_LINE_LENGTH];
    time_t start_time, end_time;

    printf("\n%s\n", main_line);
    printf(">> ");

    start_time = time(NULL); // Save the current time

    fgets(type, sizeof(type), stdin);
    type[strcspn(type, "\n")] = 0; // Remove trailing newline character

    end_time = time(NULL); // Save the current time again after the code has run
    double elapsed_time = difftime(end_time, start_time); // Calculate the elapsed time

    if (strcmp(type, main_line) == 0) {
        printf("Elapsed time: %.2f seconds\n", elapsed_time);
    }
    else {
        printf("You typed the wrong words\n");
        exit(0);
    }
}