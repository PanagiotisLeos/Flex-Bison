%{
#include “myparser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

%%

underscore "_"
digit [0-9]
letter [a-zA-Z]
chartype "CHAR"
inttype "INTEGER"
userdatatype "Node"
comparative ">"|"<"|"=="|"!="
char .
datatype {chartype}|{inttype}

%%
