all:
	flex lexico.lex
	bison -d sintatico.y --debug -v 
	gcc -o sint sintatico.tab.c lex.yy.c  



run:
	./sint.exe 