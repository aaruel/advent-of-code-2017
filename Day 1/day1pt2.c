#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

typedef struct {
    unsigned int length;
    char * buffer;
} string;

unsigned int charToInt(char c) {
    assert(c >= '0' && c <= '9');
    return c - '0';
}

void halfListMatch(string list) {
    unsigned int acc = 0, length = list.length, half = length / 2;
    for (int i = 0; i < length; ++i) {
        char base = list.buffer[i];
        char comparator = list.buffer[(half + i) % length];
        if (base == comparator) {
            acc += charToInt(base);
        }
    }
    printf("%d\n", acc);
}

void callbackFileString(char * filepath, void (*success)(string)) {
    FILE * file = fopen(filepath, "r");
    fseek(file, 0, SEEK_END);
    long stringLength = ftell(file);
    char * buffer = malloc(stringLength+1);
    fseek(file, 0, SEEK_SET);
    fread(buffer, stringLength, 1, file);
    buffer[stringLength] = '\0';
    
    success((string){
        .length = stringLength, 
        .buffer = buffer
    });

    free(buffer);
}

void testCases() {
    const unsigned int num = 5;
    string tests[num] = {
        (string){.length = 4, .buffer = "1212"},
        (string){.length = 4, .buffer = "1221"},
        (string){.length = 6, .buffer = "123425"},
        (string){.length = 6, .buffer = "123123"},
        (string){.length = 8, .buffer = "12131415"}
    };
    for (int i = 0; i < num; ++i) {
        halfListMatch(tests[i]);
    }
}

int main(int argc, char ** argv) {
    if (argc == 2) {
        char * filepath = argv[1];
        if (!strcmp(filepath, "test")) {
            testCases();
            return 0;
        }
        callbackFileString(filepath, halfListMatch);
    }
    else {
        printf("Usage: day1pt2 [test | filepath]\n");
    }
}