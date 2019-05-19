;
; Program to count occurrences of a character in a string.
; Character to be input from the keyboard.
; Result to be displayed on the monitor
; String in memory, to be terminated by NULL character (x0000)
; Program works only if no more than 9 occurrences are found
;
;
; Initialization
;
	.orig	x3000
	AND	R2,R2,#0	; R2 is counter, initialize to 0
	LD	R3,ptr		; R3 is pointer to characters in the string
	TRAP	x23		; R0 gets character input
	LDR	R1,R3,#0	; R1 gets first character in string
;
; Test character for end of string
;
test	BRZ	outn		; test for NULL; if done, prepare to output
;
; Test character for match
;
	NOT	R1,R1
	ADD	R1,R1,R0	; if match, R1 = xFFFF
	NOT	R1,R1		; if match, R1 = x0000
	BRNP	getch		; if no match, skip the increment
	ADD	R2,R2,#1
;
; Get next character from string
;
getch	ADD	R3,R3,#1	; increment the pointer
	LDR	R1,R3,#0	; R1 gets next character in string
	BR	test		; loop to test character
;
; Output the count
;
outn	LD	R0,ascii	; load the ASCII template for convert
	ADD	R0,R0,R2	; convert binary to ASCII
	TRAP	x21		; ASCII code in r0 is displayed
	TRAP	x25		; Halt machine
;
; Storage for pointer, ASCII template and string
;
ascii	.fill	x0030
ptr	.fill	file
file	.stringz "QUESTA E' LA STRINGA IN CUI CERCARE I CARATTERI"

	.end
	
