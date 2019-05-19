;******************************************************************
;
;SOTTOPROGRAMMA DI AGGIUNTA DI UNA CIFRA ASCII A UN NUMERO DECIMALE
;
; INPUT R0 = Numero N
; INPUT R1 = cifra C (compresa fra x30 ex39)
;
; OUTPUT R0 = N * 10 + val(C)
;
;******************************************************************

	.orig x3000
	LD R0, N	; Carico il numero N
	LD R1, C	; Carico la cifra C
	JSR add_digit
	TRAP x25

add_digit
; Salvo il valore dei registri	
	ST R2, saveR2
	ST R3, saveR3
	ST R4, saveR4

	AND R2, R2, #0	; R2 = 0
	ADD R2, R2, #10	; R2 = 10, contatore per effettuare la moltiplicazione

; Moltiplico N * 10
multiply
	ADD R3, R3, R0	; R3 = R3 + N, 
	ADD R2, R2, #-1	; Decremento il contatore
	BRP multiply	; Continua a moltiplicare
	BRNZ sumc

; Sommo ad N * 10 il valore di C
sumc	LD R4, char30
	NOT R4, R4
	ADD R4, R4 #1	; R4 = -30
	ADD R4, R4, R1	; R4 = val(C)
	ADD R4, R4, R3	; R4 = N * 10 + val(C)
	BRNZP exit

; Ripristino il valore dei registri
exit	ADD R0, R4, #0	; Salva il valore trovato in R0
	LD R2, saveR2
	LD R3, saveR3
	LD R4, saveR4
	RET		; Esci dalla subroutine

char30	.fill x30

saveR1	.blkw 1
saveR2	.blkw 1
saveR3	.blkw 1
saveR4	.blkw 1

N	.fill 5
C	.fill x37
	.end
	

	