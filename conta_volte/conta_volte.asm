;*****************************************************************************
; SOTTOPROGRAMMA DI CONTEGGIO DEL NUMERO DI VOLTE IN CUI UNA CERTA LETTERA
; COMPARE IN UNA STRINGA (SIA MAIUSCOLA SIA MINUSCOLA)
;
; INPUT R0 = indirizzo inizio stringa di testo (0 terminatore)
; R1 = lettera minuscola di cui contare le occorrenze
; OUTPUT R0 = conteggio del numero di volte in cui la lettera compare MAIUSCOLA
; R1 = conteggio del numero di volte in cui la lettera compare minuscola
;*****************************************************************************

	.orig X3000

	AND R0, R0, x0000	; R0 = 0
	AND R1, R1, x0000	; R1 = 0
	LD  R0, ptr		; Carico la frase
	LD  R1, char		; Carico il valore della lettera minuscola
	JSR count
	TRAP x25
	
; Salvo i registri
count	ST R2, saveR2
	ST R3, saveR3
	ST R4, saveR4

; Inizializzo i registri necessari
	NOT R1, R1		; Nego R1
	ADD R1, R1, x0001	; R1 = - R1 per effettuare confronti
	AND R2, R2, x0000	; R2 = 0, contatore minuscole
	AND R3, R3, x0000	; R3 = 0, contatore maiuscole
	LD  R4, diff		; Carico il valore x20

loop	LDR R5, R0, #0		; carico in R5 il primo carattere della stringa
	BRZ exit
	ADD R5, R5, R1		; Se R5 - R1 = 0 la lettera è minuscola
	BRZ lower
	ADD R5, R5, R4		; Se R5 - x20 = 0 la lettera è maiuscola
	BRZ upper
	
inc	ADD R0, R0, #1		; Incremento il contatore
	BRNZP loop
	
lower	ADD R2, R2, x0001	; Incremento di 1 il contatore delle minuscole
	BRNZP inc

upper	ADD R3, R3, x0001	; Incremento di 1 il contatore delle maiuscole
	BRNZP inc

exit	ADD R0, R2, x0000	; Salvo il numero di maiuscole trovate
	ADD R1, R3, x0000	; Salvo il numero di minuscole trovate
	LD R2, saveR2		; Ristoro il valore dei registri e torno
	LD R3, saveR3
	RET

diff	.fill x20

saveR2	.blkw #1
saveR3  .blkw #1
saveR4	.blkw #1

ptr	.fill string
char	.fill x63
string 	.stringz "coCCo"
	.end