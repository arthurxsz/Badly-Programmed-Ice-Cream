.text
		la a0, menu
		li a1, 0
		li a2, 0
		li a3, 0
		call Print
	
MENU_LOOP:
		call KEY2	
		j MENU_LOOP
	
KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM2   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'1'
		beq t2,t0,SETUP_L1		# se tecla pressionada for '1', vai para o SETUP do main
		
		li t0,'2'
		beq t2,t0,EXIT			# se tecla pressionada for '2', sai do programa
	
FIM2:		ret				# retorna

EXIT:
		li a7, 10
		ecall
	
.include "main.s"
