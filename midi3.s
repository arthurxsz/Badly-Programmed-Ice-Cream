###############################################
#  Programa de exemplo para Syscall MIDI      #
#  ISC Abr 2018				      #
#  Marcus Vinicius Lamar		      #
###############################################

.data
# Numero de Notas a tocar
NUM: .word 51
# lista de nota,duração,nota,duração,nota,duração,...
NOTAS: 60,202,62,202,60,202,64,1418,59,202,60,202,59,811,60,405,62,405,57,202,55,202,55,2027,55,202,53,202,52,202,53,1418,56,202,57,202,59,811,64,405,59,405,62,202,60,202,60,2027,60,202,62,202,60,202,64,1418,57,202,59,202,60,405,60,405,62,811,55,405,62,405,60,405,60,1622,52,202,53,202,55,202,53,202,60,2432,52,202,53,202,55,202,53,202,62,2027,62,202,60,202,59,202,60,811

.text
	la a0, menu
	li a1, 0
	li a2, 0
	li a3, 0
	call Print


INICIO:	la s0,NUM		# define o endereço do número de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,NOTAS		# define o endereço das notas
	li t0,0			# zera o contador de notas
	li a2, 41		# define o instrumento
	li a3,80		# define o volume

LOOP:	call KEY2
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a duração da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,8		# incrementa para o endereço da próxima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP			# volta ao loop
	
KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM3  	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'1'
		beq t2,t0,SETUP			# se tecla pressionada for '1', vai para o SETUP do main
		
		li t0,'2'
		beq t2,t0,EXIT			# se tecla pressionada for '2', sai do programa
	
FIM3:		ret				# retorna

EXIT:
		li a7, 10
		ecall

.include "main.s"