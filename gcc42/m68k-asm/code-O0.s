	.text
	.align	1
	.globl _sw
_sw:
	link a6,#-4
	moveq #7,d0
	cmpl a6@(8),d0
	jcs L2
	movel a6@(8),d0
	addl d0,d0
	movel #L11,a0
	movew a0@(d0:l),d0
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
L3:
	moveq #11,d0
	movel d0,a6@(-4)
	jra L12
L4:
	moveq #22,d0
	movel d0,a6@(-4)
	jra L12
L5:
	moveq #33,d0
	movel d0,a6@(-4)
	jra L12
L6:
	moveq #44,d0
	movel d0,a6@(-4)
	jra L12
L7:
	moveq #55,d0
	movel d0,a6@(-4)
	jra L12
L8:
	moveq #66,d0
	movel d0,a6@(-4)
	jra L12
L9:
	moveq #77,d0
	movel d0,a6@(-4)
	jra L12
L10:
	moveq #88,d0
	movel d0,a6@(-4)
	jra L12
L2:
	clrl a6@(-4)
L12:
	movel a6@(-4),d0
	unlk a6
	rts
	.align	1
	.globl _ll
_ll:
	link a6,#-40
	moveml #0x3c00,sp@-
	moveq #-32,d0
	addl a6@(24),d0
	movel d0,a6@(-36)
	tstl a6@(-36)
	jlt L15
	movel a6@(12),d0
	movel d0,d1
	movel a6@(-36),d2
	lsll d2,d1
	movel d1,a6@(-32)
	clrl d3
	movel d3,a6@(-28)
	jra L16
L15:
	movel a6@(12),d0
	movel d0,d1
	lsrl #1,d1
	moveq #31,d0
	subl a6@(24),d0
	lsrl d0,d1
	movel a6@(8),d0
	movel d0,d4
	movel a6@(24),d5
	lsll d5,d4
	movel d4,a6@(-32)
	movel a6@(-32),d0
	orl d1,d0
	movel d0,a6@(-32)
	movel a6@(12),d0
	movel d0,d1
	movel a6@(24),d2
	lsll d2,d1
	movel d1,a6@(-28)
L16:
	movel a6@(8),d1
	mulsl a6@(20),d1
	movel a6@(16),d0
	mulsl a6@(12),d0
	addl d0,d1
	movel a6@(12),d2
	movel a6@(20),d0
	movel d2,d3
	mulul d0,d4:d3
	movel d4,a6@(-24)
	movel d3,a6@(-20)
	movel a6@(-24),d5
	addl d5,d1
	movel d1,a6@(-24)
	movel a6@(-32),d2
	movel a6@(-28),d3
	movel a6@(-24),d0
	addl a6@(-20),d3
	addxl d0,d2
	movel a6@(20),sp@-
	movel a6@(16),sp@-
	movel a6@(12),sp@-
	movel a6@(8),sp@-
	jbsr ___divdi3
	addw #16,sp
	subl d1,d3
	subxl d0,d2
	movel a6@(8),d0
	movel a6@(12),d1
	movel a6@(20),sp@-
	movel a6@(16),sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #16,sp
	movel d2,d4
	movel d3,d5
	addl d1,d5
	addxl d0,d4
	movel d4,a6@(-16)
	movel d5,a6@(-12)
	moveq #-32,d5
	addl a6@(24),d5
	movel d5,a6@(-40)
	tstl a6@(-40)
	jlt L17
	movel a6@(8),d0
	movel d0,d1
	movel a6@(-40),d2
	asrl d2,d1
	movel d1,a6@(-4)
	movel a6@(8),d0
	movel d0,d3
	addl d3,d3
	subxl d3,d3
	movel d3,a6@(-8)
	jra L18
L17:
	movel a6@(8),d0
	movel d0,d1
	addl d1,d1
	moveq #31,d0
	subl a6@(24),d0
	lsll d0,d1
	movel a6@(12),d0
	movel d0,d4
	movel a6@(24),d5
	lsrl d5,d4
	movel d4,a6@(-4)
	movel a6@(-4),d0
	orl d1,d0
	movel d0,a6@(-4)
	movel a6@(8),d0
	movel d0,d1
	movel a6@(24),d2
	asrl d2,d1
	movel d1,a6@(-8)
L18:
	movel a6@(-16),d0
	movel a6@(-12),d1
	movel a6@(-8),d3
	addl a6@(-4),d1
	addxl d3,d0
	moveml a6@(-56),#0x3c
	unlk a6
	rts
	.align	1
	.globl _ull
_ull:
	pea a6@
	movel sp,a6
	movel d3,sp@-
	movel d2,sp@-
	movel a6@(20),sp@-
	movel a6@(16),sp@-
	movel a6@(12),sp@-
	movel a6@(8),sp@-
	jbsr ___udivdi3
	addw #16,sp
	movel d0,d2
	movel d1,d3
	movel a6@(8),d0
	movel a6@(12),d1
	movel a6@(20),sp@-
	movel a6@(16),sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___umoddi3
	addw #16,sp
	addl d3,d1
	addxl d2,d0
	movel a6@(-8),d2
	movel a6@(-4),d3
	unlk a6
	rts
	.align	1
	.globl _fp
