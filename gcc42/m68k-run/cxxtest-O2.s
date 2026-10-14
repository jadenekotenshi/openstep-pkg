.constructor
	.align	2
	.long	__GLOBAL__I__ZdlPv
.reference .constructors_used
.destructor
	.align	2
	.long	__GLOBAL__D__ZdlPv
.reference .destructors_used
	.text
	.align	1
	.globl __ZdlPv
__ZdlPv:
	pea a6@
	movel sp,a6
	unlk a6
	rts
	.align	1
__ZN5ShapeD0Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZNK5Shape4areaEv:
	pea a6@
	movel sp,a6
	clrl d0
	unlk a6
	rts
	.align	1
__ZNK5Shape5scaleEd:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	fmoved a6@(12),fp0
	fmull a0@(4),fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZNK4Rect4areaEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(12),d0
	mulsl a0@(8),d0
	unlk a6
	rts
	.align	1
__ZNK6Square5scaleEd:
	pea a6@
	movel sp,a6
	fmoved a6@(12),fp0
	fmuld #0r5.0e-1,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZNK5Mixin3mixEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(4),d0
	unlk a6
	rts
	.align	1
__ZNK4Both4areaEv:
	pea a6@
	movel sp,a6
	moveq #100,d0
	unlk a6
	rts
	.align	1
__ZThn8_NK4Both3mixEv:
	subql #8,sp@(4)
	jra __ZNK4Both3mixEv
	.align	1
__ZNK4Both3mixEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(12),d0
	addql #2,d0
	unlk a6
	rts
	.align	1
__ZN4BothD1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV4Both+36,a0@(8)
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__Z5maxofIiET_S0_S0_:
	pea a6@
	movel sp,a6
	movel a6@(8),d1
	movel a6@(12),d0
	cmpl d0,d1
	jle L24
	movel d1,d0
L24:
	unlk a6
	rts
	.align	1
__Z5maxofIdET_S0_S0_:
	pea a6@
	movel sp,a6
	fmoved a6@(8),fp0
	fcmpd a6@(16),fp0
	fjgt L29
	fmoved a6@(16),fp0
L29:
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__Z41__static_initialization_and_destruction_0ii:
	pea a6@
	movel sp,a6
	moveq #1,d0
	cmpl a6@(8),d0
	jne L38
	cmpl #65535,a6@(12)
	jne L38
	moveb #77,d0
	movel d0,__ZL10global_obj
	movel __ZL10ctor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	movel d0,a0
	lea a0@(1,d1:l),a0
	movel a0,__ZL10ctor_order
L38:
	unlk a6
	rts
	.align	1
__GLOBAL__I__ZdlPv:
	pea a6@
	movel sp,a6
	movel #65535,sp@-
	pea 1:w
	jbsr __Z41__static_initialization_and_destruction_0ii
	addql #8,sp
	unlk a6
	rts
	.align	1
__GLOBAL__D__ZdlPv:
	pea a6@
	movel sp,a6
	movel #65535,sp@-
	clrl sp@-
	jbsr __Z41__static_initialization_and_destruction_0ii
	addql #8,sp
	unlk a6
	rts
	.align	1
__ZNK6Square4areaEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(12),d0
	mulsl a0@(8),d0
	addql #1,d0
	unlk a6
	rts
	.align	1
__ZN4RectD0Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZN5ShapeD1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZN4BothD0Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV4Both+36,a0@(8)
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZN4RectD1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZN6SquareD0Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
	.align	1
__ZN6SquareD1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel #__ZTV5Shape+8,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a0@(4),d0
	movel d0,__ZL10dtor_order
	unlk a6
	rts
.cstring
LC0:
	.ascii "FAIL %d\12\0"
LC1:
	.ascii "cxxtest: %d failures\12\0"
	.text
	.align	1
	.globl _main
