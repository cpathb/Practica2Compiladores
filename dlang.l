%{
    #include "definiciones.h"
    #include "gestionErrores.h"

    int linea = 1, anidamiento=0;
%}

%x COMENTARIOMULTILINEA
%x COMENTARIOANIDAMIENTO
%x COMENTARIODOC

DIGITO              [0-9]
ENTERO              ({DIGITO}[_]?)+
BINARIO             "0"[bB][01]*
HEXADECIMAL         "0"[xX][0-9a-fA-F]*
CIENTIFICO          {ENTERO}[eE][+-]?{ENTERO}
DECIMAL             {ENTERO}"."{ENTERO}
DECIMALCIENTIFICO   {DECIMAL}[eE][+-]?{ENTERO}
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*
LITERALSIMPLE       ['].*[']
LITERALDOBLE        ["].*["]
COMENTARIOLINEA     "//"[^\n]*
TOKENSIMPLE         [\+\-\*\/\=\>\<\|\&\.\!\\\(\)\[\]\{\}\?\,\;\:\$\%\^\~\@\#]
IGUALIGUALQUE       "=="
DISTINTOQUE         "!="
MAYORIGUALQUE       ">="
MENORIGUALQUE       "<="
IGUALMAYORQUE       "=>"
IGUALMENORQUE       "=<"
MASIGUALQUE         "+="
MENOSIGUALQUE       "-="
PORIGUALQUE         "*="
BARRAIGUALQUE       "/="
MASMASQUE           "++"
MENOSMENOSQUE       "--"
RANGODE             ".."

%%

{ENTERO} /* Enteros */ printf("Entero: %s - %d\n", yytext, NUMEROENTERO);
{BINARIO} /* Binarios */ printf("Entero Binario: %s - %d\n", yytext, NUMEROBINARIO);
{HEXADECIMAL} /* Hexadecimal */ printf("Entero Hexadecimal: %s  - %d\n", yytext, NUMEROHEXADECIMAL);
{CIENTIFICO} /* Científico */ printf("Entero Científico: %s  - %d\n", yytext, NUMEROCIENTIFICO);
{DECIMAL} /* Decimal */ printf("Decimal: %s  - %d\n", yytext, NUMERODECIMAL);
{DECIMALCIENTIFICO} /* Decimal Científico */ printf("Decimal Científico: %s  - %d\n", yytext ,NUMEROCIENTIFICO);
{IDENTIFICADOR} /* Identificador */ printf("Identificador: %s  - %d\n", yytext, 408); /*HACER QUE BUSQUE EN LA TABLA DE SÍMBOLOS*/
{LITERALSIMPLE} /* Literal comilla simple */ printf("Literal comilla simple: %s  - %d\n", yytext, CADENALITERAL);
{LITERALDOBLE} /* Literal comilla doble */ printf("Literal comilla doble: %s  - %d\n", yytext, CADENALITERAL);
{TOKENSIMPLE} /*TOKEN Simple*/ printf("TOKEN: %s  - %d\n", yytext, yytext[0]);
{IGUALIGUALQUE} /* == */ printf("Igual Igual: %s  - %d\n", yytext,IGUALIGUAL);
{DISTINTOQUE}  /* != */ printf("Distinto: %s  - %d\n", yytext, DISTINTO);           
{MAYORIGUALQUE} /* >= */ printf("Mayor Igual: %s  - %d\n", yytext,MAYORIGUAL);
{MENORIGUALQUE} /* <= */ printf("Menor Igual: %s  - %d\n", yytext,MENORIGUAL);
{IGUALMAYORQUE} /* => */ printf("Igual Mayor: %s  - %d\n", yytext, IGUALMAYOR);   
{IGUALMENORQUE} /* =< */ printf("Igual Menor: %s  - %d\n", yytext,IGUALMENOR); 
{MASIGUALQUE} /* += */ printf("Mas Igual: %s  - %d\n", yytext,MASIGUAL); 
{MENOSIGUALQUE} /* -= */ printf("Menos Igual: %s  - %d\n", yytext,MENOSIGUAL); 
{PORIGUALQUE} /* *= */ printf("Por Igual: %s  - %d\n", yytext,PORIGUAL); 
{BARRAIGUALQUE} /* /= */ printf("Barra Igual: %s  - %d\n", yytext,BARRAIGUAL); 
{MASMASQUE} /* ++ */ printf("Mas Mas: %s  - %d\n", yytext,MASMAS); 
{MENOSMENOSQUE} /* -- */ printf("Menos Menos: %s  - %d\n", yytext,MENOSMENOS); 
{RANGODE} /* .. */ printf("Rango: %s  - %d\n", yytext,RANGO); 
{COMENTARIOLINEA} /* Comentario de línea */
\n linea++;
[ \t]

"/*" BEGIN(COMENTARIOMULTILINEA);                    
<COMENTARIOMULTILINEA>[^*\n]*
<COMENTARIOMULTILINEA>"*"+[^*/\n]* 
<COMENTARIOMULTILINEA>\n linea++;
<COMENTARIOMULTILINEA>"*"+"/" BEGIN(INITIAL);
<COMENTARIOMULTILINEA><<EOF>> ImprimirError(9,linea); BEGIN(INITIAL);
    
"/+" anidamiento++; BEGIN(COMENTARIOANIDAMIENTO); /* BUCLE*/
<COMENTARIOANIDAMIENTO>[^+\n]*
<COMENTARIOANIDAMIENTO>"+"+[^+/\n]*
<COMENTARIOANIDAMIENTO>"/+" anidamiento++;
<COMENTARIOANIDAMIENTO>"+/" {
                                    anidamiento--;
                                    if(anidamiento==0){
                                        BEGIN(INITIAL);
                                    }
                            }
<COMENTARIOANIDAMIENTO>\n linea++;
<COMENTARIOANIDAMIENTO><<EOF>> ImprimirError(9,linea);  BEGIN(INITIAL);

%%

int main(){
    yyin=fopen("reggression.d","r");
    yylex();
    printf("Número de líneas: %d\n", linea);
    fclose(yyin);
}