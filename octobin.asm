;Covertion From Octal to Binary
.model small
.stack 128
.data
txt1 db 0ah, 'Octal number: $'
txt2 db 0ah, 'Binary number: $'
inp db 0
.code
main proc near
	MOV AX, @DATA
	MOV DS, AX
	MOV SI, 0
	MOV CX, 0

	MOV AH, 9
	LEA DX, TXT1
	INT 21H

	MOV AH, 1
	CALL NUM_IN

	MOV AH, 9
	LEA DX, TXT2
	INT 21H

	MOV DI, 0
	MOV AH, 2
	DEC CX
	CALL RES_OUT

	MOV AH, 4CH
	INT 21		

NUM_IN PROC
	INT 21H
	MOV INP[SI], AL
	INC CX
	INC SI
	CMP AL, 13
	JNE NUM_IN
	RET
NUM_IN ENDP

RES_OUT PROC
	MOV BL, INP[DI]
	CALL CONVERT
	INC DI
	LOOP RES_OUT
	RET
RES_OUT ENDP

CONVERT PROC
	SUB BL,48
   	SHL BL,5
    
   	MOV DH,0
    	CONV:
    	SHL BL,1
    	JC PRINT1
    	JMP PRINT0
    
    	PRINT0: 
    	MOV DL,'0'
    	INT 21H
    	INC DH
    	CMP DH,3
    	JE EXIT
    	JMP CONV
     
    	PRINT1:
    	MOV DL,'1'
    	INT 21H
    	INC DH
    	CMP DH,3
    	JE EXIT
    	JMP CONV
     
    	EXIT:
    	RET
CONVERT ENDP

MAIN ENDP

END MAIN
