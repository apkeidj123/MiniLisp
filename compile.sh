#! /bin/bash -e
# -e means terminate when there are errors.
# ${parameter%word} = remove suffix word in parameter
# usage: yacc <filename>
# inputs are filename.l, filename.y,
# outputs is filename
# lexfilename=${1}

# compile bison
eval "bison -d -r all -o $1.tab.c $1.y"
eval "gcc -c -g -I.. $1.tab.c"
# compile flex
eval "flex -o lex.yy.c $1.l"
eval "gcc -c -g -I.. lex.yy.c"
# compile and link bison and flex
eval "gcc $1.tab.o lex.yy.o -ll"

