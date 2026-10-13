	.text
	.align	1
	.globl ___ctzdi2
___ctzdi2:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel a6@(12),d1
	tstl d1
	jeq L2
	lea 0:w,a0
	jra L4
L2:
	movel d0,d1
	movew #32,a0
L4:
	movel d1,d0
	negl d0
	andl d1,d0
#APP
	bfffo d0{#0:#0},d0
#NO_APP
	moveq #31,d1
	subl d0,d1
	movel d1,d0
	addl a0,d0
	unlk a6
	rts
