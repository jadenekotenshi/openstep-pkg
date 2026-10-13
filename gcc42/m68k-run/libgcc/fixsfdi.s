	.text
	.align	1
	.globl ___fixsfdi
___fixsfdi:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	jlt L8
	movel d0,sp@-
	jbsr ___fixunssfdi
	addql #4,sp
	jra L5
L8:
	fnegs d0,fp0
	fmoves fp0,sp@-
	jbsr ___fixunssfdi
	negl d1
	negxl d0
	addql #4,sp
L5:
	unlk a6
	rts
