# Práctica 2 Compiladores e Intérpretes
<br>
<br>
<br>
# Autor: Carlos Parada Alfaya

## Introducción
Práctica 2 de compiladores, donde partiendo de la práctica 1, se integrará un analizador léxico generado en flex sustituyendo el actual.

## Comandos para la compilación de la práctica

Para garantizar la correcta compilación de la práctica practica se ruega que una vez descomprimida, no se muevan los archivos de su carpeta.

> flex dlang.l
>
> gcc main.c gestionErrores.c analizadorLexico.c lista.c tabla_hash_encadenamiento.c tablaSimbolos.c -lfl -o practica2.out

## Comandos para la ejecución de la práctica

> ./practica2.out