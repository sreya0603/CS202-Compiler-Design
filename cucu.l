%{
#include <stdio.h>
#include <stdlib.h>
#include "cucu.tab.h"
void yyerror(char *);
FILE *yyoutl;
FILE *yyouty;
%}
%%
[ \n\t]+                     {}
"if"                         {fprintf(yyoutl,"IF: %s\n",yytext); return IF;}
"else"                       {fprintf(yyoutl,"ELSE: %s\n",yytext); return ELSE;}
"while"                      {fprintf(yyoutl,"WHILE: %s\n",yytext); return WHILE;}
"return"                     {fprintf(yyoutl,"RETURN: %s\n",yytext); return RETURN;}
"int"|"char \*"                    {fprintf(yyoutl,"TYPE: %s\n",yytext); return TYPE;}
\;                                 {fprintf(yyoutl,"SEMI: %s\n",yytext); return SEMI;}
[0-9]+                             {yylval.string=strdup(yytext); fprintf(yyoutl,"NUM: %s\n",yytext); return NUM;}
("=="|"!="|">"|"<"|">="|"<=")      {yylval.string=strdup(yytext);fprintf(yyoutl,"COMPARATOR OP: %s\n",yytext); return COMPARATOROP;}
[=]                        {fprintf(yyoutl,"ASSIGNOP: %s\n",yytext); return ASSIGN;}
[\+\-\*\/]                 {yylval.string=strdup(yytext);fprintf(yyoutl,"ARTHEMATIC OP: %s\n",yytext); return ARTHEMATICOP;}
\(                         {fprintf(yyoutl,"OPENBRACKET: %s\n",yytext);  return OPENBRACKET;}
\)                         {fprintf(yyoutl,"CLOSEBRACKET: %s\n",yytext); return CLOSEBRACKET;}
\{                         {fprintf(yyoutl,"OPENFLOWERBRACKET: %s\n",yytext); return OPENFLOWERBRACKET;}
\}                         {fprintf(yyoutl,"CLOSEFLOWERBRACKET: %s\n",yytext); return CLOSEFLOWERBRACKET;}
[A-Za-z][a-zA-Z0-9_]*      {yylval.string=strdup(yytext); fprintf(yyoutl,"ID: %s\n",yytext); return ID;}
\,                         {fprintf(yyoutl,"comma: %s\n",yytext); return COMMA;}
.
%%
int yywrap(void) {
return 1;
}
void yyerror(char *msg){
	fprintf(yyoutl,"error");
	fprintf(yyouty,"error");
	printf("error");
}
