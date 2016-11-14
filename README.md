# **Importante**
Este documento está generado empleando MarkDown, por lo que necesitarás de un 
intérprete para ver el resultado final. Si no tienes ningún interprete puedes 
utilizar el siguiente enlace para acceder a un interprete online:

> **[https://stackedit.io/](https://stackedit.io/) (25/10/2016)**

<br>
<br>
<br>
<br>
<br>
<br>

# **Práctica 2 Compiladores e Intérpretes**

<br>
<br>
<br>
<br>
<br>

# _**Analizador Léxico empleando FLEX**_

<br>
<br>
<br>
<br>
<br>

# Autor: Carlos Parada Alfaya

<br>
<br>
<br>

## Introducción
Práctica 2 de compiladores, donde partiendo de la práctica 1, se integrará un analizador léxico generado en flex sustituyendo el actual.

<br>
<br>
<br>

## **Comando de compilación de la práctica en terminal**

Para garantizar la correcta compilación de la práctica practica se ruega que una vez descomprimida, no se muevan los archivos de su carpeta.

### **Compilación del fichero de flex** 
> flex dlang.l

<br>
<br>
<br>

### **Compilación de los ficheros de fuente del programa**
> gcc main.c gestionErrores.c analizadorLexico.c lista.c tabla_hash_encadenamiento.c tablaSimbolos.c -lfl -o practica2.out

<br>
<br>
<br>

## **Comando de ejecución de la práctica en terminal**

> ./practica2.out

<br>
<br>
<br>

## **Notas**
- Los archivos no deberán de moverse de la carpeta en la que estarán situados una vez se ha descomprimido el fichero .zip proporcionado en la entrega de la práctica, ya que si no, no se puede garantizar el correcto funcionamiento de la práctica.
