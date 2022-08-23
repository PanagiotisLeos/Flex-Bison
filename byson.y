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
%token <ival> FLOAT;
%token <sval> TEXT

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
     | DECIMAL
     | array
     | VTRUE
     | VFALSE
     | VNULL
     | NUMBER
     | FLOAT
     ;

object: LCURLY RCURLY
      | LCURLY members RCURLY
      ;

members: member
       | members COMMA member
       ;


member: gameid | drawid | drawtime | status | drawbreak | visualdraw ;
      ;

gameid: GAMEID COLON INT
      | GAMEID COLON object;

drawid: DRAWID COLON INT
      | DRAWID COLON object
      ;

drawtime: DRAWTIME COLON INT
        | DRAWTIME COLON object
        ;

status: STATUS COLON STRING ;
      | STATUS COLON object

drawbreak: DRAWBREAK COLON INT | DRAWBREAK COLON object;

visualdraw: VISUALDRAW COLON INT | VISUALDRAW COLON object ;




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
