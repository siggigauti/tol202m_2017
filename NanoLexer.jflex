import java.io.*;

%%

%public
%class NanoLexer
%unicode
%byaccj
%line
%column

%{

public NanoParser yyparser;


/* constructor taking an additional parser object */
public NanoLexer(java.io.Reader r, NanoParser yyparser) {
    this(r);
    this.yyparser = yyparser;
}

%}

  /* Reglulegar skilgreiningar */

  /* Regular definitions */

_DIGIT=[0-9]
_FLOAT={_DIGIT}+\.{_DIGIT}+([eE][+-]?{_DIGIT}+)?
_INT={_DIGIT}+
_STRING=\"([^\"\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|\\[0-7][0-7]|\\[0-7])*\"
_CHAR=\'([^\'\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|(\\[0-7][0-7])|(\\[0-7]))\'
_DELIM=[(){};=,]
_OPNAME=[\+\-*/!%&=><\:\^\~&|?]+
_NAME=([:letter:]|{_DIGIT})+

%%

  /* Lesgreiningarreglur */

{_DELIM} {
	return yycharat(0); 	
}

{_STRING} | {_FLOAT} | {_CHAR} | {_INT} | null | true | false {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.LITERAL;
}

"if" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.IF;
}

"while" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.WHILE;
}

"else" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.ELSE;
}

"elseif" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.ELSEIF;
}

"return" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.RETURN;
}

"var" {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.VAR;
}

{_OPNAME} {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.OPNAME;
}

{_NAME} {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.NAME;
}

";;;".*$ {
}

[ \t\r\n\f] {
}

. {
	yyparser.yylval = new NanoParserVal(yytext());
	
    return yyparser.ERROR;
}
