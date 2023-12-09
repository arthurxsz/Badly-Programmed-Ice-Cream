KEY:		
		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'w'
		beq t2,t0,CHAR_CIMA		# se tecla pressionada for 'w', chama CHAR_CIMA
		
		li t0,'a'
		beq t2,t0,CHAR_ESQ		# se tecla pressionada for 'a', chama CHAR_CIMA
		
		li t0,'s'
		beq t2,t0,CHAR_BAIXO		# se tecla pressionada for 's', chama CHAR_CIMA
		
		li t0,'d'
		beq t2,t0,CHAR_DIR		# se tecla pressionada for 'd', chama CHAR_CIMA	
			
FIM:		ret				# retorna

CHAR_ESQ:	la t1, playerstate
		li t2, 2
		sw t2, (t1)

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,0(t0)			# carrega o x atual do personagem
		addi t1,t1,-16			# decrementa 16 pixeis	
		
		la t5, level1			# endereço do primeiro byte do mapa
		li t3, 16			# t3 = 16	
		divu t3, t1, t3			# t3 = x/16 endereço real x no mapa
		add t5, t5, t3			# endereço mapa + posição x
		li t3, 16
		lh t4, 2(t0)			# t4 = y do personagem
		divu t4, t4, t3			# t4 = y/16 endereço real y no mapa
		li t3, 20			# t3 = 20
		mul t4, t4, t3			# t4 = t4 * 20
		add t5, t5, t4			# endereço do mapa + posição y real
		lbu t4, (t5)			# t4 = byte da posição do personagem
		bnez t4, FIM			# se o byte não for 0 não pode andar, sai
		
		sh t1,0(t0)			# salva
		ret

CHAR_DIR:	la t1, playerstate
		li t2, 3
		sw t2, (t1)

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,0(t0)			# carrega o x atual do personagem
		addi t1,t1,16			# incrementa 16 pixeis
		
		la t5, level1			# endereço do primeiro byte do mapa
		lh t6, 2(t0)			# t6 = y do personagem
		li t3, 16			# t3 = 16	
		divu t3, t1, t3			# t3 = x/16 endereço real x no mapa
		add t5, t5, t3			# endereço mapa + posição x
		li t3, 16
		divu t6, t6, t3			# t6 = y/16 endereço real y no mapa
		li t3, 20			# t3 = 20
		mul t6, t6, t3			# t6 = t6 * 20
		add t5, t5, t6			# endereço do mapa + posição y real
		lbu t4, (t5)			# t4 = byte da posição do personagem
		bnez t4, FIM			# se o byte não for 0 não pode andar, sai
		
		sh t1,0(t0)			# salva
		ret

CHAR_CIMA:	la t1, playerstate
		li t2, 1
		sw t2, (t1)

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		addi t1,t1,-16			# decrementa 16 pixeis
		
		la t5, level1			# endereço do primeiro byte do mapa
		li t3, 16			# t3 = 16
		divu t4, t1, t3			# t4 = y/16
		li t3, 20			# t3 = 20	
		mul t4, t4, t3			# t4 = t4 * 20 y no mapa level
		add t5, t5, t4			# endereço do primeiro byte do mapa + y 
		li t3, 16			# t3 = 16
		lh t4, 0(t0)			# t4 = x (char_pos)	
		divu t4, t4, t3			# t4 = x/16
		add t5, t5, t4			# endereço do mapa + x	
		lbu t4, (t5)			# t4 = byte da posição do personagem
		bnez t4, FIM			# se o byte não for 0 não pode andar, sai
		
		sh t1,2(t0)			# salva
		ret

CHAR_BAIXO:	la t1, playerstate
		li t2, 0
		sw t2, (t1)

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		addi t1,t1,16			# incrementa 16 pixeis	
		
		la t5, level1			# endereço do primeiro byte do mapa
		li t3, 16			# t3 = 16
		divu t4, t1, t3			# t4 = y/16
		li t3, 20			# t3 = 20	
		mul t4, t4, t3			# t4 = t4 * 20 y no mapa level
		add t5, t5, t4			# endereço do primeiro byte do mapa + y 
		li t3, 16			# t3 = 16
		lh t4, 0(t0)			# t4 = x (char_pos)	
		divu t4, t4, t3			# t4 = x/16
		add t5, t5, t4			# endereço do mapa + x	
		lbu t4, (t5)			# t4 = byte da posição do personagem
		bnez t4, FIM			# se o byte não for 0 não pode andar, sai
		
		sh t1,2(t0)			# salva
		ret