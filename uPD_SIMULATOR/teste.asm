.PROG
	SETR RINT 7	# Habilita as interrupções
MAIN:
	LDI R0 127			# zera display begin
	OUT R0 3
	LDI R0 127
	OUT R0 4
	LDI R0 127
	OUT R0 5
	LDI R0 127
	OUT R0 6			# zera display end
	LDI R0 2			# suprimento begin
	STO R0 1
	LDI R0 2
	STO R0 2
	LDI R0 2
	STO R0 3
	LDI R0 2
	STO R0 4			# suprimento end
	LDI R0 1			# choice begin
	STO R0 10
	LDI R0 9
	STO R0 11
	LDI R0 17
	STO R0 12
	LDI R0 25
	STO R0 13
	LDI R0 2
	STO R0 14
	LDI R0 10
	STO R0 15
	LDI R0 18
	STO R0 16
	LDI R0 26
	STO R0 17
	LDI R0 4
	STO R0 18
	LDI R0 12
	STO R0 19
	LDI R0 20
	STO R0 20
	LDI R0 28
	STO R0 21			# choice end
	LDI R0 1			# Libera o uso das chaves deslizantes
	OUT R0 2			# end
	LDI R0 0	#O
	OUT R0 4
	LDI R0 21	#K
	OUT R0 3
	LDI R0 127
	OUT R0 5
	LDI R0 127
	OUT R0 6
	JI 52
AGUARDA:
	NOP
	JI 52
PREPARA1:
	LDI R3 0	#D
	OUT R3 6
	LDI R3 0	#O
	OUT R3 5
	LDI R3 17	#N
	OUT R3 4
	LDI R3 14	#E
	OUT R3 3
	LDI R3 0	# ERRO
	OUT R3 7
	JI 52
	
.INT0		# Interrupção PREPARE
	IN R3 2				# Lê a entrada 2 e armazena em R3
	LD R2 10	  		# Carrega em R0 o valor contido na RAM no enderço 10 e salta para PREPARA se os registradores forem iguais
	JE R3 R2 52
	LDI R3 15	#F
	OUT R3 6
	LDI R3 10	#A
	OUT R3 5
	LDI R3 1	#I
	OUT R3 4
	LDI R3 20	#L
	OUT R3 3
	LDI R3 0	# ERRO
	OUT R3 7
	RETI
	
.INT1		# Interrupção DONE (Escreve a palavra DONE = '00nE')
	LDI R3 0	#D
	OUT R3 6
	LDI R3 0	#O
	OUT R3 5
	LDI R3 17	#N
	OUT R3 4
	LDI R3 14	#E
	OUT R3 3
	LDI R3 0	# ERRO
	OUT R3 7
	RETI
	
.INT2		# Interrupção LOAD (Carrega todos suprimentos)
	LDI R3 20	# L
	OUT R3 6
	LDI R3 0	# O
	OUT R3 5
	LDI R3 10	# A
	OUT R3 4
	LDI R3 0	# D
	OUT R3 3
	LDI R3 0	# ERRO
	OUT R3 7
	LDI R3 10
	STO R3 1
	LDI R3 10
	STO R3 2
	LDI R3 10
	STO R3 3
	LDI R3 10
	STO R3 4
	RETI


.END