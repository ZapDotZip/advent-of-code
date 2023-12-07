#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
/*
Optimizations:
# stdin getchar() implementation
total: 112084000
user	0m2.250s
# stdin getchar() O3 implementation
total: 112084000
user	0m2.123s
# mmap implementation
total: 112084000
user	0m0.339s
# mmap O3 implementation
total: 112084000
user	0m0.175s
*/


int main(int argc, char *argv[]) {
	// load file
	if(argc != 2) { exit(0); }
	int fd = open(argv[1], O_RDONLY);
	if(fd == -1) { exit(1); }
	struct stat st;
	fstat(fd, &st);
	char *fptr = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	if (fptr == MAP_FAILED) { exit(2); }
	
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
