%{
	#include <stdio.h>
%}

%%

[0-9]+(\.[0-9]+)? {printf("NUMERO %s\n", yytext); }

"+"  {printf("SUM\n"); }

"-"  {printf("SUB\n"); }

"*"  {printf("MUL\n"); }

"/"  {printf("DIV\n"); }

"|"  {printf("ABS\n"); }

"%"  {printf("MOD\n"); }

"("  {printf("CHAR: PARENTESIS\n"); }

")"  {printf("CHAR: PARENTESIS\n"); }
[ \t] { }

.    {printf("NO SE RECONOCE\n%s\n", yytext); }

%%

int main(){
	yylex();
	return 0;
}

int yywrap(){
	return 1;
}
