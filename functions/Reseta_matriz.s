Reseta_matriz: 
		la t0, level1
		la t1, level1_mutavel
		li t3, 0
		li t4, 300
		
Loop_matriz:
		addi t3, t3, 1
		lb t2, 0(t0)
		sb t2, 0(t1)
		addi t0, t0, 1
		addi t1, t1, 1
		
		beq t3, t4, Fim_matriz
		j Loop_matriz

Fim_matriz: 		ret