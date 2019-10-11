%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *message);
int result = 0;
char* t = "#t";
char* f = "#f";

int terror=0;
int first=0;
%}
%union {
    int number;
    char* str;
    struct operate{
        int n;
        char* b;
        char* nv;
        struct variables{
            char* v;
            int vval;
            char *vb;
        }varl[50];
        int vsize;
    }op;
}

%{
//+ 1 - 2 * 3 / 4 % 5 > 6 < 7 = 8 && 9 || 10 ! 0
struct operate add(struct operate n1,struct operate n2){
   // if(terror!=1){
    //if(n1.nv==NULL&&n2.nv==NULL){
        if(n1.b!=NULL||n2.b!=NULL){
            terror=1;
        }
        else{
            n1.n=n1.n+n2.n;
            return n1;
        }
   // }
   /* else if(n1.nv!=NULL&&n2.nv==NULL){
        int i,temp;
        for(i=0 ; i < n1.vsize ; i++){
            if(strcmp(n1.varl[vsize].v,n1,nv)==0){
                temp=vsize;
                break;
            }
        }
        if(n1.varl[vsize].vb!=NULL||n2.b!=NULL){
            terror=1;
        }
        else{
            n1.varl[vsize].=n1.n+n2.n;
            return n1;
        }

    }*/
}
struct operate sub(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        n1.n=n1.n-n2.n;
        return n1;
    }
}
struct operate mult(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        n1.n=n1.n*n2.n;
        return n1;
    }
}
struct operate divid(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        n1.n=n1.n/n2.n;
        return n1;
    }
}
struct operate modu(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        n1.n=n1.n%n2.n;
        return n1;
    }
}
struct operate great(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        if(n1.n>n2.n)
            n1.b="#t";
        else
            n1.b="#f";
       // n1.n=-1;
        return n1;
    }
}
struct operate small(struct operate n1,struct operate n2){
    if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }
    else{
        if(n1.n<n2.n)
            n1.b="#t";
        else
            n1.b="#f";
       // n1.n=-1;
        return n1;
    }
}
struct operate equ(struct operate n1,struct operate n2){
   /* if(n1.b!=NULL||n2.b!=NULL){
        terror=1;
    }*/
    //else{
        if(n1.n==n2.n)
            n1.b="#t";
        else
            n1.b="#f";
       // n1.n=-1;
        return n1;
    //}
}
struct operate and_(struct operate n1,struct operate n2){
    if(n1.b!=NULL&&n2.b!=NULL){
        if(strcmp(n1.b,t)==0&&strcmp(n2.b,t)==0){
            n1.b="#t";}
        else{
            n1.b="#f";
          //  n1.n=-1;
        }
        return n1;
    }
    else{
        terror=1;
    }
}

struct operate or_(struct operate n1,struct operate n2){
    if(n1.b!=NULL&&n2.b!=NULL){
        if(strcmp(n1.b,f)==0&&strcmp(n2.b,f)==0){
            n1.b="#f";}
        else{
            n1.b="#t";
           // n1.n=-1;
        }
        return n1;
    }
    else{
        terror=1;
    }
}

struct operate not_(struct operate n1){
    if(n1.b!=NULL){
        if(strcmp(n1.b,f)==0){
            n1.b="#t";
        }
        else{
            n1.b="#f";
           // n1.n=-1;
        }
    return n1;
    }
    else{
        terror=1;
    }
}

struct operate new_num(struct operate n1,int num_){
    n1.n=num_;
    return n1;
}

struct operate new_bool(struct operate n1,char* bool_){
    n1.b=bool_;
//printf("bool= %s\n",n1.b);
    return n1;
}

struct operate new_var(struct operate n1,char* var_){
    if(first==1){
        n1.vsize=0;
        n1.nv=var_;
        n1.varl[n1.vsize].v=var_;  
        n1.vsize=n1.vsize+1;      
    }
    else{
        int i;
        int find=0;
        for(i=0 ; i < n1.vsize ; i++ ){
            if((n1.varl[n1.vsize].v,var_)==0){
                printf("Redefining Error\n");
                find=1;
            }
        }
        if(find==0){
            n1.nv=var_;
            n1.varl[n1.vsize].v=var_;  
            n1.vsize=n1.vsize+1; 
        }
    }
terror=1;
    return n1;
}

struct operate new_var_val(struct operate n1, struct operate n2){
    if(n2.b!=NULL){
        n1.varl[n1.vsize-1].vb=n2.b;
    }
    else{
        n1.varl[n1.vsize-1].vval=n2.n;
    }
terror=1;
    return n1;
}

struct operate if_(struct operate n1,struct operate n2,struct operate n3){
    //if(terror!=1){
        if(strcmp(n1.b,t)==0||strcmp(n1.b,f)==0){
            if(strcmp(n1.b,t)==0){
                return n2;
            }
            else
                return n3; 
            }
        else{
            terror=1;
            
        }
   // }
}

struct operate show(struct operate n1){
    
    printf("n= %d\n",n1.n);
    printf("b= %s\n",n1.b);
    printf("----------------------\n"); 
}

%}


%token <number> num
%token <str> var bool_val
%token AND OR NOT
%token MOD
%token DEFINE IF FUN
%token PRINT_BOOL PRINT_NUM
%type <op> stmt exp def_stmt print_stmt 
%type <op> resursive_add resursive_mult resursive_and resursive_or resursive_equ
%type <op> num_op logical_op
%type <op> plus minus divide multiply modulus
%type <op> greater smaller equal
%type <op> and_op or_op not_op
%type <op> param variable variable_closure
%type <op> fun_ids fun_body fun_call fun_exp fun_name 
%type <op> if_exp test_exp then_exp else_exp 

