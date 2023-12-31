###########################
#   DEFINIÇÃO DE BINDS    #
###########################

KEY:		
		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'w'
		beq t2,t0,CHAR_CIMA		# se tecla pressionada for 'w', chama CHAR_CIMA
		li t0,'W'
		beq t2,t0,CHAR_CIMA		# se tecla pressionada for 'W', chama CHAR_CIMA
		
		li t0,'a'
		beq t2,t0,CHAR_ESQ		# se tecla pressionada for 'a', chama CHAR_CIMA
		li t0,'A'
		beq t2,t0,CHAR_ESQ		# se tecla pressionada for 'A', chama CHAR_CIMA
		
		li t0,'s'
		beq t2,t0,CHAR_BAIXO		# se tecla pressionada for 's', chama CHAR_CIMA
		li t0,'S'
		beq t2,t0,CHAR_BAIXO		# se tecla pressionada for 'S', chama CHAR_CIMA
		
		li t0,'d'
		beq t2,t0,CHAR_DIR		# se tecla pressionada for 'd', chama CHAR_CIMA
		li t0,'D'
		beq t2,t0,CHAR_DIR		# se tecla pressionada for 'D', chama CHAR_CIMA
		
		li t0, 'j'
		beq t2,t0,CHAR_SPEC		# se tecla pressionada for 'j', chama CHAR_SPEC
		li t0, 'J'
		beq t2,t0,CHAR_SPEC		# se tecla pressionada for 'J', chama CHAR_SPEC		
		
		li t0, 'n'
		beq t2,t0,TROCA_FASE		# se tecla pressionada for 'j', chama CHAR_SPEC
		li t0, 'N'
		beq t2,t0,TROCA_FASE		# se tecla pressionada for 'J', chama CHAR_SPEC		
			
FIM:		ret				# retorna

##############################
#        TROCA DE FASE	     #
##############################

TROCA_FASE:
	beqz s5, JUMP_LEVEL2
	j SETUP_L1
	
JUMP_LEVEL2: 
	j SETUP_L2


##############################
#   SISTEMA DE MOVIMENTAÇÃO  #
##############################

CHAR_ESQ:	la t1, playerstate
		li t2, 2
		lw t3, (t1)
		bne t3,t2, FIRST_ESQ
		sw t2, (t1)			#PLAYERSTATE 2 = ESQUERDA

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,0(t0)			# carrega o x atual do personagem
		addi t1,t1,-16			# decrementa 16 pixeis	
		
		j Colisao_horizontal
		
FIRST_ESQ:	la t1, playerstate
		li t2, 2
		sw t2, (t1)
		j NAO_MOVE_HOR

CHAR_DIR:	la t1, playerstate
		li t2, 3
		lw t3, (t1)
		bne t3,t2, FIRST_DIR
		sw t2, (t1)			#PLAYERSTATE 3 = DIREITA

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,0(t0)			# carrega o x atual do personagem
		addi t1,t1,16			# incrementa 16 pixeis
		
		j Colisao_horizontal

FIRST_DIR:	la t1, playerstate
		li t2, 3
		sw t2, (t1)
		j NAO_MOVE_HOR

CHAR_CIMA:	la t1, playerstate
		li t2, 1
		lw t3, (t1)
		bne t3,t2, FIRST_CIMA
		sw t2, (t1)			#PLAYERSTATE 1 = CIMA

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		addi t1,t1,-16			# decrementa 16 pixeis
		
		j Colisao_vertical

FIRST_CIMA:	
		la t1, playerstate
		li t2, 1
		sw t2, (t1)
		j NAO_MOVE_VER
		
NAO_MOVE_VER:	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		j Colisao_vertical
NAO_MOVE_HOR:
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,0(t0)			# carrega o y atual do personagem
		j Colisao_horizontal


CHAR_BAIXO:	la t1, playerstate
		li t2, 0
		lw t3, (t1)
		bne t3,t2, FIRST_BAIXO
		sw t2, (t1)			#PLAYERSTATE 0 = BAIXO

		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
		lw t2,0(t0)
		sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		addi t1,t1,16			# incrementa 16 pixeis	
		
		j Colisao_vertical

FIRST_BAIXO:	
		la t1, playerstate
		li t2, 0
		sw t2, (t1)
		j NAO_MOVE_VER

