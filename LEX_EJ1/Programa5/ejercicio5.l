%{
#include <stdio.h>
#include <string.h>

void request_input();
%}

%option noyywrap

%%

[+-]?[0-9]+(\.[0-9]+)?[iI]? {
    if (strchr(yytext, 'i') != NULL || strchr(yytext, 'I') != NULL) {
        if (strpbrk(yytext, "+-") == NULL) {
            printf("Número Imaginario: %s\n", yytext);
        } else {
            printf("Número Complejo: %s\n", yytext);
        }
    } else {
        printf("Número Real: %s\n", yytext);
    }
    request_input();
}

[+-]?[0-9]+(\.[0-9]+)?°[0-9]+(\.[0-9]+)? {
    printf("Número Complejo en grados: %s\n", yytext);
    request_input();
}

[ \t]+  { }

\n      { }

.       {
    printf("Carácter no reconocido: %s\n", yytext);
    request_input();
}

%%

void request_input() {
    // Esta función ya no necesita hacer nada porque leeremos desde el archivo
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("No se puede abrir el archivo");
            return 1;
        }
        yyin = file;
    } else {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }

    yylex();
    return 0;
}