_fp:
	pea a6@
	movel sp,a6
	fmovem #0x4,sp@-
	fmoves a6@(16),fp0
	fmovex fp0,fp1
	fmuld a6@(8),fp1
	fmovel a6@(20),fp0
	faddx fp0,fp1
	fmoves a6@(16),fp0
	fmoved a6@(8),fp2
	fdivx fp0,fp2
	fmovex fp2,fp0
	fmovex fp1,fp2
	fsubx fp0,fp2
	movel a6@(12),sp@-
	movel a6@(8),sp@-
	jbsr ___fixdfdi
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___floatdidf
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	faddx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	fmovem a6@(-12),#0x20
	unlk a6
	rts
	.align	1
	.globl _fp2
_fp2:
	pea a6@
	movel sp,a6
	fmoves a6@(8),fp1
	fsglmuls a6@(12),fp1
	fmoves a6@(8),fp0
	fsgldivs a6@(12),fp0
	faddx fp1,fp0
	fmoves fp0,d0
	unlk a6
	rts
	.align	1
	.globl _cmp
_cmp:
	link a6,#-8
	fmoved a6@(8),fp0
	fcmpd a6@(16),fp0
	fjlt L29
	jra L27
L29:
	moveq #1,d0
	movel d0,a6@(-8)
	jra L30
L27:
	fmoved a6@(8),fp0
	fcmpd a6@(16),fp0
	fjeq L33
	jra L31
L33:
	moveq #2,d0
	movel d0,a6@(-4)
	jra L34
L31:
	moveq #3,d0
	movel d0,a6@(-4)
L34:
	movel a6@(-4),a6@(-8)
L30:
	movel a6@(-8),d0
	unlk a6
	rts
	.align	1
	.globl _vsum
_vsum:
	link a6,#-8
	clrl a6@(-4)
	lea a6@(12),a0
	movel a0,a6@(-8)
	jra L37
L38:
	movel a6@(-8),d1
	movel d1,d0
	addql #4,d0
	movel d0,a6@(-8)
	movel d1,a0
	movel a0@,d0
	addl d0,a6@(-4)
L37:
	subql #1,a6@(8)
	moveq #-1,d0
	cmpl a6@(8),d0
	jne L38
	movel a6@(-4),d0
	unlk a6
	rts
	.globl _fptr
	.data
	.align	1
_fptr:
	.long	_ext
	.text
	.align	1
	.globl _callptr
_callptr:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	movel a6@(12),sp@-
	movel a6@(8),a0
	jbsr a0@
	addql #4,sp
	movel d0,d2
	movel _fptr,a0
	movel a6@(12),sp@-
	jbsr a0@
	addql #4,sp
	addl d2,d0
	movel a6@(-4),d2
	unlk a6
	rts
	.align	1
	.globl _al
_al:
	link a6,#-8
	movel a6@(8),d0
	addql #1,d0
	addql #3,d0
	lsrl #2,d0
	lsll #2,d0
	subl d0,sp
	movel sp,a6@(-8)
	movel a6@(-8),d0
	addql #1,d0
	lsrl #1,d0
	addl d0,d0
	movel d0,a6@(-8)
	movel a6@(-8),a6@(-4)
	movel a6@(-4),a0
	moveb #1,a0@
	movel a6@(-4),a0
	moveb a0@,d0
	extbl d0
	movel d0,sp@-
	jbsr _ext
	addql #4,sp
	unlk a6
	rts
	.align	1
	.globl _mixed
_mixed:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	movel a6@(8),d0
	addl a6@(20),d0
	addl a6@(32),d0
	addl a6@(36),d0
	addl a6@(40),d0
	movel d0,d2
	addl a6@(44),d2
	fmoved a6@(12),fp0
	faddd a6@(24),fp0
	fmoved fp0,sp@-
	jbsr _ext2
	addql #8,sp
	addl d2,d0
	movel a6@(-4),d2
	unlk a6
	rts
	.align	1
	.globl _retbig
_retbig:
	link a6,#-80
	movel d2,sp@-
	movel a1,d2
	movel a6@(8),a6@(-80)
	movel d2,d1
	lea a6@(-80),a0
	moveq #80,d0
	movel d0,sp@-
	movel a0,sp@-
	movel d1,sp@-
	jbsr _memcpy
	addw #12,sp
	movel d2,d0
	movel a6@(-84),d2
	unlk a6
	rts
	.align	1
	.globl _usebig
_usebig:
	link a6,#-80
	pea 3:w
	lea a6@(-80),a0
	movel a0,a1
	jbsr _retbig
	addql #4,sp
	movel a6@(-80),d0
	unlk a6
	rts
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
	.globl _usesq
_usesq:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	movel a6@(8),sp@-
	jbsr _sq
	addql #4,sp
	movel d0,d2
	movel a6@(8),d0
	addql #1,d0
	movel d0,sp@-
	jbsr _sq
	addql #4,sp
	addl d2,d0
	movel a6@(-4),d2
	unlk a6
	rts
	.align	1
_sq:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	mulsl a6@(8),d0
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
	movel a6@(8),a0
	movel a0@,d0
	unlk a6
	rts
