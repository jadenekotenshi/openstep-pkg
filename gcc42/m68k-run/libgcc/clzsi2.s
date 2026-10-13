	.text
	.align	1
	.globl ___clzsi2
___clzsi2:
	pea a6@
	movel sp,a6
#APP
	bfffo a6@(8){#0:#0},d0
#NO_APP
	unlk a6
	rts
