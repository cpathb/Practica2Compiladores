%{
    int linea = 1;
%}

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
COMENTARIOMULTILINEA
COMENTARIOANIDADO
COMENTARIODOCUMENTACION
TOKENSIMPLE         [\+\-\*\/\=\>\<\|\&\.\!\\\(\)\[\]\{\}\?\,\;\:\$\%\^\~\@\#]
IGUALIGUAL          "=="
DISTINTO            "!="
MAYORIGUAL          ">="
MENORIGUAL          "<="
IGUALMAYOR          "=>"
IGUALMENOR          "=<"
MASIGUAL            "+="
MENOSIGUAL          "-="
PORIGUAL            "*="
BARRAIGUAL          "/="
MASMAS              "++"
MENOSMENOS          "--"
RANGO               ".."

%%

\n linea++;
{ENTERO} /* Enteros */ printf("Entero: %s\n", yytext);
{BINARIO} /* Binarios */ printf("Entero Binario: %s\n", yytext);
{HEXADECIMAL} /* Hexadecimal */ printf("Entero Hexadecimal: %s\n", yytext);
{CIENTIFICO} /* Científico */ printf("Entero Científico: %s\n", yytext);
{DECIMAL} /* Decimal */ printf("Decimal: %s\n", yytext);
{DECIMALCIENTIFICO} /* Decimal Científico */ printf("Decimal Científico: %s\n", yytext);
{IDENTIFICADOR} /* Identificador */ printf("Identificador: %s\n", yytext);
{LITERALSIMPLE} /* Literal comilla simple */ printf("Literal comilla simple: %s\n", yytext);
{LITERALDOBLE} /* Literal comilla doble */ printf("Literal comilla doble: %s\n", yytext);
{COMENTARIOLINEA} /* Comentario de línea */ printf("Comentario de línea: %s\n", yytext);
{TOKENSIMPLE} /*TOKEN Simple*/ printf("TOKEN: %s\n", yytext);
{IGUALIGUAL} /* == */ printf("Igual Igual: %s\n", yytext);
{DISTINTO}  /* != */ printf("Distinto: %s\n", yytext);           
{MAYORIGUAL} /* >= */ printf("Mayor Igual: %s\n", yytext);
{MENORIGUAL} /* <= */ printf("Menor Igual: %s\n", yytext);
{IGUALMAYOR} /* => */ printf("Igual Mayor: %s\n", yytext);   
{IGUALMENOR} /* =< */ printf("Igual Menor: %s\n", yytext); 
{MASIGUAL} /* += */ printf("Mas Igual: %s\n", yytext); 
{MENOSIGUAL} /* -= */ printf("Menos Igual: %s\n", yytext); 
{PORIGUAL} /* *= */ printf("Por Igual: %s\n", yytext); 
{BARRAIGUAL} /* /= */ printf("Barra Igual: %s\n", yytext); 
{MASMAS} /* ++ */ printf("Mas Mas: %s\n", yytext); 
{MENOSMENOS} /* -- */ printf("Menos Menos: %s\n", yytext); 
{RANGO} /* .. */ printf("Rango: %s\n", yytext); 

%%