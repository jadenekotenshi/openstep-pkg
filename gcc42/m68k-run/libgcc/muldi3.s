	.text
	.align	1
	.globl ___muldi3
___muldi3:
	pea a6@
	movel sp,a6
	moveml #0x3f00,sp@-
	movel a6@(8),d6
	movel a6@(12),d7
	movel a6@(16),d4
	movel a6@(20),d5
	movel d7,d3
	movel d5,d2
	movel d7,d1
#APP
	mulul d5,d0:d1
#NO_APP
	movel d1,a1
	movel d0,a0
	movel a0,d0
	movel a1,d1
	mulsl d4,d3
	mulsl d6,d2
	addl d2,d3
	movel d3,d0
	addl a0,d0
	moveml sp@+,#0xfc
	unlk a6
	rts
