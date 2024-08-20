%{
#include <stdio.h>

int num_lines = 0;
int num_words = 0;
int num_chars = 0;
int in_word = 0;  // Bandera para indicar si estamos dentro de una palabra
%}

%%
\n              { num_lines++; num_chars++; in_word = 0; }
[ \t\r\f\v]+    { in_word = 0; num_chars += yyleng; }
[^ \t\r\f\v\n]+ { if (!in_word) { num_words++; in_word = 1; } num_chars += yyleng; }
.               { num_chars++; in_word = 0; }
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Unable to open file");
            return 1;
        }
        yyin = file;
    }
    yylex();  // Inicia el análisis léxico

    printf("Lineas: %d\n", num_lines);
    printf("Palabras: %d\n", num_words);
    printf("Caracteres: %d\n", num_chars);

    return 0;
}

int yywrap() {
    return 1;  // Indica el final de la entrada
}
