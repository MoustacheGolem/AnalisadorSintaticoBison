/* Analisador Lexico */
%{
  # include "sintatico.tab.h"
%}

letter  [a-zA-Z]
digit [0-9]
%%




[ \t\n\r]              { /* ignore */ }

[a-zA-Z][a-zA-Z0-9_]* { return ID; }

[0-9]+                 { return INT; }

\"(.*?)\"            { return STRING; }

\+|\-|\*|\/|\%|\=|!|\&|\| { return yytext[0]; }

\/\*.*?\*\/           { /* ignore */ }



%%
int yywrap() {
  return 1;
}