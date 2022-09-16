%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
int n;
%}

%option noyywrap
%option yylineno

DIGIT [0-9]
DIGITS 		{DIGIT}+
HEXS [0-9a-f]


ALL_CHARS [ -!#-\[\]-~]
ESC_CHARS \\["\\bfnrt/]

UNCD \\u{HEXS}{HEXS}{HEXS}{HEXS}
CHAR {ALL_CHARS}|{ESC_CHARS}|{UNCD}

CHARS_A {CHAR}+
%%


\"last\"                return LAST;
\"active\"              return ACTIVE;
\"gameId\"              return GAMEID;
\"drawId\"              return DRAWID;
\"drawTime\"            return DRAWTIME;
\"status\"				      return STATUS;
\"drawBreak\"			      return DRAWBREAK;
\"visualDraw\"		      return VISUALDRAW;
\"pricePoints\"		      return PRICEPOINTS;
\"amount\"			        return AMOUNT;
\"winningNumbers\"		  return WINNINGNUMBERS;
\"list\"		          	return LIST;
\"bonus\"		          	return BONUS;
\"prizeCategories\"			 return PRIZECATEGORIES;
\"id\"			             return ID;
\"divident\"			       return DIVIDENT;
\"winners\"		         	 return WINNERS;
\"distributed\"		     	 return DISTRIBUTED;
\"jackpot\"		         	 return JACKPOT;
\"fixed\"		           	 return FIXED;
\"categoryType\"		  	 return CATEGORYTYPE;
\"gameType\"			       return GAMETYPE;
\"minimumDistributed\"	 return MINIMUMDISTRIBUTED;
\"wagerStatistics\"	     return WAGERSTATISTICS;
\"columns\"	             return COLUMNS;
\"wagers\"	             return WAGERS;
\"addOn\"	               return ADDON;
\"content\"	             return CONTENT;
\"totalPages\"	         return TOTALPAGES;
\"totalElements\"	       return TOTALELEMENTS;
\"numberOfElements\"	   return NUMBEROFELEMENTS;
\"sort\"	               return SORT;
\"first\"	               return FIRST;
\"size\"	               return SIZE;
\"number\"	             return NUMBER;
\"direction\"	           return DIRECTION;
\"property\"	           return PROPERTY;
\"ignoreCase\"	         return IGNORECASE;
\"nullHandling\"	       return NULLHANDLING;
\"descending\"	         return DESCENDING;
\"ascending\"	           return ASCENDING;
true                      return BOOLEAN;
false                     return BOOLEAN;





\{		{return '{';}

\}		{ return '}';}

\[		{return '[';}

\]		{ return ']';}

\"		{ return QUOT;}

,		{ return ',';}

:		{ return ':';}





\"{DIGITS}\"	{	return STR_NUMBER; }

\"{CHARS_A}\"		{ return STRING; }


{DIGITS}			{ return INT_NUMBER; }

{DIGITS}"."{DIGITS}			{ return FLOAT; }



\n  ;
[ ] 	;
[\t] 	;

