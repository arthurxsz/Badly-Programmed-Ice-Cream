.data
CHAR_POS:	.half 80,16			# x, y
OLD_CHAR_POS:	.half 0,0			# x, y

#####################################################
#		 VARIAVEIS GLOBAIS		    #
#####################################################

playerstate: # 0, 1, 2, 3 para as diferentes posições
.word 0

# TAMANHO DO MAPA
mapwidth:
.word	20
mapheight:
.word	15


#####################################################
#		 PROGRAMA INCLUI		    #
#####################################################







.text
SETUP:		#SETUP MUSICA
		la t0, D_BG_MUSIC
		la t1, M_BG
		sw t1, 0(t0)
		jal a0, ST_MUS

		la a0,mapa1			# carrega o endereco do sprite 'map' em a0
		li a1,0				# x = 0
		li a2,0				# y = 0
		li a3,0				# frame = 0
		call Print			# imprime o sprite
		li a3,1				# frame = 1
		call Print			# imprime o sprite
		# esse setup serve pra desenhar o "mapa" nos dois frames antes do "jogo" comecar

GAME_LOOP:	call KEY			# chama o procedimento de entrada do teclado
		jal P_MUS
		xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
		
		la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
		
		
		la t1, playerstate
		lw t2, 0(t1)
		li t3, 4
		mul t2,t2,t3			# t2 recebe o endereço correto do player_state_sprite
		la t1, player_state_sprite
		add t1, t1, t2
		lw a0, 0(t1)		# carrega o endereco do sprite 'char' em a0
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

		j GAME_LOOP			# continua o loop
		
.include "functions/Print.s"
.include "functions/Movement.s"
.data
.include "sprites/tile.data"
.include "sprites/player/idle/P_IDLE_FRONT1.data"
.include "sprites/player/idle/P_IDLE_FRONT2.data"
.include "sprites/mapa/mapa1.data"
.include "sprites/mapa/snow.data"
.include "src/sound.s"
.include "src/songs.data"
.include "src/animation.data"