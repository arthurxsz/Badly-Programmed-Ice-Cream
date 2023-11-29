###############################################
#  Program for playing music		      #
#  ISC Set 2021				      #
#  Ruan Petrus Alves Leite		      #
###############################################

#This program is a non_stop implementation of a music player
#Play the music of the adress in s4.
#The default value is a back_ground music played in loop
#If you want play sound effects just change s4 to the sound effects adress

#Instructions:
	#Set the default bg music	(1)
	#Call ST_MUS before game loop	(2)
	#Call P_MUS inside game loop	(3)
	#Change s4 to a new music adress to change music:
	#EX:
		#	la t0, D_BG_MUSIC	(1)
		#	la t1, M_BG		(1)
		#	sw t1, 0(t0)		(1)
		#	jal a0, ST_MUS		(2)
		#LOOP:	P_MUS			(3)
		#	j LOOP

.data
D_BG_MUSIC:	.word 0		#Store de adress of the Default back ground music

.text		
#Play Music
P_MUS:	lw t0, 12(s4)		#t0 = last_played
	beq t0, zero, P_CONT	#if last played == 0 THEN continue loop (firt ocurrence)
	
	csrr t1, time		#t1 = current time
	lw t2, 16(s4)		 #t2 = last_note_duration

	sub t0, t1, t0		#t0 = current time - last played note time
	bge t0, t2, P_CONT	#if t0 > last nome duration play next note
	ret

#LOOP thrue notes
P_CONT: lw t0, 8(s4)		#t0 = note_conter
	lw t1, 4(s4)		#t1 = music num

	bne t0,t1, P_NOTE	#If t0 != t1 play note
	
	li t2, 0		#t2 = 0
	sw t2,8(s4)		#store 0 in note conter
	
	jal a0,ST_MUS		#Set Defalt value
	ret			#Return to main LOOP
	
#Play the note
P_NOTE:	lw t0, 8(s4)		#t0 = Note conter
	li t1, 8		#t1 = 8
	mul t1, t1, t0		#t1 = t0 * 8
	lw t2, 0(s4)		#t2 = notes adress
	add t1, t2, t1		#Adress of the right note
	
	lw a2, 20(s4)		#Read the instrument number
	lw a3, 24(s4)		#Read the volume
	lw a0, 0(t1)		#Read the value of the note
	lw a1, 4(t1)		#Read the duration of the note

	sw a1, 16(s4)		#Store the value of the last duration
	
	li a7, 31		#Define the syscall
	ecall			#Play the note
	
	
	
	csrr t3, time		#t3 = current time
	sw t3, 12(s4)		#Store the current time in last played
	
	addi t0,t0,1		#Add 1 to conter
	sw t0,8(s4)		#Store the conter in conter		
	ret

#Set back to the back_ground_music
ST_MUS:	la t0, D_BG_MUSIC
	lw s4, 0(t0)	
	jr a0
