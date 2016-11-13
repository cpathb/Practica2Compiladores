#include <stdlib.h>
#include <string.h>
#include "tablaSimbolos.h"
#include "gestionErrores.h"
#include "lex.yy.c"


// Inicio de funciones

// Función que abre el fichero a analizar por lex.yy.c
void abrirficheroLex(char * nombreFichero){
    yyin=fopen(nombreFichero,"r");
    if(yyin == NULL){ // Comprobamos si no se pudo abrir el archivo en modo lectura
        ImprimirError(1,0); // No tiene un número de línea asociado, ya que es de inicialización del compilador
    }
    exit(1);
}

// Función que cierra el fichero a analizar por lex.yy.c
void cerrarficheroLex(){
    fclose(yyin);
}

//Funcion que destruye Lex.yy.c
void destruirLex(){
    yylex_destroy();
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

    if(elemento->compLex==-2){ // Si se ha encontrado un posible "identificador", aquí realizamos la diferencia entre palabra reservada y identificador
        elemento->lexema=strcpy(elemento->lexema,yytext);
        elemento->compLex=obtenerCompLex(yytext);
    }
    
    return elemento;
}