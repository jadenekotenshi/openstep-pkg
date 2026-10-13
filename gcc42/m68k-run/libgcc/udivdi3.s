	.text
	.align	1
	.globl ___udivdi3
___udivdi3:
	link a6,#-4
	moveml #0x3f00,sp@-
	movel a6@(8),d0
	movel a6@(12),d1
	movel a6@(16),a0
	movel a6@(20),a1
	movel a1,d7
	movel a1,d2
	movel a0,d3
	movel d1,d6
	movel d0,d5
	tstl a0
	jne L2
	cmpl a1,d5
	jcc L4
#APP
	divul d2,d5:d6
#NO_APP
	movel d6,d2
	clrl d1
	jra L6
L2:
	cmpl d3,d5
	jcs L9
#APP
	bfffo d3{#0:#0},d4
#NO_APP
	tstl d4
	jne L11
	cmpl d3,d5
	jhi L13
	cmpl a1,d1
	jcs L9
L13:
	clrl d1
	moveq #1,d2
	jra L6
L4:
	tstl a1
	jne L7
	moveq #1,d2
	divul d7,d2
L7:
	clrl d0
	movel d5,d1
#APP
	divul d2,d0:d1
#NO_APP
	movel d0,d3
#APP
	divul d2,d3:d6
#NO_APP
	movel d6,d2
	jra L6
L11:
	moveq #32,d0
	subl d4,d0
	movel d0,a6@(-4)
	movel a1,d2
	lsrl d0,d2
	movel d3,d0
	lsll d4,d0
	orl d0,d2
	movel a1,d3
	lsll d4,d3
	movel a6@(-4),d7
	lsrl d7,d1
	movel d5,d0
	lsll d4,d0
	orl d0,d1
	movel d5,d0
	lsrl d7,d0
#APP
	divul d2,d0:d1
#NO_APP
	movel d0,d2
#APP
	mulul d1,d0:d3
#NO_APP
	cmpl d2,d0
	jhi L15
	cmpl d0,d2
	jeq L23
L21:
	movel d1,d2
	clrl d1
	jra L6
L9:
	clrl d1
	clrl d2
	jra L6
L23:
	movel d6,d0
	lsll d4,d0
	cmpl d0,d3
	jls L21
L15:
	movel d1,d2
	subql #1,d2
	clrl d1
L6:
	movel d1,d0
	movel d2,d1
	moveml sp@+,#0xfc
	unlk a6
	rts
