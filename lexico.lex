/* Analisador Lexico */
%{
  # include "sintatico.tab.h"
  
%}

letter  [a-zA-Z]
digit [0-9]
%%

int                   {return INT;}
char                  {return CHAR;}
void                  {return VOID;}
if                   {return IF;}
else                 {return ELSE;}
while                {return WHILE;}
for                  {return FOR;}
return               {return RETURN;}
extern                {return EXTERN;}

&&|and                {return AND;}
\|\||or               {return OR;}
\<=                   {return MEI;}
\>=                   {return MAI;}

[0-9]+			          {return INTCON;}
[a-zA-Z][a-zA-Z0-9]*	{return ID;}
'[a-zA-Z]'|'\n' |'\0' { return CHARCON; }
\"(.*?)\"             { return STRINGCON; }



[ \t]+			{;}
.|\n				{return yytext[0];}

\/\*.*?\*\/           { /* ignore comments*/ }

%%

int yywrap() {
  return 1;
}