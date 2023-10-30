/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
#include <stdio.h> 
%}

%token INT
%token CHAR
%token VOID
%token AND
%token OR
%token MEI
%token MAI

%token INTCON
%token ID
%token CHARCON
%token STRINGCON

%token IF
%token ELSE
%token WHILE
%token FOR
%token RETURN
%token EXTERN 

%%

/* Regras definindo a GLC e acoes correspondentes */
/* neste nosso exemplo quase todas as acoes estao vazias */
input:    /* empty */	
        | input line	
;

line:     '\n'			{; }
        | prog '\n'  { printf ("Programa sintaticamente correto!\n"); }
;

prog:	 lista_cmds 	{;}
;

lista_cmds:	dcl	';'			{ ; }
			|dcl ';' lista_cmds	{;}
			|func				
			|func lista_cmds {;}				
;

dcl:	type var_decl {;}
		|maybe_extern type ID func_protos
		|maybe_extern VOID ID func_protos
;

func_protos: ID '(' parm_types ')'
			| ID '(' parm_types ')' ',' func_protos
;

maybe_extern: EXTERN
			| /* empty */

var_decl: ID '[' INTCON ']'
		 |ID '[' INTCON ']' ',' var_decl
		 |ID
		 |ID ',' var_decl
;

type: INT
	  |CHAR
;

parm_types: VOID
			|type ID 
			|type ID '['']'
			|type ID ',' parm_types
			|type ID '['']' ',' parm_types
;

func: type ID '('parm_types')' '{' sub_prog '}'
	| VOID ID '('parm_types')' '{' sub_prog '}'
;

sub_prog: dcl ';'
		 |dcl ';' sub_prog
		 |stmt
		 |stmt sub_prog
		 |	 /* empty */	
;

stmt:		IF '(' expr ')' stmt 
		|   IF '(' expr ')' stmt ELSE stmt 
		|   WHILE '('expr')' stmt				
		|	FOR '(' maybe_assg ';' maybe_expr ';' maybe_assg ')' stmt
		|	RETURN maybe_expr ';'
		|	assg ';'
		|	ID  ';'
		|  	ID '('expr_list')' ';'
		| 	'{'stmt_list'}'
		| 	';'
;

stmt_list: /* empty */
		|	stmt stmt_list
		|	stmt
;

assg:	 ID '=' expr
		|ID '['expr']' '=' expr
;
maybe_assg: assg
			|/* empty */

expr: 	'-' expr
		| '!' expr
		| expr binop expr
		| expr relop expr
		| expr logical_op expr
		| ID
		| ID '('expr_list')'
		| ID '['expr']'
		| '(' expr ')'
		| INTCON
		| CHARCON
		| STRINGCON
;
maybe_expr: expr
		|/* empty */	

expr_list: expr
		|	expr ',' expr_list
;

binop: 		'+'
		|	'-'
		|	'*'
		|	'/'
;

relop:		'=='
		|	'!='
		|   '<'
		|   '>'
		|	MEI
		|	MAI
;

logical_op:	AND
			|OR
;
%%	


int main () 
{
	#ifdef YYDEBUG
	yydebug = 0;
	#endif

	yyparse ();
}
int yyerror (s) /* Called by yyparse on error */
	char *s;
{
	printf ("Problema com a analise sintatica! %s \n", s);
}