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
}

%token <sval>TEXT
%token <fval>FLOAT
%token <ival>INT

%type<ival> integer_expression
%type<fval> float_expression
%type<sval> string_expression
