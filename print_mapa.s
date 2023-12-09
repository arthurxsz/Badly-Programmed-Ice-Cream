.data

.include "levelInformation/level1/level1.data"
br: .string "\n"


.text
	la t0, level1
	li t2, 0
	li t3, 300
	li t4, 20
	
Loop:	addi t2, t2, 1
	lbu a0, (t0)
	call Print
	beq t2, t3, Fim
	
	j Loop
	
	
Print:	
	li a7, 1
	ecall
	addi t0, t0, 1
	
	rem t5, t2, t4
	beqz t5, Br
	
	ret

Fim: 	li a7, 10
	ecall
	
Br: 	la a0, br
	li a7, 4
	ecall
	ret
	