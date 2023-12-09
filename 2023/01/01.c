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




// one, two, three, four, five, six, seven, eight, nine
const char* one = "one";
const char* two = "two";
const char* three = "three";
const char* four = "four";
const char* five = "five";
const char* six = "six";
const char* seven = "seven";
const char* eight = "eight";
const char* nine = "nine";

char wordcheck(char c) {
	
}


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
	char first = '\0';
	char last = '\0';
	int total = 0;
	for(int i = 0; i < st.st_size; i++) {
		// end of line, convert the found numbers to an int
		if(fptr[i] == '\n') {
			char a[] = {first, last, '\0'};
			total += atoi(a);
			f = 0;
			l = 1;
			first = '\0';
			last = '\0';
		}
		// check if each char is a digit
		if(isdigit(fptr[i])) {
			// if the first num hasn't been found, set it as the current char
			if(!f) {
				first = fptr[i];
				f = 1;
				l = 0;
			}
			// if the last char hasn't been found, set it as the current char
			if(!l) {
				last = fptr[i];
				l = 0;
			}
		} else {
			// check the next 5? chars to see if they make up a number word
			char c = wordcheck(fptr[i]);
			// it returns the char of the number, or \0 if nan
			if(c != '\0') {
				if(!f) {
					first = c;
					f = 1;
					l = 0;
				}
				if(!l) {
					last = c;
					l = 0;
				}
			}
		}
	}
	char a[] = {first, last, '\0'};
	printf("FINAL STR: %c%c\n", first, last);
	total += atoi(a);
	close(fd);
	printf("total: %d\n", total);
}

