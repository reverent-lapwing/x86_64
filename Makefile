%.o: %.S
	as $< -o $@ # compile every *.S file into binary form *.o

01: 01.o
	ld $< -o $@ # turn object files into executables

02: 02.o
	ld -static $< -o $@ # turn object files into executables

03: 03.o
	ld -static -s 03.o -lc -o $@

linking: 03.o 04_strlen.o
	ld -static -s 03.o 04_strlen.o -lc -o $@ # builds "linking" executable from 03.o (contains main) and 04_strlen.o (contains strlen)

stack: 05.o 05_print.o 04_strlen.o
	ld -static -s 05.o 05_print.o 04_strlen.o -lc -o $@ 

# list of executables we want to create - automake will use the rules above to figure out the steps for creating them
all: 01 02 03 linking stack
