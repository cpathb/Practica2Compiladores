#include "gestionErrores.h"
#include "lista.h"
#pragma once

// Función que devuelve el siguiente lexema del archivo, si es fin de archivo devuelve NULL
tipoelem * siguienteLexema();

// Función que abre el fichero a analizar por lex.yy.c
void abrirficheroLex(char * nombreFichero);

// Función que cierra el fichero a analizar por lex.yy.c
void cerrarficheroLex();

//Funcion que destruye Lex.yy.c
void destruirLex();