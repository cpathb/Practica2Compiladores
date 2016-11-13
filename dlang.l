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

{ENTERO} /* Enteros */ return NUMEROENTERO;
{BINARIO} /* Binarios */ return NUMEROBINARIO;
{HEXADECIMAL} /* Hexadecimal */ return NUMEROHEXADECIMAL;
{CIENTIFICO} /* Científico */ return NUMEROCIENTIFICO;
{DECIMAL} /* Decimal */ return NUMERODECIMAL;
{DECIMALCIENTIFICO} /* Decimal Científico */ return NUMEROCIENTIFICO;
{IDENTIFICADOR} /* Identificador */ return -2; 
{TOKENSIMPLE} /*TOKEN Simple*/ return (int) yytext[0];
{IGUALIGUALQUE} /* == */ return IGUALIGUAL;
{DISTINTOQUE}  /* != */ return DISTINTO;           
{MAYORIGUALQUE} /* >= */ return MAYORIGUAL;
{MENORIGUALQUE} /* <= */ return MENORIGUAL;
{IGUALMAYORQUE} /* => */ return IGUALMAYOR;   
{IGUALMENORQUE} /* =< */ return IGUALMENOR; 
{MASIGUALQUE} /* += */ return MASIGUAL; 
{MENOSIGUALQUE} /* -= */ return MENOSIGUAL; 
{PORIGUALQUE} /* *= */ return PORIGUAL; 
{BARRAIGUALQUE} /* /= */ return BARRAIGUAL; 
{MASMASQUE} /* ++ */ return MASMAS; 
{MENOSMENOSQUE} /* -- */ return MENOSMENOS; 
{RANGODE} /* .. */ return RANGO; 
{COMENTARIOLINEA} /* Comentario de línea */
\n linea++;
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
<COMENTARIOANIDAMIENTO><<EOF>> ImprimirError(9,linea);  BEGIN(INITIAL);

"/**" yymore(); BEGIN(COMENTARIODOC);
<COMENTARIODOC>[^*\n]* yymore();
<COMENTARIODOC>"*"+[^*/\n]* yymore();
<COMENTARIODOC>\n linea++; yymore();
<COMENTARIODOC>"*"+"/" yymore();BEGIN(INITIAL); return COMENTARIODOCUMENTACION;
<COMENTARIODOC><<EOF>> yyrestart(yyin); ImprimirError(9,linea); BEGIN(INITIAL);

"/**/" /* Sirve para eliminar el caso de un comentario de documentación falso*/

"\'" yymore(); BEGIN(COMILLAS);
<COMILLAS>[^\'\n]* yymore();
<COMILLAS>\n yymore(); linea++;
<COMILLAS>"\'" yymore(); BEGIN(INITIAL); return CADENALITERAL;
<COMILLAS><<EOF>> yyrestart(yyin);ImprimirError(7,linea); BEGIN(INITIAL);

"\"" yymore(); BEGIN(COMILLAD);
<COMILLAD>[^\"\n]* yymore();
<COMILLAD>\n yymore(); linea++;
<COMILLAD>"\"" yymore(); BEGIN(INITIAL); return CADENALITERAL;
<COMILLAD><<EOF>> yyrestart(yyin);ImprimirError(8,linea); BEGIN(INITIAL);

%%

int main(){
    yyin=fopen("regression.d","r");
    yylex();
    fclose(yyin);
}