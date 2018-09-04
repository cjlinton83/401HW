#include <stdio.h>
#include <string.h>

#define MAX_LEN 1024

char* get_input(char* line) {
    printf("%s ", "=>");
    return fgets(line, MAX_LEN, stdin);
}

int main(void) {
    char line[MAX_LEN];

    while (get_input(line) != NULL){
    }
    
    return 0;
}
