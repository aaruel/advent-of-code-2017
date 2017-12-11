#include <stdio.h>

typedef struct {
    int length;
    int * d;
} List;

List create_list(int left, int right) {
    List t = {
        .length = (right + 1) - left,
        .d = malloc(((right + 1) - left) * sizeof(int))
    };
    
    for (int index = 0, i = left; i <= right; ++i) {
        t.d[index++] = i;
    }
    
    return t;
}

void print_list(List * l) {
    for (int i = 0; i < l->length; ++i) {
        printf("%x", l->d[i]);
    }
    printf("\n");
}

void delete_list(List * l) {
    free(l->d);
}

void circular_reverse(List * list, int left, int right) {
    if (right - left < 0) return;
    int length = list->length;
    int * data = list->d;
    int * copy = malloc(sizeof(int) * list->length);
    memcpy(copy, data, list->length * sizeof(int));
    int r = right;
    for (int i = left; i <= right; ++i) {
        data[i%length] = copy[r%length];
        r--;
    }
    free(copy);
}

void k_round(List * list, int * skip, int * position) {
    char otable[] = "165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153";
    char mtable[] = {17,31,73,47,23, 0};
    char *ltable = malloc((strlen(otable) + 5) * sizeof(char));
    strcat(ltable, otable);
    strcat(ltable, mtable);
    int ltable_length = (int)strlen(ltable);
    
    for (int i = 0; i < ltable_length; ++i) {
        int len = ltable[i];
        circular_reverse(list, *position, (*position + len) - 1);
        *position = *position + (len + *skip);
        (*skip)++;
    }
    
    free(ltable);
}

int xor_block(List * list, int block) {
    int xor = 0;
    int bindexl = block * 16;
    int bindexr = ((block + 1) * 16) - 1;
    for (int i = bindexl; i < bindexr; ++i) {
        xor ^= list->d[i];
    }
    return xor;
}

int main() {
    List list = create_list(0, 255);
    List result = {.d = malloc(sizeof(int) * 16), .length = 16};
    int skip = 0, position = 0;
    for (int i = 0; i < 64; ++i) {
        k_round(&list, &skip, &position);
    }
    for (int i = 0; i < 16; ++i) {
        result.d[i] = xor_block(&list, i);
    }
    print_list(&result);
    delete_list(&list);
    delete_list(&result);
    return 0;
}
