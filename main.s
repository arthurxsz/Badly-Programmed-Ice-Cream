.data

#### Definindo player ######
CHAR_POS:	.half 80,16		# x, y
OLD_CHAR_POS:	.half 80,16		# x, y

.include "functions/print_score.s"

#####################################################
#		 Map and Player state		    #
#####################################################

playerstate: .word 0 # 0, 1, 2, 3 para as diferentes posicoes

# TAMANHO DO MAPA
mapwidth: .word	20
mapheight: .word 15

# Carregando Levels (Registradores)
# INFO:
# s2 => contador de coletaveis
# s3 => numero de coletaveis max
# s5 => identificador de nivel

.text
#############################
#		    MENU            #
#############################

		la a0, menu
		li a1, 0
		li a2, 0
		li a3, 0
		call Print
	
MENU_LOOP:
		call KEY2	
		j MENU_LOOP
	
KEY2:		
		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM2   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'1'
		beq t2,t0,SETUP_L1		# se tecla pressionada for '1', vai para o SETUP do main
		
		li t0,'2'
		beq t2,t0,EXIT			# se tecla pressionada for '2', sai do programa
	
FIM2:		ret				# retorna


##############################
#		SETUP LEVELS        #
##############################
SETUP_L1:
		call Reseta_matriz
		li s3, 8 # numero de coletaveis na fase
		li s2, 0 # reinicia/inicializa o contador de coletaveis	
		la s4, level1_mutavel # carrega informacoes do nivel 1
		li s5, 0 # identificador de nível

		# esse setup serve pra desenhar o "mapa" nos dois frames antes do "jogo" comecar

		la a0, mapa1 # carrega o endereco do mapa em a0
		li a3, 0 # carrega o frame 0 em a3
		call Print # imprime o mapa
		li a3, 1 # carrega o frame 1 em a3
		call Print # imprime o mapa
		la a0, Count00 # carrega pontuacao 00
		li a1, 16 # posicao x
		li a2, 64 # posicao y
		li a3, 0 # frame 0
		call Print # imprime pontuacao
		li a3, 1 # frame 1
		call Print # imprime pontuacao

		j GAME_LOOP # vai para o loop principal


SETUP_L2:

		li s2, 0 # reinicia/inicializa o contador de coletaveis
		li s3, 15 # numero de coletaveis na fase
		la s4, level2 # carrega informacoes do nivel 1
		li s5, 1 # identificador de nível

		# esse setup serve pra desenhar o "mapa" nos dois frames antes do "jogo" comecar
		la a0, mapa2 # carrega o endereco do mapa em a0
		li a1, 0
		li a2, 0
		li a3, 0
		li a3, 0 # carrega o frame 0 em a3
		call Print # imprime o mapa
		li a3, 1 # carrega o frame 1 em a3
		call Print # imprime o mapa
		la a0, Count00 # carrega pontuacao 00
		li a1, 16 # posicao x
		li a2, 64 # posicao y
		li a3, 0 # frame 0
		call Print # imprime pontuacao
		li a3, 1 # frame 1
		call Print # imprime pontuacao

		li t6, 96              # Carrega o valor 96 para t6
		# Modifica o valor em CHAR_POS
		la t0, CHAR_POS        # Carrega o endere�o de CHAR_POS em t0
		sh t6, 0(t0)           # Armazena o valor 96 no primeiro half-word de CHAR_POS
		sh t6, 2(t0)           # Armazena o valor 96 no segundo half-word de CHAR_POS
		
		# Modifica o valor em OLD_CHAR_POS
		la t0, OLD_CHAR_POS    # Carrega o endere�o de OLD_CHAR_POS em t0
		sh t6, 0(t0)           # Armazena o valor 96 no primeiro half-word de OLD_CHAR_POS
		sh t6, 2(t0)           # Armazena o valor 96 no segundo half-word de OLD_CHAR_POS

		j GAME_LOOP # vai para o loop principal


##############################
#		LOOP PRINCIPAL      #
##############################

