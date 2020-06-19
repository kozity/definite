/* TODO implement sorting for list(), maybe */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define TERMS "/home/ty/git/definite/c/terms"
#define DEFS "/home/ty/git/definite/c/definitions"
#define TEMPTERMS "/home/ty/tempterms"
#define TEMPDEFS "/home/ty/tempdefs"

int delete(void);
int list(void);
int recall(void);
int record(void);

int delete(void) {
  FILE *terms = fopen(TERMS, "r");
  FILE *defs = fopen(DEFS, "r");
  if (terms == NULL || defs == NULL) {
    printf("1+ file(s) not found; exiting.\n");
    return -1;
  }

  char *request = NULL;
  size_t r_size = 0;
  do {
    printf("Input term: ");
    getline(&request, &r_size, stdin);
  } while (strcmp(request, "\n") == 0);

  char *term = NULL;
  size_t t_size = 0;
  short absent = 1;
  while (getline(&term, &t_size, terms) != -1) {
    if (strcmp(term, request) == 0)
      absent = 0;
  }
  if (absent) {
    printf("Term not found; exiting.\n");
    return -1;
  }
  /* else */
  fseek(terms, 0, SEEK_SET);
  FILE *newterms = fopen(TEMPTERMS, "w");
  FILE *newdefs = fopen(TEMPDEFS, "w");

  free(term);
  term = NULL;
  char *def = NULL;
  t_size = 0;
  size_t d_size = 0;
  while (getline(&term, &t_size, terms) != -1
      && getline(&def, &d_size, defs) != -1) {
    if (strcmp(term, request) == 0) {
      continue;
    } else {
      fputs(term, newterms);
      fputs(def, newdefs);
    }
  }
  fclose(terms);
  fclose(defs);
  fclose(newterms);
  fclose(newdefs);
  free(term);
  free(def);
  free(request);

  remove(TERMS);
  remove(DEFS);
  rename(TEMPTERMS, TERMS);
  rename(TEMPDEFS, DEFS);

  return 0;
}

int list(void) {
  FILE *terms = fopen(TERMS, "r");
  FILE *defs = fopen(DEFS, "r");
  if (terms == NULL || defs == NULL) {
    printf("1+ file(s) not found; exiting.\n");
    return -1;
  }

  char *term = NULL;
  char *def = NULL;
  size_t t_size = 0;
  size_t d_size = 0;

  while (getline(&term, &t_size, terms) != -1
     && getline(&def, &d_size, defs) != -1) {
    size_t t_len = strlen(term);
    term[t_len - 1] = ':';
    printf("%s\t%s", term, def);
  }

  fclose(terms);
  fclose(defs);
  free(term);
  free(def);
  return 0;
}

int recall(void) {
  FILE *terms = fopen(TERMS, "r");
  FILE *defs = fopen(DEFS, "r");
  if (terms == NULL || defs == NULL) {
    printf("1+ file(s) not found; exiting.\n");
    return -1;
  }

  char *request = NULL;
  size_t r_size = 0;
  printf("Enter term: ");
  getline(&request, &r_size, stdin);

  char *term = NULL;
  char *def = NULL;
  size_t t_size = 0;
  size_t d_size = 0;

  while (1) {
    if (getline(&term, &t_size, terms) == -1
     || getline(&def, &d_size, defs) == -1) {
      printf("Term not found; exiting.\n");
      return -1;
    }
    if (strcmp(term, request) == 0)
      break;
  }

  size_t t_len = strlen(term);
  term[t_len - 1] = ':';
  printf("%s\t%s", term, def);

  fclose(terms);
  fclose(defs);
  free(term);
  free(def);
  return 0;
}

int record(void) {
  FILE *terms = fopen(TERMS, "r");
  FILE *defs = fopen(DEFS, "r");
  if (terms == NULL || defs == NULL) {
    printf("1+ file(s) not found; exiting.");
    return -1;
  }

  char *u_term = NULL;
  size_t ut_size = 0;
  do {
    printf("Input term: ");
    getline(&u_term, &ut_size, stdin);
  } while (strcmp(u_term, "\n") == 0);
  
  char *term = NULL;
  char *def = NULL;
  size_t t_size = 0;
  size_t d_size = 0;
  while (getline(&term, &t_size, terms) != -1
      && getline(&def, &d_size, defs) != -1) {
    if (strcmp(term, u_term) == 0) {
      printf("Term defined as follows; exiting.\n");
      printf("%s", def);
      return -1;
    }
  }

  free(term);
  free(def);

  fclose(terms);
  fclose(defs);
  terms = fopen(TERMS, "a");
  defs = fopen(DEFS, "a");

  char *u_def = NULL;
  size_t ud_size = 0;
  do {
    printf("Input definition: ");
    getline(&u_def, &ud_size, stdin);
  } while (strcmp(u_def, "\n") == 0);

  fputs(u_term, terms);
  fputs(u_def, defs);

  fclose(terms);
  fclose(defs);
  free(u_term);
  free(u_def);
  return 0;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s [ delete | list | recall | record ]\n", argv[0]);
    return -1;
  }

  if (strcmp(argv[1], "list") == 0)
    return list();
  else if (strcmp(argv[1], "record") == 0)
    return record();
  else if (strcmp(argv[1], "recall") == 0)
    return recall();
  else if (strcmp(argv[1], "delete") == 0)
    return delete();
  else
    printf("Invalid argument.\n");
    return -1;
}
