all: clean
	@fasm main.asm
	@./main.exe

clean: 
	@rm -f main.exe