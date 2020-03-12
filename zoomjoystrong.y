%{
	#include "zoomjoystrong.h"
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
	void chkPoint(int x, int y);
	void chkLine(int x, int y, int u, int v);
	void chkCircle(int x, int y, int r);
	void chkRect(int x, int y, int w, int h);
	void chkColor(int r, int g, int b);
%}

%error-verbose
%union {int i; float f;}

%start zjs

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

zjs: statement_list end
;

statement_list: statement  
	|	statement statement_list  
;

statement:	point
	|	line
       	|	circle
       	|	rectangle
       	|	set_color
;

point:		POINT INT INT END_STATEMENT	
     		{ chkPoint($2,$3); }
;

line:		LINE INT INT INT INT END_STATEMENT
    		{ chkLine($2, $3, $4, $5);}
;

circle:		CIRCLE INT INT INT END_STATEMENT
      		{ chkCircle($2, $3, $4); }
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
	 	{ chkRect($2, $3, $4, $5); } 
;

set_color:	SET_COLOR INT INT INT END_STATEMENT
	 	{ chkColor($2, $3, $4); }
;

end:		END
 		{ finish(); return 0;}
;
%%


int main(int argc, char** argv){
	setup();
	yyparse();
	return 0;
}

/********************************************
 Prints out an error and message describing
 what the error means.
*********************************************/
void yyerror(const char* msg) {
	fprintf(stderr, "Error: %s\n", msg);
}

/********************************************
 Checks the values for point before rendering
 onto the screen 
*********************************************/
void chkPoint(int x, int y){
	
	// if values are negative
	if(x < 0 || y < 0) {
		printf("Value must be positive.\n");
	}
	
	// if (x,y) are outside of window frame
	else if(x > WIDTH || y > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", x, y, WIDTH, HEIGHT);
	}

	// render on screen
	else {
		point(x,y);
	}
}

/********************************************
 Checks the values for line before rendering
 onto the screen
*********************************************/
void chkLine(int x, int y, int u, int v) {
	
	// if values are negative
	if(x < 0 || y < 0 || u < 0 || v < 0){
		printf("Value must be positive.\n");
	}

	// if first point (x,y) is outside of window frame
	else if(x > WIDTH || y > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", x, y, WIDTH, HEIGHT);
	}

	// if second point (u,v) is outside of window frame
	else if(u > WIDTH || v > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", u, v, WIDTH, HEIGHT);
	}
	
	// render on screen
	else{
		line(x,y,u,v);
	}
}

/********************************************
 Checks the values for circle before rendering
 onto the screen
*********************************************/
void chkCircle(int x, int y, int r) {
	
	// if values are negative
	if(x < 0 || y < 0 || r < 0){
		printf("Value must be positive.\n");
	}

	// if (x,y) are outside of window frame
	else if(x > WIDTH || y > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", x, y, WIDTH, HEIGHT);
	}

	// render on screen
	else {
		circle(x,y,r);
	}
}

/********************************************
 Checks the values for rectangle before rendering
 onto the screen
*********************************************/
void chkRect(int x, int y, int w, int h) {
	
	// if values are negative
	if(x < 0 || y < 0 || w < 0 || h < 0){
		printf("Value must be positive.\n");
	}

	// if (x,y) is outside of window frame
	else if(x > WIDTH || y > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", x, y, WIDTH, HEIGHT);
	}

	// if height or width is larger than window frame
	else if(w > WIDTH || h > HEIGHT) {
		printf("Value out of bounds. Given (%d,%d) must be within boundary (%d,%d)\n", w, h, WIDTH, HEIGHT);
	}

	// render on screen
	else {
		rectangle(x,y,w,h);
	}
}

/********************************************
 Check for valid RGB values 
*********************************************/
void chkColor(int r, int g, int b) {
	if(r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255){
		printf("RGB values must be between (0-255). Received: (%d,%d,%d)\n", r,g,b);
	}
	else {
		set_color(r,g,b);
	}
}

