%{
#include "mLisp_2.tab.h"
%}
letter   	[a-z]
digit 	    [0-9]
separator 	"\t"|"\n"|"\r"|" "

number 		 0|[1-9]{digit}*|\-[1-9]{digit}*
variable 	 {letter}({letter}|{digit}|'-')*
bool_val  	 #t|#f

%%
\/|\+|\-|\*|\>|\<|\=   { return(yytext[0]); }
"mod"		 { return(MOD); }
"and"		 { return(AND); }
"or"		 { return(OR); }
"not"		 { return(NOT); }
{bool_val}   { yylval.str = strdup(yytext);return(bool_val); }
{number}	 { yylval.number = atoi(yytext);return(num);}
"define"	 { return(DEFINE); }
"if"		 { return(IF); }
"fun" 		 { return(FUN); }
"print-bool" { return(PRINT_BOOL);}
"print-num"	 { return(PRINT_NUM); }
{variable}	 { yylval.str = strdup(yytext);return(var);}
\(		 	 { return(yytext[0]); }
\)		 	 { return(yytext[0]); } 
{separator}  {  }
.            { return(0); }

%%

YYSTYPE yylval;

