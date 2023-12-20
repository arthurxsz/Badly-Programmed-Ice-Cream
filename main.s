.data
CHAR_POS:	.half 80,16		# x, y
OLD_CHAR_POS:	.half 80,16		# x, y

.include "functions/print_score.s"

#####################################################
#		 VARIAVEIS GLOBAIS		    #
#####################################################

playerstate: .word 0 # 0, 1, 2, 3 para as diferentes posi��es

# TAMANHO DO MAPA
mapwidth: .word	20
mapheight: .word 15
#####################################################
#		 PROGRAMA INCLUI		    #
#####################################################


.text
SETUP_L1:
		li s3, 8 # numero de coletaveis
		li s2, 0 # reinicia o contador de coletaveis	
		la s4, level1 # carrega informacoes do nivel 1
		li s5, 0 # identificador de nível

		# esse setup serve pra desenhar o "mapa" nos dois frames antes do "jogo" comecar

		la a0, mapa1
		li a3, 0
		call Print
		li a3, 1
		call Print
		la a0, Count00
		li a1, 16
		li a2, 64
		li a3, 0
		call Print
		li a3, 1
		call Print

		j GAME_LOOP

GAME_LOOP:	
		call KEY			# chama o procedimento de entrada do teclado
		PRINT_SCORE()	
		xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
		
		
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		
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
		
.include "functions/Print.s"
.include "functions/Movement.s"


.data
.include "sprites/mapa/mapa1.data"
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

# sprites coletaveis

.include "sprites/mapa/grape.data"
.include "sprites/mapa/apple.data"

.include "sprites/menu.data"

.include "levelInformation/level1/level1.data"
