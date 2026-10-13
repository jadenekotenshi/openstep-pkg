	.text
	.align	1
	.globl ___moddi3
___moddi3:
	link a6,#-8
	moveml #0x3f3c,sp@-
	movel a6@(16),d4
	movel a6@(20),d5
	movel a6@(8),d0
	movel a6@(12),d1
	movel d4,d2
	movel d5,d3
	tstl d0
	jlt L2
	lea 0:w,a5
	tstl d4
	jlt L30
L5:
	lea a6@(-8),a4
	movel d3,d4
	movel d1,a3
	movel d1,d6
	movel d0,a0
	movel d0,d5
	tstl d2
	jne L7
	cmpl d3,d0
	jcc L9
	movel d0,d1
#APP
	divul d3,d1:d6
#NO_APP
	movel d1,d3
	clrl d2
	movel d2,a4@
	movel d3,a4@(4)
L14:
	tstl a5
	jeq L26
	negl a6@(-4)
	negxl a6@(-8)
	jra L26
L7:
	cmpl d2,d0
	jcc L15
	movel d1,d3
	movel d0,d2
	movel d2,a4@
	movel d3,a4@(4)
	jra L14
L15:
#APP
	bfffo d2{#0:#0},d0
#NO_APP
	movel d0,a1
	tstl d0
	jne L17
	cmpl d2,a0
	jhi L19
	cmpl d3,d1
	jcs L21
L19:
#APP
	subl d4,d6
	subxl d2,d5
#NO_APP
L21:
	movel d6,d3
	movel d5,d2
	movel d2,a4@
	movel d3,a4@(4)
	jra L14
L9:
	tstl d3
	jne L12
	moveq #1,d4
	divul d3,d4
L12:
	clrl d0
#APP
	divul d4,d0:d5
#NO_APP
	movel d0,d1
#APP
	divul d4,d1:d6
#NO_APP
	movel d1,d3
	clrl d2
	movel d2,a4@
	movel d3,a4@(4)
	jra L14
L30:
	movel d4,d2
	movel d5,d3
	negl d3
	negxl d2
	jra L5
L2:
	negl d1
	negxl d0
	movew #-1,a5
	tstl d4
	jge L5
	jra L30
L17:
	moveq #32,d6
	subl d0,d6
	movel d3,d1
	lsrl d6,d1
	movel d2,d0
	movel a1,d2
	lsll d2,d0
	movel d1,d5
	orl d0,d5
	lsll d2,d3
	movel a3,d1
	lsrl d6,d1
	movel a0,d0
	lsll d2,d0
	orl d0,d1
	movel a3,d2
	movel a1,d0
	lsll d0,d2
	movel a0,d0
	lsrl d6,d0
	movel d0,d4
#APP
	divul d5,d4:d1
	mulul d3,d0:d1
#NO_APP
	cmpl d4,d0
	jhi L22
	cmpl d0,d4
	jeq L31
L24:
#APP
	subl d1,d2
	subxl d0,d4
#NO_APP
	movel d2,d1
	movel a1,d0
	lsrl d0,d1
	movel d4,d0
	lsll d6,d0
	movel d1,d3
	orl d0,d3
	movel d4,d2
	movel a1,d1
	lsrl d1,d2
	movel d2,a4@
	movel d3,a4@(4)
	jra L14
L31:
	cmpl d2,d1
	jls L24
L22:
#APP
	subl d3,d1
	subxl d5,d0
	subl d1,d2
	subxl d0,d4
#NO_APP
	movel d2,d1
	movel a1,d0
	lsrl d0,d1
	movel d4,d0
	lsll d6,d0
	movel d1,d3
	orl d0,d3
	movel d4,d2
	movel a1,d1
	lsrl d1,d2
	movel d2,a4@
	movel d3,a4@(4)
	jra L14
L26:
	movel a6@(-8),d0
	movel a6@(-4),d1
	moveml sp@+,#0x3cfc
	unlk a6
	rts
