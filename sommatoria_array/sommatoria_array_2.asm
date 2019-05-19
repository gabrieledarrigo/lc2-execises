; SOMMATORIA_ARRAY
	.orig x3000
	LEA R0, ptr1
	LEA R1, ptr2
	JSR sum_arr

; Salvo il valore dei registri
sum_arr	ST R2, saveR2
	ST R3, saveR3

; Inizializzo i registri
	AND R2, R2, #0	; R2 = 0
	AND R3, R3, #0	; R3 = 0

; Inizio il ciclo
loop	LDR R2, R0, #0	; Carico A[i]
	BRZ exit	; Se il numero è zero esco
	BRN neg		; Il primo numero caricato è negativo
	BRP pos		; Il primo numero caricato è positivo

neg	AND R3, R3, R3	; Verifico il segno del secondo numero
	BRN under	; Il secondo numero è negativo, ci può essere underflow
	ADD R3, R2, R3	; Il secondo numero è positivo, sommo
	STR R3, R1, #0	; Salvo la somma in R[i]
	BRNZP next

pos 	AND R3, R3, R3	; Verifico il segno del secondo numero
	BRP over	; Il secondo numero è positivo, ci può essere overflow
	ADD R3, R2, R3	; Il secondo numero è negativo sommo
	STR R3, R1, #0	; Salvo la somma in R[i]
	BRNZP next

under	ADD R3, R2, R3	; Sommo i due numeri
	BRP zero	; Se c'è underflow sommo 0
	STR R3, R1, #0	; Salvo la somma in R[i]
	BRNZP next

over 	ADD R3, R2, R3	; Sommo i due numeri
	BRN zero	; Se c'è overflow salvo 0
	STR R3, R1, #0	; Salvo la somma in R[i]
	BRNZP next

zero	AND R3, R3, #0	; R3 = 0
	STR R3, R1, #0	; Salvo la somma in R[i]
	BRNZP next

next	ADD R0, R0, #1	; Incremento la posizione del puntatore ad A
	ADD R1, R1, #1	; Incremento la posizione del puntatore ad R
	BRNZP loop	; Continuo il ciclo

exit	LD R2, saveR2
	LD R3, saveR3
	RET

saveR2	.blkw #1
saveR3	.blkw #1

ptr1	.blkw #6
ptr2	.blkw #6

	.end 