%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
void geraCodigo(const char *codigo);
extern FILE *yyin;
extern int yyparse(void);
extern int yylineno;

typedef struct Node {
    char *nome;
    struct Node *filho;
    struct Node *irmao;
} Node;

struct Node* criaNo(char *nome);
void adicionaFilho(Node *pai, struct Node *filho);
void imprimeArvore(struct Node *no, int nivel);

struct Node* criaNo(char *nome) {
    struct Node *no = (Node*) malloc(sizeof(Node));
    no->nome = strdup(nome);
    no->filho = NULL;
    no->irmao = NULL;
    return no;
}

void adicionaFilho(struct Node *pai, Node *filho) {
    if (pai->filho == NULL) {
        pai->filho = filho;
    } else {
        struct Node *temp = pai->filho;
        while (temp->irmao != NULL) {
            temp = temp->irmao;
        }
        temp->irmao = filho;
    }
}

void imprimeArvore(struct Node *no, int nivel) {
    for (int i = 0; i < nivel; i++) {
        printf("  ");
    }
    printf("%s\n", no->nome);
    for (struct Node *filho = no->filho; filho != NULL; filho = filho->irmao) {
        imprimeArvore(filho, nivel + 1);
    }
}
%}

/* Declare possible value types */
%union {
    char *texto;
    int num;
    int inteiro;
    char *identificador;
    struct Node *no;
}

/* Declare tokens and their types */
%token <texto> IDENTIFICADOR
%token <num> NUM
%token <texto> STRING
%token VAR CONFIGURAR COMO SAIDA LIGAR DESLIGAR ESPERAR
%token INTEIRO BOOLEANO TEXTO CONFIG REPITA FIM
%token ENTRADA CONECTAR_WIFI
%token LER_DIGITAL LER_ANALOGICO
%token CONFIGURAR_PWM FREQUENCIA RESOLUCAO AJUSTAR_PWM VALOR
%token COM IGUAL DIFERENTE MENOR MAIOR MENOR_IGUAL MAIOR_IGUAL
%token SOMA SUBTRACAO MULTIPLICACAO DIVISAO
%token SE SENAO ENTAO ENQUANTO
%token DOIS_PONTOS PONTO_E_VIRGULA VIRGULA IGUALDADE

/* Declare types for non-terminals */
/* %type <texto> tipo_declaracao configuracao loop comandos comando expressao termo fator condicao lista_identificadores declaracoes declaracao
%type <texto> programa */

typedef struct ASTNode {
    char *value;                // Stores the value (e.g., variable name, operator, etc.)
    struct ASTNode *left;       // Left child (for expressions, loops, etc.)
    struct ASTNode *right;      // Right child
} ASTNode;

ASTNode* createNode(const char *value, ASTNode *left, ASTNode *right) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    node->value = strdup(value);
    node->left = left;
    node->right = right;
    return node;
}  

%%

programa:
    declaracoes configuracao loop {
        printf("Parsed program\n");
        geraCodigo("#include <Arduino.h>\n#include <WiFi.h>\n");
        geraCodigo($1);
        geraCodigo("void setup() {");
        geraCodigo($2);
        geraCodigo("}");
        geraCodigo("void loop() {");
        geraCodigo($3);
        geraCodigo("}");

        // Create the AST for the program
        $$ = createNode("program", $1, createNode("loop", $2, $3));
    }
;

declaracoes:
    declaracao {
        printf("Parsed single declaracao\n");
        $$ = $1;  // Just pass down the AST for the declaration
    }
    | declaracoes declaracao {
        printf("Parsed multiple declaracoes\n");
        $$ = createNode("declarations", $1, $2);  // Create AST node for multiple declarations
    }
;

declaracao:
    VAR tipo_declaracao DOIS_PONTOS lista_identificadores PONTO_E_VIRGULA {
        printf("Parsed variable declaration: %s %s\n", $2, $4);
        asprintf(&$$, "%s %s;\n", $2, $4);
    }
