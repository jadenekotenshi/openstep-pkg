	.text
	.align	1
	.globl ___udivmoddi4
___udivmoddi4:
	pea a6@
	movel sp,a6
	moveml #0x3f38,sp@-
	movel a6@(8),d2
	movel a6@(12),d3
	movel a6@(16),a0
	movel a6@(20),a1
	movel a6@(24),a4
	movel a1,d1
	movel a0,d0
	movel d3,a3
	movel d3,d5
	movel d2,d6
	movel d2,d4
	tstl a0
	jne L2
	cmpl a1,d6
	jcc L4
	movel d3,d2
	movel d4,d0
#APP
	divul d1,d0:d2
#NO_APP
	clrl d3
L6:
	tstl a4
	jeq L31
	movel d0,d1
	clrl d0
	movel d0,a4@
	movel d1,a4@(4)
L31:
	movel d3,d0
	movel d2,a0
	jra L11
L2:
	movel a0,d7
	cmpl d0,d6
	jcc L12
	tstl a4
	jeq L33
	movel d3,d1
	movel d2,d0
	movel d0,a4@
	movel d1,a4@(4)
L33:
	clrl d0
	lea 0:w,a0
	jra L11
L12:
#APP
	bfffo d0{#0:#0},d3
#NO_APP
	movel d3,a0
	tstl d3
	jne L16
	cmpl d0,d6
	jhi L18
	cmpl a1,a3
	jcc L18
L21:
	tstl a4
	jeq L34
	movel d5,d1
	movel d4,d0
	movel d0,a4@
	movel d1,a4@(4)
	clrl d0
	jra L11
L4:
	tstl a1
	jne L7
	moveq #1,d1
	movel a1,d2
	divul d2,d1
L7:
	clrl d0
	movel d4,d3
#APP
	divul d1,d0:d3
#NO_APP
	movel d5,d2
#APP
	divul d1,d0:d2
#NO_APP
	jra L6
L16:
	moveq #32,d7
	subl d3,d7
	movel a1,d1
	lsrl d7,d1
	movel d3,d2
	lsll d3,d0
	movel d1,d4
	orl d0,d4
	movel a1,d3
	lsll d2,d3
	movel a3,d1
	lsrl d7,d1
	movel d6,d0
	lsll d2,d0
	orl d0,d1
	movel a3,d5
	lsll d2,d5
	movel d6,d0
	lsrl d7,d0
	movel d1,d6
	movel d0,d2
#APP
	divul d4,d2:d6
#NO_APP
	movel d6,d1
#APP
	mulul d3,d0:d1
#NO_APP
	cmpl d2,d0
	jhi L24
	cmpl d0,d2
	jeq L36
L26:
	tstl a4
	jeq L32
#APP
	subl d1,d5
	subxl d0,d2
#NO_APP
	movel d5,d1
	movel a0,d3
	lsrl d3,d1
	movel d2,d0
	lsll d7,d0
	orl d0,d1
	movel d2,d0
	lsrl d3,d0
	movel d0,a4@
	movel d1,a4@(4)
L32:
	movel d6,a0
L34:
	clrl d0
	jra L11
L18:
#APP
	subl d1,d5
	subxl d7,d4
#NO_APP
	movew #1,a0
	jra L21
L36:
	cmpl d5,d1
	jls L26
L24:
	subql #1,d6
#APP
	subl d3,d1
	subxl d4,d0
#NO_APP
	jra L26
L11:
	movel a0,d1
	moveml sp@+,#0x1cfc
	unlk a6
	rts
