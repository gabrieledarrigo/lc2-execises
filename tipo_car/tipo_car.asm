;*****************************************************************
; SOTTOPROGRAMMA DI ANALISI DEL TIPO DI CARATTERE ASCII RICEVUTO
;
; INPUT R0 = carattere da analizzare (codice compreso fra 0 e 127)
;
; OUTPUT R1 = tipo del carattere:
; 1 = carattere di controllo (codice minore di 32)
; 2 = cifra (codice compreso fra 48 e 57)
; 3 = lettera maiuscola (codice compreso fra 65 e 90)
; 4 = lettera minuscola (codice compreso fra 97 e 122)
; 5 = altro simbolo
;*****************************************************************
	.orig x3000

	AND R0, R0, #0	; R0 = 0
	LD R0, char	; Carica il carattere in R0
	JSR type
	TRAP x25

; Salvo il valore dei registri
type 	ST R2, saveR2

;Inizializzo i registri necessari
	AND R1, R1, #0
	AND R2, R2, #0

	NOT R0, R0
	ADD R0, R0, #1	; R0 = -R0 per effettuare confronti
	
; Controllo se � un carattere
	LD R2, ctrl
	ADD R2, R2, R0	; R2 = R2 - R0		
	BRZP control

	LD R2, zero
	ADD R2, R2, R0	; R2 = R2 - R0		
	BRP other

; Controllo se � un numero
	LD R2, nine
	ADD R2, R2, R0	; R2 = R2 - R0	
	BRZP number

	LD R2, lowerA
	ADD R2, R2, R0	; R2 = R2 - R0	
	BRP other

; Controllo se � una lettera minuscola
	LD R2, lowerZ
	ADD R2, R2, R0	; R2 = R2 - R0	
	BRZP lower

	LD R2, upperA
	ADD R2, R2, R0	; R2 = R2 - R0	
	BRP other

; Controllo se � una lettera maiuscola
	LD R2, upperZ
	ADD R2, R2, R0	; R2 = R2 - R0	
	BRZP upper
	BRNZP other	; E' qualcos'altro?


control	ADD R1, R1, #1 	; Trovato un carattere di controllo
	BRNZP exit

number	ADD R1, R1, #2	; Trovato un numero
	BRNZP end

lower	ADD R1, R1, #3	; Trovata una lettera minuscola
	BRNZP exit

upper	ADD R1, R1, #4	; Trovata una lettera maiuscola
	BRNZP exit

other	ADD R1, R1, #5	; Trovata un altro carattere
	BRNZP exit

exit	LD R2, saveR2
	ret

ctrl	.fill #31
zero	.fill #48
nine	.fill #57
upperA	.fill #54
upperZ	.fill #90
lowerA	.fill #97
lowerZ	.fill #122

saveR2	.blkw #1
char 	.blkw #1
	.end