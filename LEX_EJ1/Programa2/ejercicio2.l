%{
#include <stdio.h>
%}

%%
"hello"       { printf("hola "); }
"world"       { printf("mundo "); }
"cat"         { printf("gato "); }
"cats"        { printf("gatos "); }
"dog"         { printf("perro "); }
"dogs"        { printf("perros "); }
"house"       { printf("casa "); }
"houses"      { printf("casas "); }
"book"        { printf("libro "); }
"books"       { printf("libros "); }
"car"         { printf("carro "); }
"cars"        { printf("carros "); }
"good"        { printf("bueno "); }
"morning"     { printf("mañana "); }
.|\n          { printf("%s", yytext); } // Para manejar cualquier otro carácter o nueva línea
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
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
