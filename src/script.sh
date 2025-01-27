#!/bin/bash

flex src/tradutor.l

bison -d -v src/tradutor.y
gcc lex.yy.c tradutor.tab.c -o ./tradutor -lfl

./tradutor exemplos/exemplo2.lang

