%{
    int linea = 1;
%}

DIGITO [0-9][_]?
BINARIO [01]
HEXADECIMAL [0-9a-fA-F]
IDENTIFICADOR [_a-zA-Z][_a-zA-Z0-9]*

%%

\n linea++; printf( "# of lines = %d\n",linea);
{DIGITO}+ /* Enteros */ printf("Entero: %s\n", yytext);
"0"[bB]{BINARIO}* /* Binarios */ printf("Entero Binario: %s\n", yytext);
"0"[xX]{HEXADECIMAL}* /* Hexadecimal */ printf("Entero Hexadecimal: %s\n", yytext);
{DIGITO}*[eE][+-]?{DIGITO}+ /* Científico */ printf("Entero Científico: %s\n", yytext);
{DIGITO}+"."{DIGITO}* /* Decimal */ printf("Decimal: %s\n", yytext);
{DIGITO}+"."{DIGITO}**[eE][+-]?{DIGITO}+ /* Decimal Científico */ printf("Decimal Científico: %s\n", yytext);

%%

main(){
    yylex();
}