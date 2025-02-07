%{
#include "tradutor.tab.h"
#include <stdio.h>
%}

%%

"config"              { printf("Token CONFIG encontrado\n"); return CONFIG; }
"repita"              { printf("Token REPITA encontrado\n"); return REPITA; }
"fim"                 { printf("Token FIM encontrado\n"); return FIM; }
"var"                 { printf("Token VAR encontrado\n"); return VAR; }
"inteiro"             { printf("Token INTEIRO encontrado\n"); return INTEIRO; }
"booleano"            { printf("Token BOOLEANO encontrado\n"); return BOOLEANO; }
"texto"               { printf("Token TEXTO encontrado\n"); return TEXTO; }
"configurar"          { printf("Token CONFIGURAR encontrado\n"); return CONFIGURAR; }
"como"                { printf("Token COMO encontrado\n"); return COMO; }
"saida"               { printf("Token SAIDA encontrado\n"); return SAIDA; }
"entrada"             { printf("Token ENTRADA encontrado\n"); return ENTRADA; }
"ligar"               { printf("Token LIGAR encontrado\n"); return LIGAR; }
"desligar"            { printf("Token DESLIGAR encontrado\n"); return DESLIGAR; }
"conectarWifi"        { printf("Token CONECTAR_WIFI encontrado\n"); return CONECTAR_WIFI; }
"configurarSerial"    { printf("Token CONFIGURAR_SERIAL encontrado\n"); return CONFIGURAR_SERIAL; }
"escreverSerial"      { printf("Token ESCREVER_SERIAL encontrado\n"); return ESCREVER_SERIAL; }
"lerSerial"           { printf("Token LER_SERIAL encontrado\n"); return LER_SERIAL; }
"esperar"             { printf("Token ESPERAR encontrado\n"); return ESPERAR; }
"lerDigital"          { printf("Token LER_DIGITAL encontrado\n"); return LER_DIGITAL; }
"lerAnalogico"        { printf("Token LER_ANALOGICO encontrado\n"); return LER_ANALOGICO; }
"configurarPWM"       { printf("Token CONFIGURAR_PWM encontrado\n"); return CONFIGURAR_PWM; }
"frequencia"          { printf("Token FREQUENCIA encontrado\n"); return FREQUENCIA; }
"resolucao"           { printf("Token RESOLUCAO encontrado\n"); return RESOLUCAO; }
"ajustarPWM"          { printf("Token AJUSTAR_PWM encontrado\n"); return AJUSTAR_PWM; }
"valor"               { printf("Token VALOR encontrado\n"); return VALOR; }
"com"                 { printf("Token COM encontrado\n"); return COM; }
"se"                  { printf("Token SE encontrado\n"); return SE; }
"senao"               { printf("Token SENAO encontrado\n"); return SENAO; }
"entao"               { printf("Token ENTAO encontrado\n"); return ENTAO; }
"enquanto"            { printf("Token ENQUANTO encontrado\n"); return ENQUANTO; }
":"                   { printf("Token DOIS_PONTOS encontrado\n"); return DOIS_PONTOS; }
"=="                  { printf("Token IGUAL encontrado\n"); return IGUAL; }
"!="                  { printf("Token DIFERENTE encontrado\n"); return DIFERENTE; }
"<"                   { printf("Token MENOR encontrado\n"); return MENOR; }
">"                   { printf("Token MAIOR encontrado\n"); return MAIOR; }
"<="                  { printf("Token MENOR_IGUAL encontrado\n"); return MENOR_IGUAL; }
">="                  { printf("Token MAIOR_IGUAL encontrado\n"); return MAIOR_IGUAL; }
"+"                   { printf("Token SOMA encontrado\n"); return SOMA; }
"-"                   { printf("Token SUBTRACAO encontrado\n"); return SUBTRACAO; }
"*"                   { printf("Token MULTIPLICACAO encontrado\n"); return MULTIPLICACAO; }
"/"                   { printf("Token DIVISAO encontrado\n"); return DIVISAO; }
","                   { printf("Token VIRGULA encontrado\n"); return VIRGULA; }
"="                   { printf("Token IGUALDADE encontrado\n"); return IGUALDADE; }
";"                   { printf("Token PONTO_VIRGULA encontrado\n"); return PONTO_E_VIRGULA; }
[0-9]+                { printf("Token NUM encontrado: %s\n", yytext); yylval.inteiro = atoi(yytext); return NUM; }
\"[^\"]*\"            { printf("Token STRING encontrado: %s\n", yytext); yylval.texto = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Token IDENTIFICADOR encontrado: %s\n", yytext); yylval.identificador = strdup(yytext); return IDENTIFICADOR; }
[ \t\n]               { /* Ignorar espaços e quebras de linha */ }
.                     { printf("Token desconhecido encontrado: %s\n", yytext); return yytext[0]; }

%%
