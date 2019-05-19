;********************************************************************
; SOTTOPROGRAMMA DI CONTEGGIO NELL'ARRAY C DELLE CIFRE NELLA STRINGA S
;
; INPUT R0 = indirizzo inizio stringa S (0 terminatore)
; R1 = indirizzo inizio array C (10 elementi)
;
; OUTPUT C contiene il conteggi delle cifre da '0' a '9' presenti in S
;********************************************************************

	.orig x3000
	LD  R0, ptr1
	LEA R1, ptr2
	JSR count
	TRAP x25

count

; Salvo il valore dei registri 
	ST R2, saveR2
	ST R3, saveR3
	ST R4, saveR4
	ST R5, saveR5

loop	LDR R2, R0, #0	; Leggo il carattere
	BRZ exit	; Se nullo esco
	LD R3, zero	; Carico il valore decimale di 0
	ADD R3, R2, R3	; Confronto col il valore decimale di 0
	BRN next	; Se l'operazione � negativa il carattere letto non � un numero

	LD R3, nine	; Carico il valore decimale di 9
	ADD R3, R2, R3	; Confronto col il valore decimale di 9
	BRP next	; Se l'operazione � positiva il carattere letto non � un numero

	BRNZP found	; Qui ho trovato un numero

; Numero trovato
found	ADD R3, R2, #0	; In R3 c'� un numero N compreso fra 0 e 9
	ADD R4, R1, R3	; Sommo all'indirizzo memorizzato in R1 il numero salvato in R3
			; in modo da portarmi alla posizione dell'array C identificata  dall'indirizzo memorizzato in R1[N]

	LDR R5, R4, #0	; Mi porto ad R1[N]
	ADD R5, R5, #1	; Incremento il valore
	BRNZP loop   	

next	ADD R0, R0, #1	; Incremento di 1 l'indice
	BRNZP loop	; Eseguo di nuovo il ciclo

; Fine della subroutine
exit	LD R2, saveR2	; Ripristino il valore dei registri
	LD R2, saveR2
	LD R4, saveR4
	LD R5, saveR5
	RET		; Esci dalla subroutine
	
saveR2	.blkw #1
saveR3	.blkw #1
saveR4	.blkw #1
saveR5	.blkw #1

zero	.fill -48
nine	.fill -57

ptr1	.fill string
ptr2	.blkw #10
string	.stringz "Oggi � il 13 settembre 2016, che si pu� scrivere anche 13/09/2016"
	.end
