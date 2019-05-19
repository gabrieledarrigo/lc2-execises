;**************************************************************************
; SOTTOPROGRAMMA DI CONTEGGIO DEL NUMERO DI VALORI MINORI, UGUALI E MAGGIORI
; DI UN VALORE PASSATO IN INGRESSO
;
; INPUT R0 = indirizzo inizio sequenza di numeri (0 terminatore)
; R1 = valore da confrontare
; OUTPUT R0 = conteggio dei numeri minori del valore di confronto
; R1 = conteggio dei numeri minori del valore di confronto
; R2 = conteggio dei numeri minori del valore di confronto
;**************************************************************************

	.orig x3000

	AND R0, R0, #0
	AND R1, R1, #0
	LEA R0, ptr	; Carico in R0 l'indirizzo della prima cella di memoria della sequenza
	LD R1, num	; Carico in R1 il numero da confrontare
	JSR COUNT	; Salto alla subroutine
	TRAP x25
	
; Salvo il valore dei registri
COUNT	
	ST R3, saveR3
	ST R4, saveR4
	ST R5, saveR5
	
; Inizializzo i registri necessari	
	AND R3, R3, #0	; Contatore numeri minori
	AND R4, R4, #0	; Contatore numeri uguali
	AND R5, R5, #0	; Contatore numero maggiori
	NOT R1, R1
	ADD R1, R1, #1	; R1 = -R1 in modo da utilizzarlo per i confronti

; Inizio il confronto
loop	LDR R2, R0, #0	; Carico il primo valore
	BRZ exit	; Se il valore � 0 esco dal ciclo
	ADD R2, R2, R1	; R2 = R2 - R1 effettuo il confronto sommando i due valori
	BRN lower	; Se il risultato � negativo il numero della sequenza � minore
	BRZ equal	; Se il risultato � 0 i numeri sono uguali
	BRP greater	; Se il risultato � positivo il numerio della sequenza � maggiore

lower	ADD R3, R3, #1	; Incremento il contatore dei numeri minori trovati
	BRNZP next

equal	ADD R4, R4, #1	; Incremento il contatore dei numeri uguali trovati
	BRNZP next

greater	ADD R5, R5, #1	; Incremento il contatore dei numeri maggiori trovati
	BRNZP next

next	ADD R0, R0, #1	; Incremento il contatore del ciclo ed effettuo un'alta iterazione
	BRNZP loop

; Salvo i valori trovati
exit	ADD R0, R3, #0
	ADD R1, R4, #0
	ADD R2, R5, #0

; Ripristino i registri e torno dalla subroutine
	LD R3, saveR3
	LD R4, saveR4
	LD R5, saveR5
	RET

ptr	.blkw #7
num	.fill #-12 

saveR3	.blkw #1
saveR4	.blkw #1	
saveR5	.blkw #1	

	.end