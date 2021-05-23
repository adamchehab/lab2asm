all: clean
	@fasm main.asm

clean: 
	@rm -f main.exe