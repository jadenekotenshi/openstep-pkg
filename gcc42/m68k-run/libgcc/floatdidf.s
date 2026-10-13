	.text
	.align	1
	.globl ___floatdidf
___floatdidf:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel a6@(12),d1
	fmoved #0r4.294967296e+9,fp1
	fmull a6@(8),fp1
	fmovel d1,fp0
	tstl d1
	jge L2
	faddd #0r4.294967296e+9,fp0
L2:
	faddx fp0,fp1
	fmoved fp1,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
