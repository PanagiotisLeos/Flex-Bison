%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE *yyin;
int yylex();
void yyerror(const char *s);
extern char* yytext;
extern int yylineno;
extern FILE *yyin;
extern FILE *yyout;



%}

%token QUOT
%token STRING
%token STRING_PR
%token INT_NUMBER
%token FLOAT
%token BOOLEAN
%token TEXT_LEX
%token STR_NUMBER
%token LAST
%token ACTIVE
%token GAMEID
%token DRAWID
%token DRAWTIME
%token DRAWBREAK
%token STATUS
%token VISUALDRAW
%token PRICEPOINTS
%token AMOUNT
%token WINNINGNUMBERS
%token LIST
%token ID
%token BONUS
%token PRIZECATEGORIES
%token DIVIDENT
%token WINNERS
%token DISTRIBUTED
%token JACKPOT
%token FIXED
%token CATEGORYTYPE
%token GAMETYPE
%token MINIMUMDISTRIBUTED
%token WAGERSTATISTICS
%token WAGERS
%token COLUMNS
%token ADDON
%token CONTENT
%token TOTALPAGES
%token TOTALELEMENTS
%token LAST_R
%token NUMBEROFELEMENTS
%token SORT
%token FIRST
%token SIZE
%token NUMBER
%token DIRECTION
%token PROPERTY
%token IGNORECASE
%token NULLHANDLING
%token DESCENDING
%token ASCENDING




%%
json: '{' jsn '}' ;

jsn: commands | jsn ',' commands;

commands: last ',' active | range_resutls ;

last: LAST ':' '{' last_jsn '}' ;

last_jsn: last_parts | last_jsn ',' last_parts;

last_parts: gameId | drawId | drawTime | status | drawBreak | visualDraw | pricePoints
| amount | winningNumbers  | prizeCategories | wagerStatistics;

active: ACTIVE ':' '{' active_jsn '}' ;

active_jsn: active_parts | active_jsn ',' active_parts;

active_parts: gameId | drawId | drawTime | status | drawBreak | visualDraw | pricePoints
| amount | prizeCategories | wagerStatistics ;

gameId: GAMEID ':' INT_NUMBER ;

drawId: DRAWID ':' INT_NUMBER ;

drawTime: DRAWTIME ':' INT_NUMBER ;

status: STATUS ':' STRING | STATUS ':' ACTIVE ;

drawBreak: DRAWBREAK ':' INT_NUMBER ;

visualDraw: VISUALDRAW ':' INT_NUMBER ;

pricePoints: PRICEPOINTS ':' '{' amount '}' ;

amount: AMOUNT ':' FLOAT ;

winningNumbers: WINNINGNUMBERS ':' '{' list ',' bonus '}'

list: LIST ':' int_array ;

bonus: BONUS ':' int_array ;

int_array: '[' nums ']' ;

nums: INT_NUMBER | nums ',' INT_NUMBER;

wagerStatistics: WAGERSTATISTICS ':' '{' wager_members '}' ;

wager_members: columns ',' wagers ',' addOn ;

columns: COLUMNS ':' INT_NUMBER ;

wagers: WAGERS ':' INT_NUMBER ;

addOn: ADDON ':' addon_array ;

addon_array: '[' ']' ;


prizeCategories: PRIZECATEGORIES ':' prize_array ;

prize_array: '['  prize_objects  ']' | '[' ']';

prize_objects: '{' prize_jsn '}' | '{' prize_jsn '}' ',' prize_objects ;

prize_jsn: prize_parts | prize_jsn ',' prize_parts;

prize_parts: id | divident | winners | distributed | jackpot | fixed | categoryType | gameType | minimumDistributed ;

id: ID ':' INT_NUMBER ;

divident: DIVIDENT ':' FLOAT ;

winners: WINNERS ':' INT_NUMBER ;

distributed: DISTRIBUTED ':' FLOAT;

jackpot: JACKPOT ':' FLOAT ;

fixed: FIXED ':' FLOAT ;

categoryType: CATEGORYTYPE ':' INT_NUMBER ;

gameType: GAMETYPE ':' STRING ;

minimumDistributed: MINIMUMDISTRIBUTED ':' FLOAT;



range_resutls: content ','  totalPages ',' totalElements ',' last_r ',' numberOfElements ',' sort ',' first ',' size ',' number ;




content: CONTENT ':' '['  content_parts  ']' ;

content_parts: '{' last_jsn '}' |  content_parts ',' '{' last_jsn '}' ;

totalPages: TOTALPAGES ':' INT_NUMBER ;

totalElements: TOTALELEMENTS ':' INT_NUMBER ;

last_r: LAST ':' BOOLEAN;

numberOfElements : NUMBEROFELEMENTS ':' INT_NUMBER;

sort: SORT ':'  sort_array

sort_array: '[' '{' sort_parts '}' ']'

sort_parts: direction ',' property ',' ignoreCase ',' nullHandling ',' descending ',' ascending  ;

direction: DIRECTION ':' STRING ;

property: PROPERTY ':' STRING;

ignoreCase: IGNORECASE ':' BOOLEAN ;

nullHandling: NULLHANDLING ':' STRING ;

descending: DESCENDING ':' BOOLEAN ;

ascending: ASCENDING ':' BOOLEAN ;

first: FIRST ':' BOOLEAN ;

size: SIZE ':' INT_NUMBER ;

number: NUMBER ':' INT_NUMBER ;










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
