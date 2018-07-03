.PROG
	SETR RINT 7	# Habilita 3 interrupções
MAIN:
	CALL SUPRIMENTO:	# Carrega suprimento
	CALL CHOICE1:		# Carrega opções para validação
	CALL CHOICE2:
	CALL CHOICE3:
	CALL CHOICE4:
	CALL CHOICE5:
	CALL CHOICE6:
	CALL CHOICE7:
	CALL CHOICE8:
	CALL CHOICE9:
	CALL CHOICE10:
	CALL CHOICE11:
	CALL CHOICE12:
	CALL LECHOICE:
	CALL OK:
	JI 16
SUPRIMENTO:	# Carrega Suprimento: Açúcar, Leite, Chocolate, Café, Água	
	LDI R0 1
	STO R0 1
	LDI R0 2
	STO R0 2
	LDI R0 1
	STO R0 3
	LDI R0 2
	STO R0 4
	LDI R0 2
	STO R0 5
	RET
CHOICE1:	# Café puro pequeno sem açúcar	
	LDI R0 1
	STO R0 10
	RET
CHOICE2:	# Café puro pequeno com açúcar	
	LDI R0 9
	STO R0 11
	RET
CHOICE3:	# Café puro grande sem açúcar	
	LDI R0 17
	STO R0 12
	RET
CHOICE4:	# Café puro grande com açúcar	
	LDI R0 25
	STO R0 13
	RET
CHOICE5:	# Café com leite pequeno sem açúcar	
	LDI R0 2
	STO R0 14
	RET
CHOICE6:	# Café com leite pequeno com açúcar	
	LDI R0 10
	STO R0 15
	RET
CHOICE7:	# Café com leite grande sem açúcar	
	LDI R0 18
	STO R0 16
	RET
CHOICE8:	# Café com leite grande com açúcar	
	LDI R0 26
	STO R0 17
	RET
CHOICE9:	# Mocaccino pequeno sem açúcar	
	LDI R0 4
	STO R0 18
	RET
CHOICE10:	# Mocaccino pequeno com açúcar	
	LDI R0 12
	STO R0 19
	RET
CHOICE11:	# Mocaccino grande sem açúcar	
	LDI R0 20
	STO R0 20
	RET
CHOICE12:	# Mocaccino grande com açúcar	
	LDI R0 28
	STO R0 21
	RET
LECHOICE:	# Libera o uso das chaves deslizantes
	LDI R0 1
	OUT R0 2
	RET
PREPARA1:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 5			# Água
	JZ R0 MISS:		# Se Água = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 5			# Água
	SUB R2 R0 R1	# Subtrai Água
	STO R2 5		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	JI 16
PREPARA2:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 5			# Água
	JZ R0 MISS:		# Se Água = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 5			# Água
	SUB R2 R0 R1	# Subtrai Água
	STO R2 5		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA3:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 5			# Água
	JZ R0 MISS:		# Se Água = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 5			# Água
	SUB R2 R0 R1	# Subtrai Água
	STO R2 5		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 10 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA4:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 5			# Água
	JZ R0 MISS:		# Se Água = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 5			# Água
	SUB R2 R0 R1	# Subtrai Água
	STO R2 5		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA5:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA6:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA7:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 10 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA8:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 10 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA9:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 3			# Chocolate
	JZ R0 MISS:		# Se Chocolate = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 3			# Chocolate
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Chocolate
	STO R2 3		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA10:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 3			# Chocolate
	JZ R0 MISS:		# Se Chocolate = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 3			# Chocolate
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Chocolate
	STO R2 3		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 5		# 5 Segundos
	OUT R0 1		# Escreve 5 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA11:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 3			# Chocolate
	JZ R0 MISS:		# Se Chocolate = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 3			# Chocolate
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Chocolate
	STO R2 3		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 10 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
