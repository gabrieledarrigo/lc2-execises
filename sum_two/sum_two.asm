; Somma di due numeri

.orig x3000		;Inizia in zona di memoria x3000
LD R1, num1
LD R2, num2
ADD R0,R1,R2

TRAP X21
TRAP x25

num1 .fill #1
num2 .fill #1
.end

