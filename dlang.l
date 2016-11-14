%{
    #include "definiciones.h"
    #include "gestionErrores.h"

    int linea = 1, anidamiento=0;
%}

%x COMENTARIOMULTILINEA
%x COMENTARIOANIDAMIENTO
%x COMENTARIODOC
%x COMILLAD
%x COMILLAS

DIGITO              [0-9]
ENTERO              ({DIGITO}[_]?)+
BINARIO             "0"[bB][01]*
HEXADECIMAL         "0"[xX][0-9a-fA-F]*
CIENTIFICO          {ENTERO}[eE][+-]?{ENTERO}
DECIMAL             {ENTERO}"."{ENTERO}
DECIMALCIENTIFICO   {DECIMAL}[eE][+-]?{ENTERO}
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*
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

{ENTERO} /* Enteros */ return(NUMEROENTERO);
{BINARIO} /* Binarios */ return(NUMEROBINARIO);
{HEXADECIMAL} /* Hexadecimal */ return(NUMEROHEXADECIMAL);
{CIENTIFICO} /* Científico */ return(NUMEROCIENTIFICO);
{DECIMAL} /* Decimal */ return(NUMERODECIMAL);
{DECIMALCIENTIFICO} /* Decimal Científico */ return(NUMEROCIENTIFICO);
{IDENTIFICADOR} /* Identificador */ return(-2); 
{TOKENSIMPLE} /*TOKEN Simple*/ return((int) yytext[0]);
{IGUALIGUALQUE} /* == */ return(IGUALIGUAL);
{DISTINTOQUE}  /* != */ return(DISTINTO);           
{MAYORIGUALQUE} /* >= */ return(MENORIGUAL);
{IGUALMAYORQUE} /* => */ return(IGUALMAYOR);   
{IGUALMENORQUE} /* =< */ return(IGUALMENOR); 
{MASIGUALQUE} /* += */ return(MASIGUAL); 
{MENOSIGUALQUE} /* -= */ return(MENOSIGUAL); 
{PORIGUALQUE} /* *= */ return(PORIGUAL); 
{BARRAIGUALQUE} /* /= */ return(BARRAIGUAL); 
{MASMASQUE} /* ++ */ return(MASMAS); 
{MENOSMENOSQUE} /* -- */ return(MENOSMENOS); 
{RANGODE} /* .. */ return(RANGO); 
{COMENTARIOLINEA} /* Comentario de línea */
\n /* Salto de línea*/ linea++;
[ \t\r\b\f] /* Simbolos que no se tienen que contemplar */

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
<COMENTARIOANIDAMIENTO><<EOF>> ImprimirError(9,linea); BEGIN(INITIAL);

"/**" yymore(); BEGIN(COMENTARIODOC);
<COMENTARIODOC>[^*\n]* yymore();
<COMENTARIODOC>"*"+[^*/\n]* yymore();
<COMENTARIODOC>\n linea++; yymore();
<COMENTARIODOC>"*"+"/" BEGIN(INITIAL); return(COMENTARIODOCUMENTACION);
<COMENTARIODOC><<EOF>> yyrestart(yyin); ImprimirError(9,linea); BEGIN(INITIAL);

"/**/" /* Sirve para eliminar el caso de un comentario de documentación falso*/

"\'" yymore(); BEGIN(COMILLAS);
<COMILLAS>\\\'                                                  |
<COMILLAS>\\\?                                                  |
<COMILLAS>\\\\                                                  |
<COMILLAS>\\0                                                   |
<COMILLAS>\\a                                                   |
<COMILLAS>\\b                                                   |
<COMILLAS>\\f                                                   |
<COMILLAS>\\n                                                   |
<COMILLAS>\\r                                                   |
<COMILLAS>\\t                                                   |
<COMILLAS>\\v                                                   |
<COMILLAS>\\\"                                                  yymore();
<COMILLAS>\n yymore(); linea++;
<COMILLAS>"\'" BEGIN(INITIAL); return(CADENALITERAL);
<COMILLAS><<EOF>> yyrestart(yyin);ImprimirError(7,linea); return(-1); BEGIN(INITIAL);
<COMILLAS>[.]* yymore();

"\"" yymore(); BEGIN(COMILLAD);
<COMILLAD>\\\'                                                  |
<COMILLAD>\\\?                                                  |
<COMILLAD>\\\\                                                  |
<COMILLAD>\\0                                                   |
<COMILLAD>\\a                                                   |
<COMILLAD>\\b                                                   |
<COMILLAD>\\f                                                   |
<COMILLAD>\\n                                                   |
<COMILLAD>\\r                                                   |
<COMILLAD>\\t                                                   |
<COMILLAD>\\v                                                   |
<COMILLAD>\\\"                                                  yymore();
<COMILLAD>\n yymore(); linea++;
<COMILLAD>"\"" BEGIN(INITIAL); return(CADENALITERAL);
<COMILLAD><<EOF>> yyrestart(yyin);ImprimirError(8,linea); BEGIN(INITIAL);
<COMILLAD>[.]* yymore();

<<EOF>> /*Fin de archivo*/ return(-1);

%%
