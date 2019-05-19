; Scrivere in Assembler LC-2 un sottoprogramma 
; che riceve nei registri R0 e R1 due numeri a 16 bit in complemento a due, 
; effettua la somma R0 + R1 e la restituisce nel registro R0 al programma chiamante, 
; segnalando se il risultato è corretto (R1 = 0) se si è verificato overflow (R1 = 1) oppure underflow (R1 = -1).
; Se il sottoprogramma richiede l'utilizzo di altri registri, fare in modo che i valori presenti all'inizio del sottoprogramma vengano ripristinati.	

; MAIN PROGRAM

	.orig x3000
	AND R0, R0, x0000	; R0 = 0
	AND R1, R1, x0000	; R1 = 0
	LD  R0, first		; Carico il primo numero
	LD  R1, second		; Carico il secondo numero
	JSR sum

sum	ST R2, saveR2		; Salvo il valore di R2
	ST R3, saveR3		; Salvo il valore di R3
	AND R2, R2, x0000	; R2 = 0, conterrà la somma di R0 + R1
	AND R3, R3, x0000	; R3 = 0, conterrà l'esito della somma
	AND R0, R0, R0		; Controllo il segno di first
	BRP nump		; Numero positivo trovato
	BRN numn		; Numero negativo trovato	

nump 	AND R1, R1, R1		; Controllo il segno di second
	BRP sump		; Se anch'esso positivo salto a sump
	ADD R2, R0, R1		; I due numeri sono discordi, li sommo
	BRNZP correct

numn	AND R1, R1, R1		; Controllo il segno di second
	BRN sumn		; Se anch'esso negativo salto a sumn
	ADD R2, R0, R1		; I due numeri sono discordi, li sommo
	BRNZP correct

sump	ADD R2, R0, R1		; R2 = R0 + R1
	BRN over		; Se il risultato è negativo c'è stato overflow
	BRNZP correct		; Altrimenti il risultato è corretto

sumn	ADD R2, R0, R1		; R2 = R0 + R1
	BRP under		; Se il risultato è positivo c'è stato underflow
	BRNZP correct		; Altrimenti il risultato è corretto

over	ADD R3, R3, #1		; Salvo 1 per segnalare l'overflow
	BRNZP finish

under 	ADD R3, R3, #-1		; Salvo -1 per segnalare l'underflow
	BRNZP finish

correct ADD R3, R3, #0		; Salvo 0 per segnalare il risultato corretto
	BRNZP finish		

finish	ADD R0, R2, x0000	; Carica il risultato della somma in R0
	ADD R1, R3, x0000	; Carica il risultato dell'operazione in R1
	LD R2, saveR2		; Ripristino il registro
	LD R3, saveR3		; Ripristino il registro	
	ret

saveR2	.blkw #1		; Zone di memoria riservata per salvare R2 all'ingresso della routine
saveR3	.blkw #1		; Zone di memoria riservata per salvare R3 all'ingresso della routine
	
first 	.fill #29
second	.fill #32
	.end