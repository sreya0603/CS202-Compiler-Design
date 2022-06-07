# CS202-Compiler-Design

GOPAGONI SREYA

i) to run and compile use commands
 bison -d cucu.l
 flex cucu.l
 gcc cucu.tab.c lex.yy.c -lfl -o cucu
 ./cucu micro.txt
 if micro.txt is the input file
 input file should be given as command line arguments

ii) i have not included brackets in parser output
iii) Sample1.txt Sample2.txt are input file.   
   Sample1.txt contain correct c code 
   Sample2.tx contain incorrect c code
