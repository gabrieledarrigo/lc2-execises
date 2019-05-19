;1	
	.orig x3000
;3  a	.fill #1;DA QUI
;4  b	.fill #2
;5  c	.fill #3
;6	LD R1,a
;7	LD R2,b
;8	ADD R3,R1,R2
;9	ST R3,c;A QUI
	.stringz "Hello World!";come faccio a stampare?
	LEA R1,x00
loop	LDR R0,R1,#0
	TRAP x21
	ADD R1,R1,#1
	BRP loop
;11 var1	.fill #1;DA QUI
;12 address_var1	.blkw #1
;13	LEA R1,var1
;14	ST R1,address_var1
;15	;LD R2,var1
;16	;ADD R2,R2,#1
;17	;ST R2,var1
;18	ADD R3,R3,#2
;19	STI R3,address_var1;alternativo alle tre sopra
;20	LDI R4,x01
;   arr	.blkw #4
;   abc	.stringz "ABC"
;	;.fill abc
;	STR abc,x3000,#1
	.end