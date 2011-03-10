%{
//tokens.l]
//Sean Hogan, 2/25/11
//This takes ranking data obtained through mapleget.sh obtained
//from the maplestory ranking page. It should be written to some filename of your choice...
//And assumes a format of
//RANK_NO USERNAME SERVER CLASS
//LEVEL
//four more lines of stuff we don't care about.

//This ranking data-cleaner assumes this format.


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int count = 0;
int flag = 0;
int crapcount = 0;
%}
    
%option noyywrap
  
%x CLASS
%x CRAP
%x SERVER
%x LEVEL
%x REST

%%
    
<INITIAL>[a-zA-Z0-9]+ { 
    flag++; 
    printf("%s ",yytext);
    if (flag == 2) { BEGIN SERVER; }
    }
<INITIAL>\n {}
<INITIAL>\* {BEGIN CRAP;}
<INITIAL>. { }

<CRAP>\n {crapcount++; 
	   if (crapcount == 1) {crapcount = 0; BEGIN INITIAL;}  }

<CRAP>. {}

<SERVER>"El Nido"    {
        printf("ElNido ",yytext);
	BEGIN CLASS;
    }

<SERVER>[a-zA-Z]+ {
	printf("%s ",yytext);
	BEGIN CLASS;
}

<CLASS>[a-zA-Z] { putchar(yytext[0]); }
<CLASS>.	{ }
<CLASS>\n	{ BEGIN LEVEL; }

<LEVEL>[0-9]+[\n] {
        printf("%s",yytext);
        BEGIN REST;
    }

<REST>\n {
    if (count == 3) { flag = 0; count = 0; BEGIN INITIAL; }
    else { count++; }
}

<REST>. {}
    
%%
    
int main() {
    yylex();
    exit(0);
}