CHAR_SPEC:
		GELO()
		li s9, 1				# inicializa o contador
		li s8, 10
		la t1, playerstate
		lw t1, (t1)
		li t0, 0
		beq t1, t0, SPEC_BAIXO			#PLAYERSTATE 0 = BAIXO
		li t0, 1
		beq t1, t0, SPEC_UP			#PLAYERSTATE 1 = CIMA
		li t0, 2
		beq t1, t0, SPEC_LEFT			#PLAYERSTATE 2 = ESQUERDA
		li t0, 3
		beq t1, t0, SPEC_RIGHT			#PLAYERSTATE 3 = DIREITA
		ret

##############################
#   SISTEMA DE COLISÃO       #
##############################

Colisao_horizontal: 	
		mv t5, s4		# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16	
		divu t3, t1, t3			# t3 = x/16 endere�o real x no mapa
		add t5, t5, t3			# endere�o mapa + posi��o x
		li t3, 16
		lh t4, 2(t0)			# t4 = y do personagem
		divu t4, t4, t3			# t4 = y/16 endere�o real y no mapa
		li t3, 20			# t3 = 20
		mul t4, t4, t3			# t4 = t4 * 20
		add t5, t5, t4			# endere�o do mapa + posi��o y real
		lbu t4, (t5)			# t4 = byte da posi��o do personagem

		# testar as opçoes
		li t6,0
		li a2, 122			# define o instrumento
		li a3,50			# define o volume
		li a0,60			# le o valor da nota
		li a1,202 			# le a duracao da nota
		li a7,31			# define a chamada de syscall
		ecall				# toca a nota
		beq t4,t6, Save_pos_horizontal		# se o byte não for 0 não pode andar, sai, se o byte for 0, pode andar
		
		li t6, 1
		beq t4, t6, FIM			# se o byte for igual a 1 não pode andar, sai sem salvar a half
		
		li t6, 2
		beq t4, t6, Coletaveis_x		# se o byte for igual a 2 é um coletavel, pega, aumenta a pontuação e anda

		# VERIF INIMIGO
		li t6, 4
		beq t4, t6, GAME_OVER			
		
		j FIM

Save_pos_horizontal:	
		sh t1,0(t0)			# salva
		j FIM
		
Colisao_vertical:
		mv t5, s4			# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16
		divu t4, t1, t3			# t4 = y/16
		li t3, 20			# t3 = 20	
		mul t4, t4, t3			# t4 = t4 * 20 y no mapa level
		add t5, t5, t4			# endere�o do primeiro byte do mapa + y 
		li t3, 16			# t3 = 16
		lh t4, 0(t0)			# t4 = x (char_pos)	
		divu t4, t4, t3			# t4 = x/16
		add t5, t5, t4			# endere�o do mapa + x	
		lbu t4, (t5)			# t4 = byte da posi��o do personagem
		
		li t6,0
		li a2, 122			# define o instrumento
		li a3,50			# define o volume
		li a0,60			# le o valor da nota
		li a1,202 			# le a duracao da nota
		li a7,31			# define a chamada de syscall
		ecall				# toca a nota
		beq t4,t6, Save_pos_vertical	
		
		li t6,1
		beq t4, t6, FIM			# se o byte for igual a 1 não pode andar, sai sem salvar a half
		
		li t6,2
		beq t4, t6, Coletaveis_v		# se o byte for igual a 2 é um coletavel, pega, aumenta a pontuação e anda
		
		# VERIF INIMIGO
		li t6, 4
		beq t4, t6, GAME_OVER		
		
		j FIM

Save_pos_vertical:	
		sh t1,2(t0)			# salva
		j FIM
			

SPEC_BAIXO:	
		# s9 = contador
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		
		lh t1,2(t0)			# carrega o y atual do personagem
		li t4, 16
		mul t4,t4,s9
		add t1,t1,t4			# aumenta 16 pixeis	
		# T1 AGORA POSSUI A POSICAO EM Y DO BLOCO ABAIXO DO PLAYER
		mv t5, s4			# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16
		divu t4, t1, t3			# t4 = y/16 (para encontrar na matriz??)
		li t3, 20			# t3 = 20	
		mul t4, t4, t3			# t4 = t4 * 20 y no mapa level
		add t5, t5, t4			# endere�o do primeiro byte do mapa + y
		# T5 AGORA POSSUI O ENDERE�O DO BLOCO NO MAPA 
		li t3, 16			# t3 = 16
		lh t4, 0(t0)			# t4 = x (char_pos)	
		divu t4, t4, t3			# t4 = x/16
		add t5, t5, t4			# endere�o do mapa + x	
		lbu t4, (t5)			# t4 = byte da posi��o do personagem
		li t0, 1
		beq t4,t0, FIM
		beqz t4, Build_Blocks_DOWN	# se o byte for 0, construi os blocos
		li t0, 3
		beq t4, t0, Break_Blocks_DOWN
		j FIM

