	.text
	.align	1
	.globl ___ffsdi2
___ffsdi2:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel a6@(12),d1
	tstl d1
	jeq L2
	movew #32,a0
L4:
	movel d1,d0
	negl d0
	andl d1,d0
#APP
	bfffo d0{#0:#0},d0
#NO_APP
	subl d0,a0
	movel a0,d0
	jra L7
L2:
	tstl d0
	jeq L7
	movel d0,d1
	movew #64,a0
	jra L4
L7:
	unlk a6
	rts
