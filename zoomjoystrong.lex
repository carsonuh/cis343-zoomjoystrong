%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%%

<<EOF>>		{ return END; }
(end|End)	{ return END; }
;		{ return END_STATEMENT; }
(point)		{ return POINT;}
(line)		{ return LINE;}
(circle)	{ return CIRCLE;}
(rectangle)	{ return RECTANGLE;}
(set_color)	{ return SET_COLOR;}
[0-9]+		{ yylval.i = atoi(yytext); return INT; }
[0-9]*\.?[0-9]*	{ yylval.f = atof(yytext); return FLOAT;}
[ \t\s\n\r]	;
.		printf("Not valid '%s'\n", yytext); 

%%
