grammar Plantuml;

/*
 * Parser Rules
 */

plantumlfile		: STARTFILE (umlclass)+ EMDFILE;
name                : WORD ;	
umlclass			: class_declaration  ;


/*
 * Lexer Rules
 */


//https://github.com/antlr/grammars-v4/blob/master/csharp/CSharpLexer.g4



OPEN_BRACE          :  '{';
CLOSE_BRACE         : '}';
PARENS:              '()';
CLASS               : 'class';
STARTFILE           : '@startuml';
EMDFILE             : '@enduml';
COLON				: ':';
EXPLICIT_METHOD		: '{method';
WHITESPACES:   (Whitespace | NewLine)+ -> channel(HIDDEN);    
WORD : [A-Za-z_][A-Za-z_0-9]* ; 


class_declaration   : CLASS class_identifier OPEN_BRACE atttribute_def method_def* CLOSE_BRACE;
atttribute_def      : (objecttype COLON WORD)*;
method_def          
		: (objecttype method_name  PARENS) 
		| (method_name PARENS )
		;
method_name			: WORD;
objecttype			: WORD;
class_identifier    : WORD;
identifier          : WORD;

//TEXT                : '"' .*? '"' ;

fragment NewLine
	: '\r\n' | '\r' | '\n'
	| '\u0085' // <Next Line CHARACTER (U+0085)>'
	| '\u2028' //'<Line Separator CHARACTER (U+2028)>'
	| '\u2029' //'<Paragraph Separator CHARACTER (U+2029)>'
    ;

fragment Whitespace
	: UnicodeClassZS //'<Any Character With Unicode Class Zs>'
	| '\u0009' //'<Horizontal Tab Character (U+0009)>'
	| '\u000B' //'<Vertical Tab Character (U+000B)>'
	| '\u000C' //'<Form Feed Character (U+000C)>'
	;

fragment UnicodeClassZS
	: '\u0020' // SPACE
	| '\u00A0' // NO_BREAK SPACE
	| '\u1680' // OGHAM SPACE MARK
	| '\u180E' // MONGOLIAN VOWEL SEPARATOR
	| '\u2000' // EN QUAD
	| '\u2001' // EM QUAD
	| '\u2002' // EN SPACE
	| '\u2003' // EM SPACE
	| '\u2004' // THREE_PER_EM SPACE
	| '\u2005' // FOUR_PER_EM SPACE
	| '\u2006' // SIX_PER_EM SPACE
	| '\u2008' // PUNCTUATION SPACE
	| '\u2009' // THIN SPACE
	| '\u200A' // HAIR SPACE
	| '\u202F' // NARROW NO_BREAK SPACE
	| '\u3000' // IDEOGRAPHIC SPACE
	| '\u205F' // MEDIUM MATHEMATICAL SPACE
	;
