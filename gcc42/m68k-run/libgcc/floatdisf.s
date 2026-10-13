	.text
	.align	1
	.globl ___floatdisf
___floatdisf:
	pea a6@
	movel sp,a6
	moveml #0x3c00,sp@-
	movel a6@(8),d2
	movel a6@(12),d3
	movel #2097151,d0
	moveq #-1,d1
	addl d3,d1
	addxl d2,d0
	movel #4194303,d4
	moveq #-2,d5
	subl d5,d1
	subxl d4,d0
	jls L2
	movel d2,d0
	movel d3,d1
	clrl d0
	andl #2047,d1
	movel d0,d5
	orl d1,d5
	jeq L2
	movel d2,d0
	movel d3,d1
	andw #63488,d1
	movel d0,d2
	movel d1,d3
	orw #2048,d3
L2:
	movel d2,d1
	smi d0
	extbl d0
	fmoved #0r4.294967296e+9,fp1
	fmull d1,fp1
	fmovel d3,fp0
	tstl d3
	jge L5
	faddd #0r4.294967296e+9,fp0
L5:
	faddx fp1,fp0
	fmoves fp0,d0
	moveml sp@+,#0x3c
	unlk a6
	rts