_main:
	link a6,#-92
	moveml #0x203c,sp@-
	lea _printf,a4
	moveq #77,d0
	cmpl __ZL10global_obj,d0
	jeq L66
	pea 1:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L66:
	moveq #1,d1
	cmpl __ZL10ctor_order,d1
	jeq L68
	pea 2:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L68:
	moveq #1,d2
	movel d2,a6@(-12)
	movel __ZL6norder,d0
	lea __ZL5order,a5
	movel d2,a5@(d0:l:4)
	addql #1,d0
	movel #__ZTV4Rect+8,a6@(-16)
	moveq #3,d1
	movel d1,a6@(-8)
	moveb #4,d2
	movel d2,a6@(-4)
	moveb #1,d1
	movel d1,a5@(d0:l:4)
	addql #1,d0
	movel d0,__ZL6norder
	moveb #5,d2
	movel d2,a6@(-24)
	movel d2,a6@(-20)
	movel #__ZTV6Square+8,a6@(-32)
	moveq #2,d0
	movel d0,a6@(-28)
	lea a6@(-16),a3
	movel a3,sp@-
	jbsr __ZNK4Rect4areaEv
	addql #4,sp
	moveq #12,d1
	cmpl d0,d1
	jeq L70
	pea 3:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L70:
	lea a6@(-32),a2
	movel a2,sp@-
	movel a6@(-32),a0
	movel a0@(8),a0
	jbsr a0@
	addql #4,sp
	moveq #26,d2
	cmpl d0,d2
	jeq L72
	pea 4:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L72:
	movel a3,sp@-
	movel a6@(-16),a0
	movel a0@(8),a0
	jbsr a0@
	addl d0,d0
	addql #4,sp
	moveq #24,d1
	cmpl d0,d1
	jeq L113
	pea 5:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L76:
	clrl sp@-
	movel #1076101120,sp@-
	movel a2,sp@-
	movel a6@(-32),a0
	movel a0@(12),a0
	jbsr a0@
	addw #12,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r5.0e+0,fp0
	fjne L77
	clrl sp@-
	movel #1076101120,sp@-
	movel a3,sp@-
	movel a6@(-16),a0
	movel a0@(12),a0
	jbsr a0@
	addw #12,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r1.0e+1,fp0
	fjeq L80
L77:
	pea 6:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L80:
	moveq #2,d0
	cmpl __ZL6norder,d0
	jeq L114
L81:
	pea 7:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L84:
	moveq #3,d2
	movel d2,a6@(-44)
	movel __ZL6norder,d0
	movel d2,a5@(d0:l:4)
	addql #1,d0
	movel d0,__ZL6norder
	moveq #40,d0
	movel d0,a6@(-36)
	movel #__ZTV4Both+8,a6@(-48)
	movel #__ZTV4Both+36,a6@(-40)
	lea a6@(-48),a3
	movel a3,sp@-
	jbsr __ZNK4Both4areaEv
	addql #4,sp
	moveq #100,d1
	cmpl d0,d1
	jeq L115
	lea a6@(-40),a2
	pea 8:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L87:
	cmpl a2,a3
	jeq L116
L88:
	moveq #3,d0
	cmpl a6@(-44),d0
	jeq L90
	pea 10:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L90:
	pea 9:w
	pea 3:w
	jbsr __Z5maxofIiET_S0_S0_
	addql #8,sp
	moveq #9,d1
	cmpl d0,d1
	jeq L117
	pea 11:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L94:
	moveq #1,d0
	movel d0,a6@(-68)
	moveq #2,d1
	movel d1,a6@(-64)
	moveq #3,d2
	movel d2,a6@(-60)
	moveb #4,d0
	movel d0,a6@(-56)
	moveb #5,d1
	movel d1,a6@(-52)
	movel #1071644672,a6@(-92)
	clrl a6@(-88)
	movel #1073217536,a6@(-84)
	clrl a6@(-80)
	movel #1073741824,a6@(-76)
	clrl a6@(-72)
	movel __ZN7CounterIiE5countE,d0
	addql #2,d0
	movel d0,__ZN7CounterIiE5countE
	movel __ZN7CounterIcE5countE,d1
	addql #1,d1
	movel d1,__ZN7CounterIcE5countE
	moveb #2,d2
	cmpl d0,d2
	jeq L118
	pea 13:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L100:
	addw #-20,sp
	movel sp,a2
	moveq #1,d1
	movel d1,sp@(4)
	movel __ZL6norder,d0
	movel d1,a5@(d0:l:4)
	addql #1,d0
	movel d0,__ZL6norder
	movel #__ZTV4Rect+8,sp@
	moveq #2,d2
	movel d2,sp@(8)
	moveq #3,d0
	movel d0,sp@(12)
	movel a2,sp@-
	movel __ZTV4Rect+16,a0
	jbsr a0@
	addql #4,sp
	moveq #6,d1
	cmpl d0,d1
	jeq L101
	pea 18:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
