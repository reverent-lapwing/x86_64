%.o: %.S
	gcc -c $< -o $@

%: %.o
	gcc $< -o $@

linking: 03.o 04.o
	gcc 03.o 04.o -o $@

# only executables
all: 01 02 03 linking  
