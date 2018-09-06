#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LEN 1024
#define MAX_ARGS 64
#define DELIM " \t\n"

int get_line(char* line) {
    printf("=> ");
    if (fgets(line, MAX_LEN, stdin) == NULL)
        return 0;
    return strlen(line);
}

int parse_line(char* line, char** args) {
    int i = 0;

    if ((args[i++] = strtok(line, DELIM)) == NULL)
        return 0;    
    while ((args[i++] = strtok(NULL, DELIM)));

    return i-1;
}

void run_command(char** args) {
    for (int i = 0; args[i] != NULL; i++)
        printf("%s\n", args[i]);
}

int main(void) {
    char line[MAX_LEN];
    char* args[MAX_ARGS];
    
    while (get_line(line) != 0)
        if (parse_line(line, args) > 0)
            run_command(args);

    return 0;
}