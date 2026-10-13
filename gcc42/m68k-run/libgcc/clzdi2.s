	.text
	.align	1
	.globl ___clzdi2
___clzdi2:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel a6@(12),d1
	tstl d0
	jeq L2
	clrl d1
	jra L4
L2:
	movel d1,d0
	moveq #32,d1
L4:
#APP
	bfffo d0{#0:#0},d0
#NO_APP
	addl d1,d0
	unlk a6
	rts
