	.text
	.align	1
	.globl ___ctzsi2
___ctzsi2:
	pea a6@
	movel sp,a6
	movel a6@(8),d1
	movel d1,d0
	negl d0
	andl d1,d0
#APP
	bfffo d0{#0:#0},d0
#NO_APP
	moveq #31,d1
	subl d0,d1
	movel d1,d0
	unlk a6
	rts
