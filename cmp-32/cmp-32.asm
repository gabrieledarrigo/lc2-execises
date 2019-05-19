;
; Programma per il confronto di due numeri interi a 32 bit, in valore assoluto
;
; Output:	R2 = -1 se primo numero < secondo numero
;		R2 = 0	se primo numero = secondo numero
;		R2 = +1	se primo numero > secondo numero
;
	.orig	x3000
	LD	R0,mswnum1
	LD	R1,mswnum2
	JSR	cmp16
	AND	R2,R2,R2
	BRP	pgt
	BRN	plt
	LD	R0,lswnum1
	LD	R1,lswnum2
	JSR	cmp16
	BRP	pgt
	BRN	plt
	BRZ	equ
pgt	AND	R2,R2,#0
	ADD	R2,R2,#1
	TRAP	x25
equ	AND	R2,R2,#0
	TRAP	x25
plt	AND	R2,R2,#0
	ADD	R2,R2,#-1
	TRAP	x25

mswnum1	.blkw	1
lswnum1	.blkw	1
mswnum2	.blkw	1
lswnum2	.blkw	1

; Routine per il confronto di due numeri in valore assoluto a 16 bit
;
; Input:	R0 = primo numero
;		R1 = secondo numero
;
; Output:	R2 = -1 se primo numero < secondo numero
;		R2 = 0	se primo numero = secondo numero
;		R2 = +1	se primo numero > secondo numero
;
cmp16	AND	R2,R2,#0
	AND	R0,R0,R0
	BRN	pneg
	AND	R1,R1,R1	; qui primo numero positivo
	BRN	pgts		; se secondo negativo, primo > secondo
	BRZP	conc		; salta a esaminare numeri concordi
pneg	AND	R1,R1,R1	; qui primo numero negativo
	BRZP	plts		; se secondo positivo, primo < secondo
	BRN	conc		; salta a esaminare numeri concordi
conc	NOT	R1,R1
	ADD	R0,R0,R1
	NOT	R0,R0
	BRN	pgts
	BRZ	peqs
	BRP	plts
plts	ADD	R2,R2,#-1
	RET
peqs	RET
pgts	ADD	R2,R2,#1
	RET

	.end
