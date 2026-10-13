	.text
	.align	1
	.globl ___negdi2
___negdi2:
	pea a6@
	movel sp,a6
	moveml #0x3800,sp@-
	movel a6@(8),d1
	movel a6@(12),d2
	tstl d2
	sne d0
	extbl d0
	movel d0,d3
	subl d1,d3
	movel d2,d4
	negl d4
	movel d3,d0
	movel d4,d1
	moveml sp@+,#0x1c
	unlk a6
	rts
