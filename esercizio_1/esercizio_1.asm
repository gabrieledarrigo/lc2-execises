	.orig x3000

	LEA R0, array		; Carico in R0 il puntatore ad array
	AND R1, R1, x0000	; Azzero R1
	AND R2, R2, x0000	; Azzero R2, contiene la somma degli elementi positivi
	AND R3, R3, x0000	; Azzero R3, contiene la somma degli elementi negativi

loop	LDR R1, R0, x0000	; Primo valore di R0 caricato in R1
	BRZ finish		; Se il valore è 0 esci
	AND R1, R1, R1		; AND di R1 con se stesso per controllare se è positivo o negativo	
	BRP incp		; Se positivo incremento la somma dei positivi
	BRN incn		; Se negativo incrementa la somma dei negativi
	
incp	ADD R2, R2, x0001
	ADD R0, R0, x0001	; Incremento il contatore
	BRNZP loop		; Itera sul prossimo numero

incn	ADD R3, R3, x0001	
	ADD R0, R0, x0001	; Incremento il contatore
	BRNZP loop		; Itera sul prossimo numero

finish	ST R2, countp		; Salvo il valore di R2 nella cella di memoria riservata
	ST R3, countn		; Salvo il valore di R3 nella cella di memoria riservata

array 	.blkw #5
	.fill #0

countp	.blkw #1
	.fill x0000

countn	.blkw #1
	.fill x0000

.end