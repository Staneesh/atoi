section .data

	helloMsg db "Hello!" , 0xA, 0x0
	helloMsgLen equ ($ - helloMsg)
	
section .bss
	userInput resb 255 	;TODO: should this reserve as much?
	
section .text
	
global _start
_start:

	push helloMsg
	push helloMsgLen

	call printString

	add esp, 4 * 2 		;pop 2 arguments from the stack

	push userInput
	push 255
	call readUserInput

	add esp, 4 * 2

	push userInput
	push 123
	call printString

	add esp, 4 * 2

	
	mov ebx, 0
	mov eax, 1
	int 0x80

printString:
	push ebp
	mov ebp, esp

	push eax
	push ebx
	push ecx
	push edx

	mov eax, 4
	mov ebx, 1
	mov ecx, [ebp + 4*3]
	mov edx, [ebp + 4*2]
	int 0x80
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	mov esp, ebp
	pop ebp
	ret

readUserInput:
	push ebp
	mov ebp, esp

	push eax
	push ebx
	push ecx
	push edx

	mov eax, 3
	mov ebx, 0
	mov ecx, [ebp + 4 * 3]
	mov edx, [ebp + 4 * 2]
	int 0x80
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	mov esp, ebp
	pop ebp

	ret