;

configuracao:
    CONFIG comandos FIM {
        printf("Parsed configuracao\n");
        $$ = createNode("configuration", $2, NULL);  // Configuration node
    }
;

loop:
    REPITA comandos FIM {
        printf("Parsed loop\n");
        $$ = createNode("loop", $2, NULL);  // Loop node
    }
;

comandos:
    comando {
        printf("Parsed single comando\n");
        $$ = $1;  // Single command
    }
    | comandos comando {
        printf("Parsed multiple comandos\n");
        $$ = createNode("commands", $1, $2);  // Multiple commands
    }
;

comando:
    IDENTIFICADOR IGUALDADE expressao PONTO_E_VIRGULA {
        printf("Parsed assignment: %s = %s\n", $1, $3);
        asprintf(&$$, "%s = %s;", $1, $3);
    }
    | IDENTIFICADOR IGUALDADE STRING PONTO_E_VIRGULA {
        printf("Parsed string assignment: %s = %s\n", $1, $3);
        asprintf(&$$, "%s = %s;", $1, $3);
    }
    | CONFIGURAR IDENTIFICADOR COMO SAIDA PONTO_E_VIRGULA {
        printf("Parsed pin configuration: %s as output\n", $2);
        asprintf(&$$, "pinMode(%s, OUTPUT);", $2);
    }
    | CONFIGURAR IDENTIFICADOR COMO ENTRADA PONTO_E_VIRGULA {
        printf("Parsed pin configuration: %s as input\n", $2);
        asprintf(&$$, "pinMode(%s, INPUT);", $2);
    }
    | LIGAR IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed ligar: %s\n", $2);
        asprintf(&$$, "digitalWrite(%s, HIGH);", $2);
    }
    | DESLIGAR IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed desligar: %s\n", $2);
        asprintf(&$$, "digitalWrite(%s, LOW);", $2);
    }
    | ESPERAR NUM PONTO_E_VIRGULA {
        printf("Parsed esperar: %d\n", $2);
        asprintf(&$$, "delay(%d);", $2);
    }
    | IDENTIFICADOR IGUALDADE LER_DIGITAL IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed digital read: %s = digitalRead(%s)\n", $1, $4);
        asprintf(&$$, "%s = digitalRead(%s);", $1, $4);
    }
    | IDENTIFICADOR IGUALDADE LER_ANALOGICO IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed analog read: %s = analogRead(%s)\n", $1, $4);
        asprintf(&$$, "%s = analogRead(%s);", $1, $4);
    }
    | CONFIGURAR_PWM IDENTIFICADOR COM FREQUENCIA NUM RESOLUCAO NUM PONTO_E_VIRGULA {
        printf("Parsed PWM configuration: %s with frequency %d and resolution %d\n", $2, $5, $7);
        asprintf(&$$, "ledcSetup(%s, %d, %d);\nledcAttachPin(%s, 0);", $2, $5, $7, $2);
    }
    | AJUSTAR_PWM IDENTIFICADOR COM VALOR IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed PWM adjustment: %s with value %s\n", $2, $5);
        asprintf(&$$, "ledcWrite(0, %s);", $5);
    }
    | AJUSTAR_PWM IDENTIFICADOR COM VALOR NUM PONTO_E_VIRGULA {
        printf("Parsed PWM adjustment: %s with value %d\n", $2, $5);
        asprintf(&$$, "ledcWrite(0, %d);", $5);
    }
    | SE condicao ENTAO comandos SENAO comandos FIM {
        printf("Parsed conditional (if-else)\n");
        asprintf(&$$, "if (%s) {\n%s\n} else {\n%s\n}", $2, $4, $6);
    }
    | CONECTAR_WIFI IDENTIFICADOR IDENTIFICADOR PONTO_E_VIRGULA {
        printf("Parsed wifi connection: %s %s\n", $2, $3);
        asprintf(&$$, "WiFi.begin(%s.c_str(), %s.c_str());\nwhile (WiFi.status() != WL_CONNECTED) {\ndelay(500);\nSerial.println(\"Conectando ao WiFi...\");\n}\nSerial.println(\"Conectado ao WiFi!\");\n", $2, $3);
    }
    | SE condicao ENTAO comandos FIM {
        printf("Parsed conditional (if)\n");
        asprintf(&$$, "if (%s) {\n%s\n}", $2, $4);
    }
    | ENQUANTO condicao comandos FIM {
        printf("Parsed while loop\n");
        asprintf(&$$, "while (%s) {\n%s\n}", $2, $3);
    }