####################################
# SISTEMA DE COLISÃO (COLETAVEIS)  #
###################################

Coletaveis_x: #s2 = qtd de coletáveis
	li a7,31
	li a0, 60
	li a1, 150		# som de pegar coletavel
	li a2, 99
	li a3, 50
	ecall
	addi s2,s2, 1
	sb zero,0(t5)
	beq s2,s3, PROXIMA_FASE		# condição de vitória do jogador
	j Save_pos_horizontal
	
Coletaveis_v: #s2 = qtd de coletáveis
	li a7,31
	li a0, 60
	li a1, 150		# som de pegar coletavel
	li a2, 99
	li a3, 50
	ecall
	addi s2,s2, 1
	sb zero,0(t5)
	beq s2,s3, PROXIMA_FASE
	j Save_pos_vertical

PROXIMA_FASE:
	li s8, 0 # carrega no s8 valor do primeiro nivel
	beq s5, s8, SETUP_L2   # verifica se o player esta no primeiro nivel
	
	li s8, 1 # carrega no s8 valor do segundo nivel
	beq s5 , s8, WIN
	
	# # ISSO AQUI VAI VIRAR A FUNCAO DE VITORIA
	# la a0, victory # carrega o endereco do sprite 'victory' em a0
	# li a1, 0 
	# li a2, 0
	# mv a3, s0 
	# call Print
	
	# # RESET DA FASE E REPETICAO (ENQUANTO NAO TEM FASE 2)
	# li a0, 5000 # delay
	# li a7, 32 # syscall de delay
	# ecall # delay
	
	# j SETUP_L1	# PROXIMA FASE


##############################
#   SISTEMA DE ATAQUE (GELO) #
##############################

Build_Blocks_DOWN:
		li t0, 3
		beq s8,t0, FIM
		li s8, 0
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, ice 			# carrega o endereco do sprite 'block' em a0
		lh a1,0(t0)			# carrega a posicao x do PLAYER em a1
		mv a2,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_BAIXO
Break_Blocks_DOWN:
		li t0, 0
		beq s8,t0,FIM
		li s8, 3
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, snow 			# carrega o endereco do sprite 'block' em a0
		lh a1,0(t0)			# carrega a posicao x do PLAYER em a1
		mv a2,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_BAIXO

SPEC_UP:	
		# s9 = contador
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
			
		lh t1,2(t0)			# carrega o y atual do personagem
		li t4, -16
		mul t4,t4,s9
		add t1,t1,t4			# decrementa 16 pixeis * s9
		#### TESTE COMPARATIVO ####	
		# T1 AGORA POSSUI A POSICAO EM Y DO BLOCO ABAIXO DO PLAYER
		mv t5, s4			# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16
		divu t4, t1, t3			# t4 = y/16 (para encontrar na matriz??)
		li t3, 20			# t3 = 20	
		mul t4, t4, t3			# t4 = t4 * 20 y no mapa level
		add t5, t5, t4			# endere�o do primeiro byte do mapa + y
		# T5 AGORA POSSUI O ENDERE�O DO BLOCO NO MAPA 
		li t3, 16			# t3 = 16
		lh t4, 0(t0)			# t4 = x (char_pos)	
		divu t4, t4, t3			# t4 = x/16
		add t5, t5, t4			# endere�o do mapa + x	
		lbu t4, (t5)			# t4 = byte da posi��o do personagem
		############################
		li t0, 1
		beq t4,t0, FIM
		beqz t4, Build_Blocks_UP	# se o byte for 0, construi os blocos
		li t0, 3
		beq t4, t0, Break_Blocks_UP
		j FIM
		
