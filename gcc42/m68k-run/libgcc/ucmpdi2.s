	.text
	.align	1
	.globl ___ucmpdi2
___ucmpdi2:
	pea a6@
	movel sp,a6
	movel d3,sp@-
	movel d2,sp@-
	movel a6@(8),a0
	movel a6@(12),a1
	movel a6@(16),d2
	movel a6@(20),d3
	movel a0,d1
	movel d2,d0
	cmpl d1,d0
	jhi L2
	jcs L4
	cmpl a1,d3
	jhi L2
	jcc L11
L4:
	moveq #2,d0
	jra L8
L2:
	clrl d0
	jra L8
L11:
	moveq #1,d0
L8:
	movel sp@+,d2
	movel sp@+,d3
	unlk a6
	rts
