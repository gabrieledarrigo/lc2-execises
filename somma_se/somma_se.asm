;*****************************************************************
;
; PROGRAMMA DI CONTEGGIO E SOMMA DEI NUMERI UGUALI AL NUMERO N DATO
;
; INPUT R0 = indirizzo inizio primo array (0 terminatore)
; R1 = indirizzo inizio secondo array
; R2 = numero N
;
; OUTPUT R0 = somma dei numeri del secondo array in corrispondenza
; delle posizioni di N nel primo array
;
;*****************************************************************

	.orig x3000;
	LEA R0, ptr1
	LEA R1, ptr2
	LD R2, num
	JSR sum_se
	TRAP x25
	
; Salvo il valore dei registri
sum_se	ST R3, saveR3

; Inizializzo i registri necessari
	AND R3, R3, #0	; R3 = 0, contiene la sommatoria
	NOT R2, R2
	ADD R2, R2, #1	; R2 = -R2 in modo da effettuare il confronto

; Inizio il ciclo per trovare le posizioni uguali
loop	LDR R4, R0, #0	; Carico il valore del primo array
	BRZ finish	; Se il valore � zero esco
	ADD R4, R4, R2	; R4 = R4 - R2
	BRZ found	; Se il risultato � 0 ho trovato il numero
	BRNZP next	; Viceversa continuo il ciclo	

; Ho trovato il numero nel primo array
found	LDR R5, R1, #0	; Carico il valore del secondo array 
	ADD R3, R3, R5	; Sommo il numero alla sommatoria
	BRNZP next

; Muovo gli indici alla prossima posizione degli array
next	ADD R0, R0, #1
	ADD R1, R1, #1
	BRNZP loop	; Ciclo il prossimo valore

; Ripristino i registri ed esco dalla subroutine
finish	LD R3, saveR3
	RET

saveR3	.blkw #1

ptr1	.blkw #5
ptr2	.blkw #5
num	.fill #15

	.end