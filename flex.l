
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap
%option yylineno

EXP ([Ee][-+]?[0-9]+)

%%

"{" { ECHO; return LCURLY; }
"}" { ECHO; return RCURLY; }
"[" { ECHO; return LBRAC; }
"]" { ECHO; return RBRAC; }
"," { ECHO; return COMMA; }
":" { ECHO; return COLON; }

""drawId"" return DRAWID;
"drawTime" return DRAWTIME;
"status" return STATUS;
"drawBreak" return DRAWBREAK;
"visualDraw" return VISUALDRAW;
"pricePoints" return PRICEPOINTS ;
"amount" return AMOUNT;
"winningNumbers" return WINNINGNUMBERS ;
"list" return LIST ;
"bonus" return BONUS ;
"prizeCategories" return PRIZECAT ;



"true" { ECHO; return VTRUE; }
"false" { ECHO; return VFALSE; }
"null" { ECHO; return VNULL; }
"gameId" return GAMEID;


%%

/* [ \t\r\n]+     { /* eat whitespace */ } */
\"[^"]*\"         { yylval.string = strdup(yytext); ECHO; return STRING; }
[a-zA-Z_]+ 				{yylval.sval = yytext; return TEXT;}
[1-9]+\.?[0-9]*{EXP}? { ECHO; yylval.decimal = atof(yytext); return DECIMAL; }
"-"[0-9][0-9]* 				{yylval.ival = atol(yytext); return NUMBER; }
[0-9]*.[0-9]*         {yylval.ival = atol(yytext); return FLOAT; }




%%
