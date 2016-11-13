cmake_minimum_required(VERSION 2.8.4)
project(Practica2Compiladores)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lfl -Wall")

set(SOURCE_FILES main.c gestionErrores.c analizadorLexico.c lista.c tabla_hash_encadenamiento.c tablaSimbolos.c lex.yy.c)
add_executable(Practica2Compiladores ${SOURCE_FILES})