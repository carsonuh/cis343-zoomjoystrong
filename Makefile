mac:
	bison -d *.y
	flex -ll *.lex
	clang *.c -o zjs -ll -lsdl2

linux:
	bison -d *.y
	flex *.lex
	clang *.c -o zjs -lfl -lSDL2 -lm

clean:
	rm *.yy.c *.tab.c *.tab.h zjs