%left AND OR
%left NOT '='
%left '<' '>'
%left '+' '-'
%left '*' '/' MOD
%left '(' ')'

%%
line: stmt line       {;}
    | stmt            {terror=0;}
    ;

stmt: exp             {if(terror==1){printf("error\n");}}
    | def_stmt        {if(terror==1){printf("error\n");};}
    | print_stmt      {;}
    ;

print_stmt: '(' PRINT_NUM exp ')'  {//printf("$3= %s\n",$3.b);
    if(terror==1){/*printf("Type Error\n");*/}
    else if($3.b!=NULL){
        if(strcmp($3.b,t)==0||strcmp($3.b,f)==0){
            printf("error\n");
        }
    }
    else printf("%d\n",$3.n);
                                   }
          | '(' PRINT_BOOL exp ')' {
    if(terror==1){/*printf("Type Error\n");*/}
    else if($3.b==NULL){printf("error\n");}
    else{
       /* if($3.n==-1){
            printf("Type Error\n");
        }*/
        //else 
            printf("%s\n",$3.b);
    }
                                   }
          ;

exp: bool_val   { $$=new_bool($$,$1); }
   | num        { $$=new_num($$,$1); }
   | variable   { $$=$1; }
   | num_op     { $$ = $1; }
   | logical_op { $$ = $1; }
   | fun_exp    { terror=1;$$ = $1; }
   | fun_call   { terror=1;$$ = $1; }
   | if_exp     { /*printf("exp : if_exp\n");*/$$ = $1;/*show($$);*/ }
;

num_op: plus     { /*printf("num_op : plus\n");*/$$ = $1;/*show($$);*/ }
      | minus    { /*printf("num_op : minus\n");*/$$ = $1;/*show($$);*/ }
      | multiply { /*printf("num_op : multiply\n");*/$$ = $1;/*show($$);*/ }
      | divide   { /*printf("num_op : divide\n");*/$$ = $1;/*show($$);*/ }
      | modulus  { /*printf("num_op : modulus\n");*/$$ = $1;/*show($$);*/ }
      | greater  { /*printf("num_op : greater\n");*/$$ = $1;/*show($$);*/ }
      | smaller  { /*printf("num_op : smaller\n");*/$$ = $1;/*show($$);*/ }
      | equal    { /*printf("num_op : equal\n");*/$$ = $1;/*show($$);*/ }
      ;

    plus: '(' '+' exp resursive_add ')' { $$=add($3,$4); }
        ;

    minus: '(' '-' exp exp')' { $$=sub($3,$4); }
         ;

    multiply: '(' '*' exp resursive_mult ')' { $$=mult($3,$4); }
            ;

    divide: '(' '/' exp exp')' { $$=divid($3,$4); }
          ;

    modulus: '(' MOD exp exp')' { $$=modu($3,$4); }
           ;

    greater: '(' '>' exp exp')' { $$=great($3,$4); }
           ;

    smaller: '(' '<' exp exp')' { $$=small($3,$4); }
           ;

    equal: '(' '=' exp resursive_equ ')' { $$=equ($3,$4); }
         ;

logical_op: and_op { /*printf("logical_op : and_op\n");*/$$ = $1;/*show($$);*/ }
          | or_op  { /*printf("logical_op : or_op\n");*/$$ = $1;/*show($$);*/ }
          | not_op { /*printf("logical_op : not_op\n");*/$$ = $1;/*show($$);*/ }
          ;

    and_op: '(' AND exp resursive_and ')' { $$=and_($3,$4); }
    ;

    or_op: '(' OR exp resursive_or ')' { $$=or_($3,$4); }
    ;

    not_op: '(' NOT exp ')' { $$=not_($3); }
    ;

resursive_add: exp resursive_add {$$=add($1,$2);} 
             | exp {$$=$1;}              
             ;

resursive_mult: exp resursive_mult {$$=mult($1,$2);} 
              | exp {$$=$1;}              
              ;

resursive_equ: exp resursive_equ {$$=equ($1,$2);} 
             | exp {$$=$1;}              
             ;

resursive_and: exp resursive_and {$$=and_($1,$2);} 
             | exp {$$=$1;}              
             ;

resursive_or: exp resursive_or {$$=or_($1,$2);} 
            | exp {$$=$1;}              
            ;


def_stmt: '(' DEFINE variable exp ')' { $$=new_var_val($3,$4); }
        ;

    variable: var { $$=new_var($$,$1); }
            ;

fun_exp: '(' FUN fun_ids fun_body ')' { ; }
       ;

    fun_ids: '(' variable_closure ')' { $$ = $2; }
           ;

    variable_closure: var variable_closure { ; }
                    | var { ; }
                    | {;}
                    ;

    fun_body: exp { $$ = $1; }
            ;

    fun_call: '(' fun_exp param ')'  { ; }
            | '(' fun_exp ')'        { ; }
            | '(' fun_name param ')' { ; }
            | '(' fun_name ')'       { ; }
            ;

    param: exp { $$ = $1; }
         ;

    fun_name: var { ; }
            ;

if_exp: '(' IF test_exp then_exp else_exp ')' { $$=if_($3,$4,$5); }
      ;

    test_exp: exp  { $$ = $1; }
            ;

    then_exp: exp { $$ = $1; }
            ;

    else_exp: exp { $$ = $1; }
            ;

%%

void yyerror (const char *message)
{
       // printf("%s\n", message);
		printf("error\n");
}

YYSTYPE yylval;

int main(int argc, char *argv[]) {
        yyparse();

        return(0);
}
