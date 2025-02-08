#!/bin/bash

flex src/tradutor.l

bison -d -v src/tradutor.y
gcc lex.yy.c tradutor.tab.c -o ./tradutor -lfl

for arquivo in exemplos/*.lang; do
    ./tradutor "$arquivo"
done
./tradutor exemplos/exemplo3.lang