;

lista_identificadores:
    IDENTIFICADOR {
        printf("Parsed identifier: %s\n", $1);
        $$ = strdup($1);
    }
    | lista_identificadores VIRGULA IDENTIFICADOR {
        printf("Parsed identifier: %s\n", $3);
        asprintf(&$$, "%s, %s", $1, $3);
    }
;

expressao:
    expressao SOMA termo {
        asprintf(&$$, "%s + %s", $1, $3);
    }
    | expressao SUBTRACAO termo {
        asprintf(&$$, "%s - %s", $1, $3);
    }
    | termo {
        $$ = $1;
    }
;

termo:
    termo MULTIPLICACAO fator {
        asprintf(&$$, "%s * %s", $1, $3);
    }
    | termo DIVISAO fator {
        asprintf(&$$, "%s / %s", $1, $3);
    }
    | fator {
        $$ = $1;
    }
;

fator:
    IDENTIFICADOR {
        $$ = $1;
    }
    | NUM {
        asprintf(&$$, "%d", $1);
    }
;

condicao:
    expressao IGUAL expressao {
        asprintf(&$$, "%s == %s", $1, $3);
    }
    | expressao DIFERENTE expressao {
        asprintf(&$$, "%s != %s", $1, $3);
    }
    | expressao MENOR expressao {
        asprintf(&$$, "%s < %s", $1, $3);
    }
    | expressao MAIOR expressao {
        asprintf(&$$, "%s > %s", $1, $3);
    }

tipo_declaracao:
    INTEIRO {
        $$ = "int";
    }
    | BOOLEANO {
        $$ = "bool";
    }
    | TEXTO {
        $$ = "String";
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    exit(1);  // Exit after error for debugging purposes
}


void printAST(ASTNode *node, int level) {
    if (node == NULL) return;
    
    for (int i = 0; i < level; i++) {
        printf("  ");  // Indentation for tree structure
    }
    printf("%s\n", node->value);

    printAST(node->left, level + 1);
    printAST(node->right, level + 1);
}

char nomeArquivoSaida[100];

void geraNomeArquivoSaida(const char *nomeEntrada) {
    strcpy(nomeArquivoSaida, nomeEntrada);
    char *extensao = strrchr(nomeArquivoSaida, '.');
    if (extensao != NULL) {
        strcpy(extensao, ".cpp");
    } else {
        strcat(nomeArquivoSaida, ".cpp");
    }
    printf("Nome do arquivo de saída: %s\n", nomeArquivoSaida); // Linha de depuração
}

void geraCodigo(const char *codigo) {
    FILE *arquivo = fopen(nomeArquivoSaida, "a");
    if (arquivo == NULL) {
        fprintf(stderr, "Não foi possível abrir o arquivo %s.\n", nomeArquivoSaida); // Linha de depuração
        exit(1);
    }
    fprintf(arquivo, "%s\n", codigo);
    fclose(arquivo);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        geraNomeArquivoSaida(argv[1]);
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Não foi possível abrir o arquivo %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        fprintf(stderr, "Nenhum arquivo de entrada especificado.\n");
        return 1;
    }

    yyparse();
    printAST(programa, 0);
    return 0;
}