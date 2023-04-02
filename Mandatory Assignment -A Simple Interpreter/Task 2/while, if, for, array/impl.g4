grammar impl;

/* A small imperative language */

start   :  cs+=command* EOF ;

program : c=command                                                           # SingleCommand
	| '{' cs+=command* '}'                                                    # MultipleCommands
	;
	
command
    : x=ID '=' e=expr ';'	                                                  # Assignment
    | x=ID '[' expr']' '=' expr ';'  	                                      # ArrayAssignment
    | 'output' e=expr ';'                                                     # Output
    | 'while'  '('c=condition')' p=program                                    # WhileLoop
    | 'for'  '('x=ID '=' min=expr '..' max=expr')' p=program                  # ForLoop
    | 'if'     '('c=condition')' p=program                                    # IfStatment
    | 'if'     '('c=condition')' p1=program  ('else' p2=program)?             # IfElseStatment
	;
	
expr
    : x=ID '[' expr']'   	                                                   # ArrayGET
	 | e1=expr '^'  e2=expr          			                               # POWER
     | 'sqrt('  expr   ')'                                                     # SQRT
     | e1=expr op=('*' | '/') e2=expr         		                           # MULTI_DEVI
	 | e1=expr '%' e2=expr							                           # MOD
     | e1=expr op=('+' | '-') e2=expr         		                           # ADD_SUB
     | op=('+' | '-') e=expr                  		                           # Minus
     | '(' e=expr ')'      							                           # PARENTHESES
	 | c=NUMBER   	      					 		                           # NUMBER
	 | c=FLOAT     	      							                           # Constant
	 | x=ID		      								                           # Variable
	 | '(' e=expr ')'      							                           # Parenthesis
	 ;

condition 
    : expr '>' expr  			    				                           # Greater
    | expr '>=' expr 				    			                           # GreaterThan
    | expr '<'  expr 					    		                           # Less
    | expr '<=' expr 						    	                           # LessThan
    | expr '!=' expr 							                               # Unequal
	| expr '==' expr 							                               # Equal
| condition '&&' condition 							                           # AND
| condition '||' condition 							                           # OR
    // ... extend me
	;


ID    : ALPHA (ALPHA|NUM)*  ;
NUMBER  : [0-9]+ ('.' [0-9]+)? ;
FLOAT : '-'? NUM+ ('.' NUM+)? ;

ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;


WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
