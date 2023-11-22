#################################################
#	a0 = endereÃ§o imagem			#
#	a1 = x					#
#	a2 = y					#
#	a3 = frame (0 ou 1)			#
#################################################
#	t0 = endereco do bitmap display		#
#	t1 = contador de linha			#
#	t2 = contador de coluna			#
# 	t3 = largura				#
#	t4 = altura				#
#	t5 = carrega byte da imagem		#
#	t6 = endereço da imagem			#
#################################################
Print:
	li t0, 0xFF0 		# carrega 0x FF0 em t0
	add t0, t0, a3 		# adiciona o frame a FF0
	slli t0, t0, 20 	# shift de 20 bits pra esquerda
	
	add t0, t0, a1 		# adiciona x ao t0
	li t1, 320 		# t1 = 320
	mul t1, t1, a2 		# multiplica y por t1
	add t0, t0, t1 		# coloca o endereco em t0
	
	mv t1, zero 		# zera t1
	mv t2, zero 		# zera t2
	mv t6, a0 		# data em t6 para nao mudar a0
	lw t3, 0(t6) 		# carrega a largura em t3
	lw t4, 4(t6) 		# carrega a altura em t4
	addi t6, t6, 8 		# primeira cor em t6
	
PrintLinha:
	lbu t5, 0(t6) 		# carrega em t5 um byte da imagem
	sb t5, 0(t0) 		# imprime no bitmap o byte da imagem
	addi t0, t0, 1 		# incrementa endereco do bitmap
	addi t6, t6, 1 		# incrementa endereco da imagem
	addi t2, t2, 1 		# incrementa contador de coluna
	blt t2, t3, PrintLinha 	# cont da coluna < largura ?
	
	addi t0, t0, 320 	# t0 += largura do bitmap
	sub t0, t0, t3 		# t0 -= largura da imagem
	mv t2, zero 		# zera t2 ( cont de coluna )
	addi t1, t1, 1 		# incrementa contador de linha
	bgt t4, t1, PrintLinha 	# altura > contador de linha ?
	ret 			# retorna
