#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "tablaSimbolos.h"
#include "sistemaEntrada.h"
#include "definiciones.h"
#include "lex.yy.c"


// Inicio de funciones

// Función para inicializar el Analizador Léxico
void inicializarAnalizadorLexico(){
    tamMaxLexema=tamMaximoLexema();
}

// Función que devuelve el siguiente lexema del sistema de entrada, si se acabaron los lexemas se devuelve NULL
tipoelem * siguienteLexema(){
    tipoelem *elemento;
    elemento=malloc(sizeof(tipoelem)); // Reservamos memoria para la estructura del elemento
    elemento->lexema=calloc(1,sizeof(char)); // Reservamos memoria para un caracter y lo rellenamos con '\0'
    elemento->compLex=-1; // Inicializamos a un valor que nunca podrá tomar

    elemento->compLex=yylex();
    if(elemento->compLex==-1){ // Si se ha encontrado fin de fichero
        elemento->lexema=NULL;
    }

    if(elemento->compLex==-2){ // Si se ha encontrado fin de fichero
        elemento->lexema=yytext;
    }
    
    return elemento;
}