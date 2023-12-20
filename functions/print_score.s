.macro PRINT_SCORE()	
		
		beq zero,s2,FIM_PONTOS
		
		li t6, 1
		beq t6,s2, PONTOS1

		li t6, 2
		beq t6,s2, PONTOS2
		
		li t6, 3
		beq t6,s2, PONTOS3
		
		li t6, 4
		beq t6,s2, PONTOS4
		
		li t6, 5
		beq t6,s2, PONTOS5
		
		li t6, 6
		beq t6,s2, PONTOS6
		
		li t6, 7
		beq t6,s2, PONTOS7
		
		li t6, 8
		beq t6,s2, PONTOS8
		
		
	PONTOS1:
			la a0, Count10
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS2:
			la a0, Count20
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS3:
			la a0, Count30
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS4:
			la a0, Count40
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS5:
			la a0, Count50
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS6:
			la a0, Count60
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS7:
			la a0, Count70
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	PONTOS8:
			la a0, Count80
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
			
	FIM_PONTOS:
		
.end_macro
