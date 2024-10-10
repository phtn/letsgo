#include <stdio.h>

struct MemoryStruct {
  char *memory;
  size_t size;
};

size_t WriteMem(void *contents, size_t size, size_t nmemb, void *userp);

int main(int argc, char *argv[]) {

  char s[3] = "─";
  char x = s * 4;

  printf("%s", s);

  return 0;
}
