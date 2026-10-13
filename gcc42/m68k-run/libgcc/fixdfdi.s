	.text
	.align	1
	.globl ___fixdfdi
___fixdfdi:
	pea a6@
	movel sp,a6
	fmoved a6@(8),fp0
	fjlt L8
	fmoved fp0,sp@-
	jbsr ___fixunsdfdi
	addql #8,sp
	jra L5
L8:
	fnegx fp0,fp0
	fmoved fp0,sp@-
	jbsr ___fixunsdfdi
	negl d1
	negxl d0
	addql #8,sp
L5:
	unlk a6
	rts
