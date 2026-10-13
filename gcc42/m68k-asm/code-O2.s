	.text
	.align	1
	.globl _sw
_sw:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	moveq #7,d1
	cmpl d0,d1
	jcc L15
	clrl d0
	jra L12
L15:
LI11:
	movew pc@(L11-LI11-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.align	1
L11:
	.word L3-L11
	.word L4-L11
	.word L5-L11
	.word L6-L11
	.word L7-L11
	.word L8-L11
	.word L9-L11
	.word L10-L11
L10:
	moveq #88,d0
	jra L12
L3:
	moveq #11,d0
	jra L12
L4:
	moveq #22,d0
	jra L12
L5:
	moveq #33,d0
	jra L12
L6:
	moveq #44,d0
	jra L12
L7:
	moveq #55,d0
	jra L12
L8:
	moveq #66,d0
	jra L12
L9:
	moveq #77,d0
L12:
	unlk a6
	rts
	.align	1
	.globl _ll
_ll:
	pea a6@
	movel sp,a6
	moveml #0x3f30,sp@-
	movel a6@(8),d5
	movel a6@(12),d6
	movel a6@(16),a2
	movel a6@(20),a3
	movel a6@(24),d7
	movel a3,sp@-
	movel a2,sp@-
	movel d6,sp@-
	movel d5,sp@-
	jbsr ___moddi3
	addw #16,sp
	movel a2,d2
	mulsl d6,d2
	movel a3,d3
	mulsl d5,d3
	addl d3,d2
	movel a3,d4
	mulul d6,d3:d4
	addl d2,d3
	addl d4,d1
	addxl d3,d0
	movel d0,a0
	movel d1,a1
	moveq #-32,d4
	addl d7,d4
	jmi L18
	movel d6,d2
	lsll d4,d2
	clrl d3
	movel a0,d0
	movel a1,d1
	addl d3,d1
	addxl d2,d0
	movel d0,a0
	movel d1,a1
	tstl d4
	jlt L20
L24:
	movel d5,d3
	asrl d4,d3
	movel d5,d2
	addl d2,d2
	subxl d2,d2
	jra L21
L18:
	movel d6,d0
	lsrl #1,d0
	moveq #31,d1
	subl d7,d1
	lsrl d1,d0
	movel d5,d2
	lsll d7,d2
	orl d0,d2
	movel d6,d3
	lsll d7,d3
	movel a0,d0
	movel a1,d1
	addl d3,d1
	addxl d2,d0
	movel d0,a0
	movel d1,a1
	tstl d4
	jge L24
L20:
	movel d5,d0
	addl d0,d0
	moveq #31,d1
	subl d7,d1
	lsll d1,d0
	movel d6,d3
	lsrl d7,d3
	orl d0,d3
	movel d5,d2
	asrl d7,d2
L21:
	movel a0,d1
	addl a1,d3
	addxl d1,d2
	movel a3,sp@-
	movel a2,sp@-
	movel d6,sp@-
	movel d5,sp@-
	jbsr ___divdi3
	addw #16,sp
	subl d1,d3
	subxl d0,d2
	movel d2,d0
	movel d3,d1
	moveml a6@(-32),#0xcfc
	unlk a6
	rts
	.align	1
	.globl _ull
_ull:
	pea a6@
	movel sp,a6
	moveml #0x3f00,sp@-
	movel a6@(8),d2
	movel a6@(12),d3
	movel a6@(16),d4
	movel a6@(20),d5
	movel d5,sp@-
	movel d4,sp@-
	movel d3,sp@-
	movel d2,sp@-
	jbsr ___umoddi3
	addw #16,sp
	movel d0,d6
	movel d1,d7
	movel d5,sp@-
	movel d4,sp@-
	movel d3,sp@-
	movel d2,sp@-
	jbsr ___udivdi3
	addw #16,sp
	addl d7,d1
	addxl d6,d0
	moveml a6@(-24),#0xfc
	unlk a6
	rts
	.align	1
	.globl _fp
_fp:
	pea a6@
	movel sp,a6
	fmovem #0xc,sp@-
	fmoved a6@(8),fp1
	fmoves a6@(16),fp0
	fmovex fp0,fp2
	fmulx fp1,fp2
	faddl a6@(20),fp2
	fmovex fp1,fp3
	fdivx fp0,fp3
	fsubx fp3,fp2
	fmoved fp1,sp@-
	jbsr ___fixdfdi
	movel d0,sp@
	movel d1,sp@(4)
	jbsr ___floatdidf
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	faddx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	fmovem a6@(-24),#0x30
	unlk a6
	rts
	.align	1
	.globl _fp2
_fp2:
	pea a6@
	movel sp,a6
	fmoves a6@(8),fp0
	movel a6@(12),d0
	fmovex fp0,fp1
	fsglmuls d0,fp1
	fsgldivs d0,fp0
	faddx fp0,fp1
	fmoves fp1,d0
	unlk a6
	rts
	.align	1
	.globl _cmp
_cmp:
	pea a6@
	movel sp,a6
	fmoved a6@(8),fp1
	fmoved a6@(16),fp0
	fcmpx fp0,fp1
	fjlt L42
	fsne d0
	extbl d0
	moveq #2,d1
	subl d0,d1
	movel d1,d0
	jra L36
L42:
	moveq #1,d0
L36:
	unlk a6
	rts
	.align	1
	.globl _callptr
_callptr:
	pea a6@
	movel sp,a6
	movel d3,sp@-
	movel d2,sp@-
	movel a6@(12),d2
	movel d2,sp@-
	movel a6@(8),a0
	jbsr a0@
	movel d0,d3
	movel d2,sp@-
	movel _fptr,a0
	jbsr a0@
	addl d3,d0
	movel a6@(-8),d2
	movel a6@(-4),d3
	unlk a6
	rts
	.align	1
	.globl _retbig
_retbig:
	link a6,#-80
	movel a6@(8),a1@
	movel a1,d0
	unlk a6
	rts
	.align	1
	.globl _usebig
_usebig:
	link a6,#-80
	pea 3:w
	lea a6@(-80),a1
	jbsr _retbig
	movel a6@(-80),d0
	unlk a6
	rts
	.align	1
	.globl _weakfn
_weakfn:
	pea a6@
	movel sp,a6
	moveq #1,d0
	unlk a6
	rts
	.align	1
	.globl _weakref_user
_weakref_user:
	pea a6@
	movel sp,a6
	jbsr _weakfn
	unlk a6
	rts
	.align	1
	.globl _volatile_rw
_volatile_rw:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	moveq #1,d0
	movel d0,a0@
	movel a0@,d0
	unlk a6
	rts
	.align	1
	.globl _dtor
_dtor:
	pea a6@
	movel sp,a6
	pea 2:w
	jbsr _ext
	addql #4,sp
	unlk a6
	rts
.destructor
	.align	2
	.long	_dtor
.reference .destructors_used
	.text
	.align	1
	.globl _ctor
_ctor:
	pea a6@
	movel sp,a6
	pea 1:w
	jbsr _ext
	addql #4,sp
	unlk a6
	rts
.constructor
	.align	2
	.long	_ctor
.reference .constructors_used
	.text
	.align	1
	.globl _mixed
_mixed:
	pea a6@
	movel sp,a6
	fmoved a6@(12),fp0
	faddd a6@(24),fp0
	fmoved fp0,sp@-
	jbsr _ext2
	movel a6@(20),d1
	addl a6@(8),d1
	addl a6@(32),d1
	addl a6@(36),d1
	addl a6@(40),d1
	addl a6@(44),d1
	addl d1,d0
	unlk a6
	rts
	.align	1
	.globl _al
_al:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	addql #4,d0
	moveq #-4,d1
	andl d1,d0
	subl d0,sp
	moveb #1,sp@
	pea 1:w
	jbsr _ext
	unlk a6
	rts
	.align	1
	.globl _vsum
_vsum:
	link a6,#-4
	movel a2,sp@-
	movel a6@(8),a1
	lea a6@(12),a2
	movel a2,a6@(-4)
	tstl a1
	jeq L74
	movel a2,a0
	clrl d0
	clrl d1
L68:
	addl a0@+,d0
	addql #1,d1
	cmpl d1,a1
	jne L68
	lsll #2,d1
	addl a2,d1
	movel d1,a6@(-4)
	jra L67
L74:
	clrl d0
L67:
	movel sp@+,a2
	unlk a6
	rts
	.align	1
	.globl _usesq
_usesq:
	pea a6@
	movel sp,a6
	movel a6@(8),d1
	movel d1,d0
	addql #1,d0
	mulsl d0,d0
	mulsl d1,d1
	addl d1,d0
	unlk a6
	rts
	.globl _fptr
	.data
	.align	1
_fptr:
	.long	_ext
