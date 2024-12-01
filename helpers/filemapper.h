#ifndef FILEMAPPER_H
#define FILEMAPPER_H

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

struct mmfile {
	char* p;
	off_t size;
};

// Memory-maps the first argument as a text file.
struct mmfile loadfile(int argc, char *argv[]) {
	if(argc != 2) { exit(0); }
	int fd = open(argv[1], O_RDONLY);
	if(fd == -1) { exit(1); }
	struct stat st;
	fstat(fd, &st);
	char *fptr = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	if (fptr == MAP_FAILED) { exit(2); }
	struct mmfile ret = {fptr, st.st_size};
	return ret;
}

// Memory-maps the provided path.
struct mmfile loadpath(char *path) {
	int fd = open(path, O_RDONLY);
	if(fd == -1) { exit(1); }
	struct stat st;
	fstat(fd, &st);
	char *fptr = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	if (fptr == MAP_FAILED) { exit(2); }
	struct mmfile ret = {fptr, st.st_size};
	return ret;
}
#endif // FILEMAPPER_H
