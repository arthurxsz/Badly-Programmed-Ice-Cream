.macro GELO()	

			li a0,25		# nota
			li a1,500			# duração
			li a2,15			# define o instrumento
			li a3,110			# define o volume
			li a7,31			# define a syscall
			ecall
			li a0,84			# nota
			li a1,200			# duração
			li a2,12			# define o instrumento
			li a3,110			# define o volume
			li a7,31			# define a syscall
			ecall

	FIM_MACRO:

.end_macro