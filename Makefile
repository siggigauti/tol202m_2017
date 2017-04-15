all: NanoLexer.class NanoParser.class NanoParserVal.class

test: all test.nm
	java -cp . NanoParser test.nm > test.masm
	java -cp . -jar morpho.jar -c test.masm
	java -cp . -jar morpho.jar test

NanoLexer.class NanoParser.class NanoParserVal.class: NanoLexer.java NanoParser.java NanoParserVal.java
	javac NanoLexer.java NanoParser.java NanoParserVal.java

NanoLexer.java: NanoLexer.jflex
	java -jar jflex-1.6.1.jar NanoLexer.jflex

NanoParser.java NanoParserVal.java: fyrsta.byacc
	./byacc -Jclass=NanoParser fyrsta.byacc

clean:
	rm -rf *.class *~ *.java *.bak yacc.* *.masm *mexe
