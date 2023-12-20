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

		li t6, 9
		beq t6,s2, PONTOS9

		li t6, 10
		beq t6,s2, PONTOS10

		li t6, 11
		beq t6,s2, PONTOS11

		li t6, 12
		beq t6,s2, PONTOS12

		li t6, 13
		beq t6,s2, PONTOS13

		li t6, 14
		beq t6,s2, PONTOS14

		li t6, 15
		beq t6,s2, PONTOS15
		
		
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
			li a0, 2000 # delay
 			li a7, 32 # syscall de del
			beq t6,zero,FIM_PONTOS
	
	PONTOS9:
			la a0, Count90
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS

	PONTOS10:
			la a0, Count100
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS

	PONTOS11:
			la a0, Count110
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS

	PONTOS12:
			la a0, Count120
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS

	PONTOS13:
			la a0, Count130
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS

	PONTOS14:
			la a0, Count140
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			beq t6,zero,FIM_PONTOS
	
	PONTOS15:
			la a0, Count150
			li a1, 16
			li a2, 64	
			li a3, 0
			call Print
			li a3, 1
			call Print
			li t6,0
			li a0, 2000 # delay
 			li a7, 32 # syscall de delay

			beq t6,zero,FIM_PONTOS
			
			
	FIM_PONTOS:
		
.end_macro
