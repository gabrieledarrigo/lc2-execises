.orig x3000
	AND R0, R0, x0000	; Inizializza R0
	ADD R0, R0, x0005	; R0 = 5
	AND R1, R1, x0000	; Inizializza R1
	ADD R1, R1, x000A	; R1 = 10
	AND R2, R2, x0000	; Inizializza R2
ciclo 	ADD R2, R2, R1		; R2 = R2 + R1
	ADD R0, R0, xFFFF	; R0 += xFFFF
	BRZP ciclo		; Salta a ciclo se il CC è nullo o positivo
	ST R2, ris		; Salva il risultato di R2 in ris
ris 	.BLKW 1
.end