GAME_LOOP:	
		call KEY			# chama o procedimento de entrada do teclado
		PRINT_SCORE()	 # chama macro da pontuacao
		xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
		
		
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		
		# printando jogador na tela (com base no frame atual)

		lw t2, playerstate
		li t3, 4
		mul t2,t2,t3			# t2 recebe o endere�o correto do player_state_sprite
		la t1, player_state_sprite	# player_state_sprite cont�m todos os sprites de movimenta��o 
		add t1, t1, t2			# t1 � o endere�o do sprite a ser impresso	
		lw a0, 0(t1)			# carrega o endereco do sprite 'char' em a0
		lh a1,0(t0)			# carrega a posicao x do personagem em a1
		lh a2,2(t0)			# carrega a posicao y do personagem em a2
		mv a3,s0			# carrega o valor do frame em a3
		call Print			# imprime o sprite
		
		li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
		sw s0,0(t0)			# mostra o sprite pronto para o usuario
		

		#####################################
		# Limpeza do "rastro" do personagem #
		#####################################
		la t0,OLD_CHAR_POS		# carrega em t0 o endereco de OLD_CHAR_POS
		
		la a0,snow			# carrega o endereco do sprite 'tile' em a0
		lh a1,0(t0)			# carrega a posicao x antiga do personagem em a1
		lh a2,2(t0)			# carrega a posicao y antiga do personagem em a2
		
		mv a3,s0			# carrega o frame atual (que esta na tela em a3)
		xori a3,a3,1			# inverte a3 (0 vira 1, 1 vira 0)
		call Print			# imprime
		xori a3,a3,0
		call Print

		j GAME_LOOP			# continua o loop


GAME_OVER: 
	la a0, GameOver # carrega o endereco do sprite 'lost' em a0
	li a1, 0  # posicao x
	li a2, 0 # posicao y
	mv a3, s0  # frame atual
	call Print # imprime o sprite
	
	# Reset da Fase
	li a0, 4000 # delay
	li a7, 32 # syscall de delay
	ecall # delay

	li t6, 80              # Carrega o valor 96 para t6
	# Modifica o valor em CHAR_POS
	la t0, CHAR_POS        # Carrega o endere�o de CHAR_POS em t0
	sh t6, 0(t0)           # Armazena o valor 96 no primeiro half-word de CHAR_POS
	li t6, 16
	sh t6, 2(t0)           # Armazena o valor 96 no segundo half-word de CHAR_POS
	
	# Modifica o valor em OLD_CHAR_POS
	li t6, 80
	la t0, OLD_CHAR_POS    # Carrega o endere�o de OLD_CHAR_POS em t0
	sh t6, 0(t0)           # Armazena o valor 96 no primeiro half-word de OLD_CHAR_POS
	li t6, 16
	sh t6, 2(t0)           # Armazena o valor 96 no segundo half-word de OLD_CHAR_POS

	
	li s11, 0 # reinicia o contador de coletaveis
	beq s5, s11, SETUP_L1 # reinicia a fase 1
	j SETUP_L2 # reinicia a fase 2	

EXIT:	li a7, 10
		ecall

.include "functions/Print.s"
.include "functions/Movement.s"
.include "functions/Reseta_matriz.s"


.data
.include "sprites/mapa/mapa1.data"
.include "sprites/mapa/mapa2.data"
.include "sprites/mapa/snow.data"
.include "src/animation.data"

# sprites pontos
.include "sprites/mapa/Count00.data"
.include "sprites/mapa/Count10.data"
.include "sprites/mapa/Count20.data"
.include "sprites/mapa/Count30.data"
.include "sprites/mapa/Count40.data"
.include "sprites/mapa/Count50.data"
.include "sprites/mapa/Count60.data"
.include "sprites/mapa/Count70.data"
.include "sprites/mapa/Count80.data"
.include "sprites/mapa/Count90.data"
.include "sprites/mapa/Count100.data"
.include "sprites/mapa/Count110.data"
.include "sprites/mapa/Count120.data"
.include "sprites/mapa/Count130.data"
.include "sprites/mapa/Count140.data"
.include "sprites/mapa/Count150.data"

.include "sprites/victory.data"

# sprites coletaveis

.include "sprites/mapa/grape.data"
.include "sprites/mapa/apple.data"

.include "sprites/menu.data"
.include "sprites/GameOver.data"

.include "levelInformation/level1/level1.data"
.include "levelInformation/level2/level2.data"
.include "levelInformation/level1/level1_mutavel.data"

# inimigo

# .include "functions/inimigo.s"
