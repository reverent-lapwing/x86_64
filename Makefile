%.o: %.S
	gcc -c $< -o $@ # compile every *.S file into binary form *.o

%: %.o
	gcc $< -o $@ # turn object files into executables

linking: 03.o 04_strlen.o
	gcc 03.o 04_strlen.o -o $@ # builds "linking" executable from 03.o (contains main) and 04_strlen.o (contains strlen)

stack: 05.o 05_print.o 04_strlen.o
	gcc -no-pie 05.o 05_print.o 04_strlen.o -o $@ 

# list of executables we want to create - automake will use the rules above to figure out the steps for creating them
all: 01 02 03 linking stack