Build_Blocks_UP:
		li t0, 3
		beq s8,t0, FIM
		li s8, 0
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, ice 			# carrega o endereco do sprite 'block' em a0
		lh a1,0(t0)			# carrega a posicao x do PLAYER em a1
		mv a2,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_UP
Break_Blocks_UP:
		li t0, 0
		beq s8,t0,FIM
		li s8, 3
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, snow 			# carrega o endereco do sprite 'block' em a0
		lh a1,0(t0)			# carrega a posicao x do PLAYER em a1
		mv a2,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_UP

SPEC_RIGHT:	
		# s9 = contador
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		lh t1,0(t0)			# t1 = POSICAO X DO PERSONAGEM
		li t4, 16
		mul t4,t4,s9
		add t1,t1,t4			# t1 posi��o x real
		#### TESTE COMPARATIVO ####
		mv t5, s4			# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16	
		divu t3, t1, t3			# t3 = x/16 endere�o real x no mapa
		add t5, t5, t3			# endere�o mapa + posi��o x
		# T5 RECEBE A POSI��O CORRETA DE X NO MAPA
		li t3, 16
		lh t4, 2(t0)			# t4 = y do personagem
		divu t4, t4, t3			# t4 = y/16 endere�o real y no mapa
		li t3, 20			# t3 = 20
		mul t4, t4, t3			# t4 = t4 * 20
		add t5, t5, t4			# endere�o do mapa + posi��o y real
		lbu t4, (t5)			# t4 = byte da posi��o do personagem
		###########################
		li t0, 1
		beq t4,t0, FIM
		beqz t4, Build_Blocks_RIGHT	# se o byte for 0, construi os blocos
		li t0, 3
		beq t4, t0, Break_Blocks_RIGHT
		j FIM
		
Build_Blocks_RIGHT:
		li t0, 3
		beq s8,t0, FIM
		li s8, 0
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, ice 			# carrega o endereco do sprite 'block' em a0
		lh a2,2(t0)			# carrega a posicao y do PLAYER em a2
		mv a1,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_RIGHT
Break_Blocks_RIGHT:
		li t0, 0
		beq s8,t0,FIM
		li s8, 3
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, snow 			# carrega o endereco do sprite 'block' em a0
		lh a2,2(t0)			# carrega a posicao y do PLAYER em a2
		mv a1,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_RIGHT

SPEC_LEFT:	
		# s9 = contador
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		lh t1,0(t0)			# t1 = POSICAO X DO PERSONAGEM
		li t4, -16
		mul t4,t4,s9
		add t1,t1,t4			# t1 posi��o x real
		#### TESTE COMPARATIVO ####
		mv t5, s4			# endere�o do primeiro byte do mapa
		li t3, 16			# t3 = 16	
		divu t3, t1, t3			# t3 = x/16 endere�o real x no mapa
		add t5, t5, t3			# endere�o mapa + posi��o x
		# T5 RECEBE A POSI��O CORRETA DE X NO MAPA
		li t3, 16
		lh t4, 2(t0)			# t4 = y do personagem
		divu t4, t4, t3			# t4 = y/16 endere�o real y no mapa
		li t3, 20			# t3 = 20
		mul t4, t4, t3			# t4 = t4 * 20
		add t5, t5, t4			# endere�o do mapa + posi��o y real
		lbu t4, (t5)			# t4 = byte da posi��o do personagem
		###########################
		li t0, 1
		beq t4,t0, FIM
		beqz t4, Build_Blocks_LEFT	# se o byte for 0, construi os blocos
		li t0, 3
		beq t4, t0, Break_Blocks_LEFT
		j FIM
		
Build_Blocks_LEFT:
		li t0, 3
		beq s8,t0, FIM
		li s8, 0
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, ice 			# carrega o endereco do sprite 'block' em a0
		lh a2,2(t0)			# carrega a posicao y do PLAYER em a2
		mv a1,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_LEFT
Break_Blocks_LEFT:
		li t0, 0
		beq s8,t0,FIM
		li s8, 3
		sb t0,(t5)
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		la a0, snow 			# carrega o endereco do sprite 'block' em a0
		lh a2,2(t0)			# carrega a posicao y do PLAYER em a2
		mv a1,t1
		mv a3,s0			# carrega o valor do frame em a3
		mv s10, ra
		call Print			# imprime o sprite
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		mv ra,s10
		addi s9,s9,1
		j SPEC_LEFT

##############################################
