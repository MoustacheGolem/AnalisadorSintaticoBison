/* Analisador Lexico */
%{
  # include "sintatico.tab.h"
%}
%%




[ \t\n\r]              { /* ignore */ }

[a-zA-Z][a-zA-Z0-9_]* { return ID; }

[0-9]+                 { return INT; }

\"(.*?)\"            { return STRING; }

\+|\-|\*|\/|\%|\=|!|\&|\| { return yytext[0]; }


%%
int yywrap() {
  return 1;
}