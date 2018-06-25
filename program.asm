.PROG
	SETR RINT 7	# Habilita 3 interrupções
MAIN:
	LDI R0 1	# Carrega o valor 1 em R0
	STO R0 10
	JI MAIN:

.END