PREPARA12:
	LD R0 4			# Café
	JZ R0 MISS:		# Se Café = 0 Salta para MISS
	LD R0 2			# Leite
	JZ R0 MISS:		# Se Leite = 0 Salta para MISS
	LD R0 3			# Chocolate
	JZ R0 MISS:		# Se Chocolate = 0 Salta para MISS
	LD R0 1			# Açúcar
	JZ R0 MISS:		# Se Açúcar = 0 Salta para MISS
	LD R0 4			# Café
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Café
	STO R2 4		# Armazena novo valor
	LD R0 2			# Leite
	SUB R2 R0 R1	# Subtrai Leite
	STO R2 2		# Armazena novo valor
	LD R0 3			# Chocolate
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Chocolate
	STO R2 3		# Armazena novo valor
	LD R0 1			# Açúcar
	LDI R1 1		# Carrega 1 para subtrair
	SUB R2 R0 R1 	# Subtrai Açúcar
	STO R2 1		# Armazena novo valor
	LDI R0 10		# 10 Segundos
	OUT R0 1		# Escreve 10 em i_TIME
	LDI R0 1
	OUT R0 0		# Escreve 1 em i_START
	RET
OK:			# Escreve OK
	LDI R0 127
	OUT R0 3
	LDI R0 127
	OUT R0 4
	LDI R0 21
	OUT R0 5
	LDI R0 0
	OUT R0 6
	RET
FAIL:		# Escreve FAIL
	LDI R0 15	#F
	OUT R0 6
	LDI R0 10	#A
	OUT R0 5
	LDI R0 1	#I
	OUT R0 4
	LDI R0 20	#L
	OUT R0 3
	RET
MISS: 		# Escreve MISS (N155)
	LDI R0 17	#M
	OUT R0 6
	LDI R0 1	#I
	OUT R0 5
	LDI R0 5	#S
	OUT R0 4
	LDI R0 5	#S
	OUT R0 3
	RET
UAIT: 		# Escreve MISS (N155)
	LDI R0 16	#U
	OUT R0 6
	LDI R0 10	#A
	OUT R0 5
	LDI R0 1	#I
	OUT R0 4
	LDI R0 19	#t
	OUT R0 3
	RET
	
.INT0		# Interrupção PREPARE
	IN R1 2	  			# Lê o conteúdo recebido na entrada i_DATA_IO e armazena em R1
	LD R0 10	  		# Carrega em R0 o valor contido na RAM no enderço 10 e salta para PREPARA se os registradores forem iguais
	JE R0 R1 PREPARA1:
	LD R0 11
	JE R0 R1 PREPARA2:
	LD R0 12
	JE R0 R1 PREPARA3:
	LD R0 13
	JE R0 R1 PREPARA4:
	LD R0 14
	JE R0 R1 PREPARA5:
	LD R0 15
	JE R0 R1 PREPARA6:
	LD R0 16
	JE R0 R1 PREPARA7:
	LD R0 17
	JE R0 R1 PREPARA8:
	LD R0 18
	JE R0 R1 PREPARA9:
	LD R0 19
	JE R0 R1 PREPARA10:
	LD R0 20
	JE R0 R1 PREPARA11:
	LD R0 21
	JE R0 R1 PREPARA12:
	RETI
	
.INT1		# Interrupção DONE (Escreve a palavra DONE = '00nE')
	LDI R0 0	#D
	OUT R0 6
	LDI R0 0	#O
	OUT R0 5
	LDI R0 17	#N
	OUT R0 4
	LDI R0 14	#E
	OUT R0 3
	RETI
	
.INT2		# Interrupção LOAD (Carrega todos suprimentos)
	LDI R0 10
	STO R0 1
	LDI R0 10
	STO R0 2
	LDI R0 10
	STO R0 3
	LDI R0 10
	STO R0 4
	LDI R0 10
	STO R0 5
	LDI R0 20	# L
	OUT R0 6
	LDI R0 0	# O
	OUT R0 5
	LDI R0 10	# A
	OUT R0 4
	LDI R0 0	# D
	OUT R0 3
	RETI
.END