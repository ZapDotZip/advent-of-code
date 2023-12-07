#include <stdio.h>
#include <ctype.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/stat.h>
/*
Optimizations:
basic getchar() stdin: 0m2.254s
mmap: 0m0.329s

*/


int main(int argc, char* args[]) {
	// load file
	int fd = open(args[1], O_RDONLY);
	struct stat st;
	fstat(fd, &st);
	char *fptr = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	
	short f = 0;
	short l = 0;
	char first = 0;
	char last = 1;
	//char c = '\n';
	int total = 0;
	for(int i = 0; i < st.st_size; i++) {
		if(fptr[i] == '\n') {
			char a[] = {first, last, '\0'};
			total += atoi(a);
			f = 0;
			l = 1;
			first = '\0';
			last = '\0';
		}
		if(isdigit(fptr[i])) {
			if(!f) {
				first = fptr[i];
				f = 1;
				l = 0;
			}
			if(!l) {
				last = fptr[i];
				l = 0;
			}
		}
	}
	char a[] = {first, last, '\0'};
	total += atoi(a);
	close(fd);
	printf("total: %d\n", total);
}

// one, two, three, four, five, six, seven, eight, nine
// largest is 5 chars
// so need char word[5]
// to compare against wordlist


// store each word, compare against each
// vs
// compare each letter and have a 0/1
// aka inline compare?
