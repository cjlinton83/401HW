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

void exec_command(char** args) {
    char* command = args[0];
    char* directory = args[1];
    char ls[MAX_LEN];

    strcat(ls, "ls -al ");
    if (directory != NULL)
        strcat(ls, directory);

    if (strcmp(command, "myquit") == 0)
        exit(0);
    if (strcmp(command, "myclear") == 0)
        system("clear");
    if (strcmp(command, "mydir") == 0) {
        printf("%s\n", ls);
        system(ls);
    }
}

int main(void) {
    char line[MAX_LEN];
    char* args[MAX_ARGS];
    
    while (get_line(line) != 0)
        if (parse_line(line, args) > 0)
            exec_command(args);

    return 0;
}