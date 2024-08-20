%{

enum token_type {
    TOK_NUMBER = 258,
    TOK_ADD = 259,
    TOK_SUB = 260,
    TOK_MUL = 261,
    TOK_DIV = 262,
    TOK_ABS = 263,
    TOK_EOL = 264
};

int token_value;
%}

%%

"+" { return TOK_ADD; }
"-" { return TOK_SUB; }
"*" { return TOK_MUL; }
"/" { return TOK_DIV; }
"|" { return TOK_ABS; }
[0-9]+ {
    token_value = atoi(yytext);
    return TOK_NUMBER;
}
\n { return TOK_EOL; }
[ \t] { }
. {
    printf("Unknown character %c\n", *yytext);
    return -1;
}

%%

int main(int argc, char **argv)
{
    if(argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if(!file) {
            perror("Cannot open file");
            return 1;
        }
        yyin = file;
    }

    int token;
    while((token = yylex())) {
        if(token == 0) break;
        switch(token) {
            case TOK_NUMBER:
                printf("NUMBER = %d\n", token_value);
                break;
            case TOK_ADD:
                printf("ADD\n");
                break;
            case TOK_SUB:
                printf("SUB\n");
                break;
            case TOK_MUL:
                printf("MUL\n");
                break;
            case TOK_DIV:
                printf("DIV\n");
                break;
            case TOK_ABS:
                printf("ABS\n");
                break;
            case TOK_EOL:
                printf("EOL\n");
                break;
            case -1:
                printf("Error: Unknown character\n");
                break;
            default:
                printf("Unknown token: %d\n", token);
        }
    }

    return 0;
}
