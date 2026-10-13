	.text
	.align	1
	.globl ___umoddi3
___umoddi3:
	pea a6@
	movel sp,a6
	moveml #0x3f30,sp@-
	movel a6@(8),d0
	movel a6@(12),d1
	movel a6@(16),a0
	movel a6@(20),a1
	movel a1,d2
	movel a0,d5
	movel d1,a3
	movel d1,d3
	movel d0,d6
	movel d0,d4
	tstl a0
	jne L2
	cmpl a1,d6
	jcc L4
	movel d4,d1
#APP
	divul d2,d1:d3
#NO_APP
	movel d1,d3
	clrl d2
	jra L9
L2:
	movel a0,d7
	cmpl d5,d6
	jcc L10
	movel d1,d3
	movel d0,d2
	jra L9
L10:
#APP
	bfffo d5{#0:#0},d0
#NO_APP
	movel d0,a0
	tstl d0
	jne L12
	cmpl d5,d6
	jhi L14
	cmpl a1,d1
	jcs L16
L14:
#APP
	subl d2,d3
	subxl d7,d4
#NO_APP
L16:
	movel d4,d2
	jra L9
L4:
	tstl a1
	jne L7
	moveq #1,d2
	movel a1,d1
	divul d1,d2
L7:
	clrl d0
#APP
	divul d2,d0:d4
#NO_APP
	movel d0,d1
#APP
	divul d2,d1:d3
#NO_APP
	movel d1,d3
	clrl d2
	jra L9
L12:
	moveq #32,d7
	subl d0,d7
	movel a1,d1
	lsrl d7,d1
	movel d5,d0
	movel a0,d2
	lsll d2,d0
	movel d1,d5
	orl d0,d5
	movel a1,d3
	lsll d2,d3
	movel a3,d1
	lsrl d7,d1
	movel d6,d0
	lsll d2,d0
	orl d0,d1
	movel a3,d2
	movel a0,d0
	lsll d0,d2
	movel d6,d0
	lsrl d7,d0
	movel d0,d4
#APP
	divul d5,d4:d1
	mulul d3,d0:d1
#NO_APP
	cmpl d4,d0
	jhi L17
	cmpl d0,d4
	jeq L23
L19:
#APP
	subl d1,d2
	subxl d0,d4
#NO_APP
	movel d2,d1
	movel a0,d0
	lsrl d0,d1
	movel d4,d0
	lsll d7,d0
	movel d1,d3
	orl d0,d3
	movel d4,d2
	movel a0,d1
	lsrl d1,d2
	jra L9
L23:
	cmpl d2,d1
	jls L19
L17:
#APP
	subl d3,d1
	subxl d5,d0
	subl d1,d2
	subxl d0,d4
#NO_APP
	movel d2,d1
	movel a0,d0
	lsrl d0,d1
	movel d4,d0
	lsll d7,d0
	movel d1,d3
	orl d0,d3
	movel d4,d2
	movel a0,d1
	lsrl d1,d2
L9:
	movel d2,d0
	movel d3,d1
	moveml sp@+,#0xcfc
	unlk a6
	rts
