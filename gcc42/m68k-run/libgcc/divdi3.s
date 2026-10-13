	.text
	.align	1
	.globl ___divdi3
___divdi3:
	pea a6@
	movel sp,a6
	moveml #0x3f20,sp@-
	movel a6@(16),d5
	movel a6@(20),d6
	movel a6@(8),d3
	movel a6@(12),d4
	movel d5,d0
	movel d6,d1
	tstl d3
	jlt L2
	lea 0:w,a2
	tstl d5
	jlt L30
L5:
	movel d1,a0
	movel d1,d2
	movel d0,d6
	movel d4,d7
	movel d3,d5
	tstl d0
	jne L7
	cmpl d1,d3
	jcc L9
#APP
	divul d1,d5:d7
#NO_APP
	movel d7,d2
	clrl d1
L11:
	movel d1,d0
	movel d2,d1
	tstl a2
	jeq L25
	negl d1
	negxl d0
	jra L25
L7:
	cmpl d0,d3
	jcc L31
L14:
	clrl d1
	clrl d2
	jra L11
L9:
	tstl d1
	jne L12
	moveq #1,d2
	divul d1,d2
L12:
	clrl d0
	movel d5,d1
#APP
	divul d2,d0:d1
#NO_APP
	movel d0,d3
#APP
	divul d2,d3:d7
#NO_APP
	movel d7,d2
	jra L11
L31:
#APP
	bfffo d0{#0:#0},d0
#NO_APP
	movel d0,a1
	tstl d0
	jne L16
	cmpl d6,d3
	jhi L18
	cmpl d1,d4
	jcs L14
L18:
	clrl d1
	moveq #1,d2
	jra L11
L30:
	movel a2,d0
	notl d0
	movel d0,a2
	movel d5,d0
	movel d6,d1
	negl d1
	negxl d0
	jra L5
L2:
	negl d4
	negxl d3
	movew #-1,a2
	tstl d5
	jge L5
	jra L30
L16:
	moveq #32,d4
	subl d0,d4
	movel d1,d2
	lsrl d4,d2
	movel d6,d0
	movel a1,d1
	lsll d1,d0
	orl d0,d2
	movel a0,d3
	lsll d1,d3
	movel d7,d1
	lsrl d4,d1
	movel d5,d0
	movel a1,d6
	lsll d6,d0
	orl d0,d1
	movel d5,d0
	lsrl d4,d0
#APP
	divul d2,d0:d1
#NO_APP
	movel d0,d2
#APP
	mulul d1,d0:d3
#NO_APP
	cmpl d2,d0
	jhi L20
	cmpl d0,d2
	jeq L32
L28:
	movel d1,d2
	clrl d1
	jra L11
L32:
	movel d7,d0
	movel a1,d2
	lsll d2,d0
	cmpl d0,d3
	jls L28
L20:
	movel d1,d2
	subql #1,d2
	clrl d1
	jra L11
L25:
	moveml sp@+,#0x4fc
	unlk a6
	rts