L101:
	movel a2@,a0
	movel a2,sp@-
	movel a0@,a0
	jbsr a0@
	addql #4,sp
	moveq #1,d2
	cmpl __ZL10dtor_order,d2
	jeq L103
	pea 19:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L103
L118:
	moveq #1,d0
	cmpl d1,d0
	jeq L100
	pea 13:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L100
L114:
	moveq #1,d1
	cmpl __ZL5order,d1
	jne L81
	cmpl __ZL5order+4,d1
	jeq L84
	pea 7:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L84
L117:
	clrl sp@-
	movel #-1074790400,sp@-
	clrl sp@-
	movel #1074003968,sp@-
	jbsr __Z5maxofIdET_S0_S0_
	addw #16,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r2.5e+0,fp0
	fjeq L94
	pea 11:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L94
L113:
	movel a2,sp@-
	movel a6@(-32),a0
	movel a0@(8),a0
	jbsr a0@
	addl d0,d0
	addql #4,sp
	moveq #52,d2
	cmpl d0,d2
	jeq L76
	pea 5:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L76
L115:
	lea a6@(-40),a2
	movel a2,sp@-
	movel a6@(-40),a0
	movel a0@,a0
	jbsr a0@
	addql #4,sp
	moveb #42,d2
	cmpl d0,d2
	jeq L87
	pea 8:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L87
L116:
	pea 9:w
	pea LC0
	jbsr a4@
	addql #1,__ZL8failures
	addql #8,sp
	jra L88
L103:
	movel __ZL8failures,sp@-
	pea LC1
	jbsr a4@
	movel __ZL10dtor_order,d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addql #8,sp
	addl a6@(-44),d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a6@(-28),d0
	movel d0,d1
	lsll #3,d1
	addl d0,d0
	addl d1,d0
	addl a6@(-12),d0
	movel d0,__ZL10dtor_order
	movel __ZL8failures,d0
	moveml a6@(-112),#0x3c04
	unlk a6
	rts
.lcomm __ZL10global_obj,4,1
.lcomm __ZL10ctor_order,4,1
.lcomm __ZL8failures,4,1
.lcomm __ZL6norder,4,1
.lcomm __ZL5order,32,1
	.comm __ZN7CounterIiE5countE,4
	.comm __ZN7CounterIcE5countE,4
.lcomm __ZL10dtor_order,4,1
.const
	.align	2
__ZTV6Square:
	.long	0
	.long	0
	.long	__ZN6SquareD1Ev
	.long	__ZN6SquareD0Ev
	.long	__ZNK6Square4areaEv
	.long	__ZNK6Square5scaleEd
	.align	2
__ZTV4Rect:
	.long	0
	.long	0
	.long	__ZN4RectD1Ev
	.long	__ZN4RectD0Ev
	.long	__ZNK4Rect4areaEv
	.long	__ZNK5Shape5scaleEd
	.align	2
__ZTV5Shape:
	.long	0
	.long	0
	.long	__ZN5ShapeD1Ev
	.long	__ZN5ShapeD0Ev
	.long	__ZNK5Shape4areaEv
	.long	__ZNK5Shape5scaleEd
	.align	2
__ZTV4Both:
	.long	0
	.long	0
	.long	__ZN4BothD1Ev
	.long	__ZN4BothD0Ev
	.long	__ZNK4Both4areaEv
	.long	__ZNK5Shape5scaleEd
	.long	__ZNK4Both3mixEv
	.long	-8
	.long	0
	.long	__ZThn8_NK4Both3mixEv
	.align	2
__ZTV5Mixin:
	.long	0
	.long	0
	.long	__ZNK5Mixin3mixEv
.constructor
.destructor
	.align	1
