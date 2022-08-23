%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex();

void yyerror(const char *t);

extern char* yytext();

extern int yylineno;

extern FILE *yyin;
extern FILE *yyout;
%}


%locations

%union{
int ival;
float fval;
char *sval;
char *string;
double decimal;
}




%token LCURLY RCURLY LBRAC RBRAC COMMA COLON QUOTE
%token VTRUE VFALSE VNULL
%token <string> STRING;

%token <decimal> DECIMAL;
%token <int> INT;
%token <ival> NUMBER;
%token <sval> TEXT

%token LAST
%token GAMEID;
%token DRAWID
%token DRAWTIME
%token STATUS
%token DRAWBREAK
%token VISUALDRAW
%token PRICEPOINTS
%token AMOUNT
%token WINNINGNUMBERS
%token LIST
%token BONUS
%token PRIZECAT


%start json

%%

    json:
        | value
        ;

    value: object
         | STRING
         | DECIMAL
         | array
         | VTRUE
         | VFALSE
         | VNULL
         ;

    object: LCURLY RCURLY
          | LCURLY members RCURLY
          ;

    members: member
           | members COMMA member
           ;

    member: STRING COLON value
          ;

    array: LBRAC RBRAC
         | LBRAC values RBRAC
         ;

    values: value
          | values COMMA value
          ;






















%%

void yyerror(const char *t) {

	fprintf(stderr, "Error in line %d\n", yylineno);
}

/*Main*/
int main(int argc, char* argv[]) {
	FILE *a;
	++argv; --argc;
	if (argc>0)
	{
		a = fopen(argv[0], "r");
		if (!a) {
			printf("%s error \n",argv[1]);
			exit(1);
		}
		yyin = a;
	}
	else
		yyin = stdin;
		yyout = fopen("output", "w");
		yyparse();
	return 0;
}
