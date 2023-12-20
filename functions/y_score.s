Y_SCORE:	li t6, 1
		beq t6,s2, PONTOS1Y

		li t6, 2
		beq t6,s2, PONTOS2Y
		
		li t6, 3
		beq t6,s2, PONTOS3Y
		
		li t6, 4
		beq t6,s2, PONTOS4Y
		
		li t6, 5
		beq t6,s2, PONTOS5Y
		
		li t6, 6
		beq t6,s2, PONTOS6Y
		
		li t6, 7
		beq t6,s2, PONTOS7Y
		
		li t6, 8
		beq t6,s2, PONTOS8Y
		
		
	PONTOS1Y:
			la a0, Count10
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS2Y:
			la a0, Count20
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS3Y:
			la a0, Count30
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS4Y:
			la a0, Count40
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS5Y:
			la a0, Count50
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS6Y:
			la a0, Count60
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS7Y:
			la a0, Count70
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
	PONTOS8Y:
			la a0, Count80
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_vertical
			
