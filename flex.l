
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap
%option yylineno

digit [0-9]
number {digit}+
float {number}+"."{number}
letter [a-zA-Z]
word {letter}+


%%
[ ] ;
[\t] ;
[\n] {return NEWLINE;};

{number} 	{ yylval = atoi(yytext); return INT; }
{float}			{ return FLOAT; }
{word}  {return TEXT;}
%%
