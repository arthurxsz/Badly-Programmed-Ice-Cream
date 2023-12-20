X_SCORE:	li t6, 1
		beq t6,s2, PONTOS1X

		li t6, 2
		beq t6,s2, PONTOS2X
		
		li t6, 3
		beq t6,s2, PONTOS3X
		
		li t6, 4
		beq t6,s2, PONTOS4X
		
		li t6, 5
		beq t6,s2, PONTOS5X
		
		li t6, 6
		beq t6,s2, PONTOS6X
		
		li t6, 7
		beq t6,s2, PONTOS7X
		
		li t6, 8
		beq t6,s2, PONTOS8X
		
		
	PONTOS1X:
			la a0, Count10
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS2X:
			la a0, Count20
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS3X:
			la a0, Count30
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS4X:
			la a0, Count40
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS5X:
			la a0, Count50
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS6X:
			la a0, Count60
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS7X:
			la a0, Count70
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			
	PONTOS8X:
			la a0, Count80
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			j Save_pos_horizontal
			