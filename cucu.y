%{
#include <stdio.h>
#include <stdlib.h>
FILE *yyouty;
FILE *yyoutl;
FILE *yyin;
extern int yylex();
void yyerror(char *);
%}
%union{
	int number;
	char * string;
}

%token IF ELSE WHILE RETURN TYPE SEMI <string>NUM <string>COMPARATOROP ASSIGN <string>ARTHEMATICOP OPENBRACKET CLOSEBRACKET OPENFLOWERBRACKET CLOSEFLOWERBRACKET DOUBLEQUOTE <string>ID COMMA
%%
s:variabledecl
 | functiondecl {fprintf(yyouty,"functiondelecration:\n");} 
 | functiondef {fprintf(yyouty,"functiondefinition:\n"); }
 ; 
variabledecl:TYPE ID SEMI {fprintf(yyouty,"ID:%s\t ",$2);}
            ;
functiondecl:  TYPE ID OPENBRACKET functionarg CLOSEBRACKET SEMI {fprintf(yyouty,"ID:%s\t ",$2);}
            ;
functiondef:TYPE ID OPENBRACKET functionarg CLOSEBRACKET functionbody {fprintf(yyouty,"functionbody:\n"); } 
           | TYPE ID OPENBRACKET CLOSEBRACKET functionbody {fprintf(yyouty,"ID:%s\t ",$2);}
           ;
functionarg: TYPE ID COMMA functionarg {fprintf(yyouty,"ID:%s\t ",$2);}
           |TYPE ID {fprintf(yyouty,"ID- %s\t ",$2); }
           |{fprintf(yyouty,"functionarg"); }
           ;
functionbody:OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET
            ;
statements : statement SEMI statements {fprintf(yyouty,"\n");}
           |{fprintf(yyouty,"\n");} ;
statement: OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET
                |TYPE ID {fprintf(yyouty,"ID:%s\t ",$2);} 
                |TYPE ID ASSIGN expression {fprintf(yyouty,"ID:%s\t = ",$2);}
                | expression   
                | IF OPENBRACKET compexpression CLOSEBRACKET OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET ELSE  OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET {fprintf(yyouty,"if  else");}
                | IF OPENBRACKET compexpression CLOSEBRACKET OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET {fprintf(yyouty,"if" );}
                | WHILE OPENBRACKET compexpression CLOSEBRACKET OPENFLOWERBRACKET statements CLOSEFLOWERBRACKET {fprintf(yyouty," WHILE");}
                | RETURN expression {fprintf(yyouty,"return"); }
                |{fprintf(yyouty,"\n");}
                ;
compexpression: expression COMPARATOROP expression {fprintf(yyouty,"%s\t ",$2);}
               ;
expression:
          |OPENBRACKET expression CLOSEBRACKET 
          |assignexpression
          |arthemeticexpression
          |compexpression
          |NUM {fprintf(yyouty,"NUM: %s\t",$1); }
          |ID  {fprintf(yyouty,"ID: %s\t",$1); }
          ;
assignexpression:ID ASSIGN  expression {fprintf(yyouty,"ID:%s\t =",$2);}
                ;
arthemeticexpression:expression ARTHEMATICOP expression {fprintf(yyouty,"%s\t ",$2);}
                    ;
%%
int main(int argc, char *argv[]) {
    yyouty =fopen("parser.txt", "w");
    yyoutl =fopen("lexer.txt", "w");
    yyin =fopen(argv[1], "r");
    yyparse();
    fclose(yyouty);
    fclose(yyoutl);
    fclose(yyin);
}