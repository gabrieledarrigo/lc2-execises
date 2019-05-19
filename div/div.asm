; DIV

	.orig x3000
	LD R0, N
	LD R1, D
	JSR div
	HALT

; Subroutine
div	ST R2, saveR2	
	ST R3, saveR3
	ST R4, saveR4

	AND R2, R2, #0	; R2 = 0, lo uso per salvare il valore del quoziente Q
	ADD R3, R1, #0	; R3 = D, carico il divisore D in R3

loop	NOT R4, R3
	ADD R4, R4, #1	; R4 = -D, ovvero il divisore D con segno negativo.

	ADD R4, R0, R4	; Sottraggo il divisore D al numeratore N
	BRN found	; Se N - D < 0 allora ho trovato il quoziente Q
	ADD R2, R2, #1	; Altrimento incremento il valore del quoziente Q
	ADD R3, R3, R1	; Raddoppio il valore del divisore D salvato in R3
	BRNZP loop	; Continuo il ciclo

found	ADD R0, R2, #0	; R0 = Q
	LD R2, saveR2
	LD R3, saveR3
	LD R4, saveR4
	RET

saveR2	.blkw 1
saveR3	.blkw 1
saveR4	.blkw 1

N	.fill 100
D	.fill 6

	.end