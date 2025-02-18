/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_TRADUTOR_TAB_H_INCLUDED
# define YY_YY_TRADUTOR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IGUALDADE = 258,
    SOMA = 259,
    SUBTRACAO = 260,
    MULTIPLICACAO = 261,
    DIVISAO = 262,
    MODULO = 263,
    IGUAL = 264,
    DIFERENTE = 265,
    MENOR = 266,
    MAIOR = 267,
    MENOR_IGUAL = 268,
    MAIOR_IGUAL = 269,
    IDENTIFICADOR = 270,
    NUM = 271,
    STRING = 272,
    VAR = 273,
    CONFIGURAR = 274,
    COMO = 275,
    SAIDA = 276,
    LIGAR = 277,
    DESLIGAR = 278,
    ESPERAR = 279,
    INTEIRO = 280,
    BOOLEANO = 281,
    TEXTO = 282,
    CONFIG = 283,
    REPITA = 284,
    FIM = 285,
    ENTRADA = 286,
    CONECTAR_WIFI = 287,
    LER_DIGITAL = 288,
    LER_ANALOGICO = 289,
    CONFIGURAR_PWM = 290,
    FREQUENCIA = 291,
    RESOLUCAO = 292,
    AJUSTAR_PWM = 293,
    VALOR = 294,
    COM = 295,
    ENTRADA_PULLDOWN = 296,
    SE = 297,
    SENAO = 298,
    ENTAO = 299,
    ENQUANTO = 300,
    ESCREVER_SERIAL = 301,
    LER_SERIAL = 302,
    ENVIAR_HTTP = 303,
    DOIS_PONTOS = 304,
    PONTO_E_VIRGULA = 305,
    VIRGULA = 306,
    CONFIGURAR_SERIAL = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 124 "src/tradutor.y"

    char *texto;
    int num;
    int inteiro;
    char *identificador;

#line 117 "tradutor.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_TRADUTOR_TAB_H_INCLUDED  */
