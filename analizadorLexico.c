#include <stdlib.h>
#include <string.h>
#include "tablaSimbolos.h"
#include "lex.yy.c"


// Inicio de funciones

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

    if(elemento->compLex==-2){ // Si se ha encontrado un posible "identificador", aquí realizamos la diferencia entre palabra reservada y identificador
        elemento->lexema=strcpy(elemento->lexema,yytext);
        elemento->compLex=obtenerCompLex(yytext);
    }
    
    return elemento;
}