
CFLAGS = -std=c99
LEX = flex

tokens: tokens.o

tokens.c: tokens.l
	flex -o tokens.c tokens.l

clean:
	rm -f tokens.o tokens.c tokens



