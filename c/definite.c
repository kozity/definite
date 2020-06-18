#include <stdlib.h>
#include <stdio.h>

#define TERMS "/home/ty/git/definite/c/terms"
#define DEFS "/home/ty/git/definite/c/definitions"

int recall(void);
int record(void);
int remove(void);

int recall(void) {
  FILE *terms = fopen(TERMS, "r");
  FILE *defs = fopen(DEFS, "r");
  if (terms == NULL || defs == NULL) {
    printf("1+ file(s) not found; exiting.");
    return -1;
  }

  fclose(terms);
  fclose(defs);
}

int record(void) {
  /*TODO*/
}

int remove(void) {
  /*TODO*/
}

int main(int argc, char *argv[]) {
  
  if (argc != 1) {
    printf("Usage: %s [ recall | record | remove ]", argv[0]);
    return -1;
  }

  switch (argv[1]) {
    case "record":
    case "i":
      record();
      break;
    case "recall":
    case "o":
      recall();
      break;
    case "remove":
    case "x":
      remove();
      break;
    default:
      printf("Invalid argument.");
      return -1;
  }

}
