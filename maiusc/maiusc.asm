;************************************************************
;
; PROGRAMMA DI CONVERSIONE DI UNA STRINGA IN LETTERE MAIUSCOLE
;
; INPUT R0 = indirizzo inizio stringa
;
; OUTPUT R0 = conteggio delle lettere sostituite
;
;************************************************************
	.orig x3000
	LD R0, ptr
	JSR upper
	TRAP x25

; Salvo il valore dei registri
upper	ST R1, saveR1
	ST R2, saveR2
	ST R3, saveR3
	ST R4, saveR4
	ST R5, saveR5

; Inizializzo i registri
	AND R1, R1, #0	; R0 = 0, contatore lettere maiuscole trovate
	LD R2, lowerA	; codifica lettera minuscola a
	LD R3, lowerZ	; codifica lettera minuscola z
	LD R4, diff	; differenza minuscola - maiuscola

; Inizio il ciclo
loop	LDR R5, R0, #0
	BRZ finish	; Se il carattere � zero, esci
	ADD R6, R5, R2	; Confronta con lettera minuscola a
	BRN next	; Se R5 - 97 � negativo non ho trovato una lettera minuscola
	ADD R6, R5, R3	; Confronta con lettera minuscola z
	BRP next	; Se R5 - 122 � positivo non ho trovato una lettera minuscola
	BRNZP found	; In ogni altro caso ho trovato una minuscola

; Lettera minuscola trovata
found	ADD R1, R1, #1	; Incremento il contatore delle lettere da sostituire
	ADD R5, R5, R4	; Converto in maiuscola sommando il valore -32
	STR R5, R1, #0	; Scrivo il valore nella cella R0[i]
	BRNZP next

; Incremento l'indice
next	ADD R0, R0, #1	
	BRNZP	loop	; Esegui nuovamente il ciclo


; Fine della subroutine
finish 	ADD R0, R1, #0	; Salvo il conteggio
	LD R1, saveR1	; Ripristino i registri
	LD R2, saveR2
	LD R2, saveR3
	LD R4, saveR4
	LD R5, saveR5
	RET		; Esci dalla subroutine	

lowerA	.fill -97
lowerZ	.fill -122
diff	.fill -32

saveR1	.blkw #1
saveR2	.blkw #1
saveR3	.blkw #1
saveR4	.blkw #1
saveR5	.blkw #1

ptr	.fill string
string	.stringz "La sigla USA significa United States of America"
	.end