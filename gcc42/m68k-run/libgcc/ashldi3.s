	.text
	.align	1
	.globl ___ashldi3
___ashldi3:
	pea a6@
	movel sp,a6
	moveml #0x3e00,sp@-
	movel a6@(8),d1
	movel a6@(12),d2
	movel a6@(16),d6
	jeq L2
	moveq #32,d5
	subl d6,d5
	tstl d5
	jle L9
	movel d2,d0
	movel d2,d4
	lsll d6,d4
	lsrl d5,d0
	lsll d6,d1
	movel d0,d3
	orl d1,d3
L6:
	movel d3,d1
	movel d4,d2
	jra L2
L9:
	clrl d4
	movel d5,d0
	negl d0
	movel d2,d3
	lsll d0,d3
	jra L6
L2:
	movel d1,d0
	movel d2,d1
	moveml sp@+,#0x7c
	unlk a6
	rts
