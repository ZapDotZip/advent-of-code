#include <stdio.h>
#include <ctype.h>

int main() {
	short f = 0;
	short l = 0;
	char first = 0;
	char last = 1;
	char c = '\n';
	int total = 0;
	while((c = getchar()) != EOF) {
		if(c == '\n') {
			char a[] = {first, last, '\0'};
			total += atoi(a);
			f = 0;
			l = 1;
			first = '\0';
			last = '\0';
		}
		if(isdigit(c)) {
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
	char a[] = {first, last, '\0'};
	total += atoi(a);
	printf("total: %d\n", total);
}
