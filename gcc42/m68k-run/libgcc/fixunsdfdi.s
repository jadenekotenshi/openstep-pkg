	.text
	.align	1
	.globl ___fixunsdfdi
___fixunsdfdi:
	pea a6@
	movel sp,a6
	movel d3,sp@-
	movel d2,sp@-
	fmoved a6@(8),fp1
	fmovex fp1,fp0
	fmuld #0r2.3283064365386962890625e-10,fp0
	fcmpd #0r2.147483648e+9,fp0
	fjge L2
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	fmovel d0,fp0
	tstl d0
	jlt L9
L4:
	fmuld #0r-4.294967296e+9,fp0
	faddx fp1,fp0
	fcmpd #0r2.147483648e+9,fp0
	fjge L5
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d2
	fmoveml d3,fpcr
	jra L6
L2:
	faddd #0r-2.147483648e+9,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d3,fpcr
	addl #-2147483648,d0
	fmovel d0,fp0
	tstl d0
	jge L4
	jra L9
L5:
	faddd #0r-2.147483648e+9,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d2
	fmoveml d3,fpcr
	addl #-2147483648,d2
	jra L6
L9:
	faddd #0r4.294967296e+9,fp0
	jra L4
L6:
	movel d0,d0
	clrl d1
	orl d2,d1
	movel sp@+,d2
	movel sp@+,d3
	unlk a6
	rts
