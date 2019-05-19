;programma che trasforma una lettera da maiuscola a minuscola
	.orig	x3000
	TRAP	x23
	LD	R1,MA2mi
	ADD	R0,R0,R1
	TRAP	x21
	TRAP	x25
MA2mi	.fill	#32
	.end