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
__ZnwmPv:
	pea a6@
	movel sp,a6
	movel a6@(12),d0
	unlk a6
	rts
	.align	1
	.globl __ZdlPv
__ZdlPv:
	pea a6@
	movel sp,a6
	unlk a6
	rts
	.align	1
__ZN5ShapeC2Ei:
	pea a6@
	movel sp,a6
	movel #__ZTV5Shape+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),a0
	movel a6@(12),a0@(4)
	movel __ZL6norder,d1
	movel d1,d0
	lsll #2,d0
	lea __ZL5order,a0
	movel a6@(12),a0@(d0:l)
	movel d1,d0
	addql #1,d0
	movel d0,__ZL6norder
	unlk a6
	rts
	.align	1
__ZN5ShapeD2Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV5Shape+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	addl d1,d1
	movel d1,d0
	lsll #2,d0
	addl d0,d1
	movel a6@(8),a0
	movel a0@(4),d0
	addl d1,d0
	movel d0,__ZL10dtor_order
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L11
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L11:
	unlk a6
	rts
	.align	1
__ZN5ShapeD1Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV5Shape+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	addl d1,d1
	movel d1,d0
	lsll #2,d0
	addl d0,d1
	movel a6@(8),a0
	movel a0@(4),d0
	addl d1,d0
	movel d0,__ZL10dtor_order
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L16
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L16:
	unlk a6
	rts
	.align	1
__ZN5ShapeD0Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV5Shape+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel __ZL10dtor_order,d0
	movel d0,d1
	addl d1,d1
	movel d1,d0
	lsll #2,d0
	addl d0,d1
	movel a6@(8),a0
	movel a0@(4),d0
	addl d1,d0
	movel d0,__ZL10dtor_order
	moveq #1,d0
	moveb d0,d0
	tstb d0
	jeq L21
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L21:
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
	movel a0@(4),d0
	fmovel d0,fp0
	fmuld a6@(12),fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZNK5Shape5twiceEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@,d0
	movel d0,a0
	addql #8,a0
	movel a0@,a0
	movel a6@(8),sp@-
	jbsr a0@
	addql #4,sp
	addl d0,d0
	unlk a6
	rts
	.align	1
__ZN4RectC2Eii:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	pea 1:w
	movel d0,sp@-
	jbsr __ZN5ShapeC2Ei
	addql #8,sp
	movel #__ZTV4Rect+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),a0
	movel a6@(12),a0@(8)
	movel a6@(8),a0
	movel a6@(16),a0@(12)
	unlk a6
	rts
	.align	1
__ZN4RectC1Eii:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	pea 1:w
	movel d0,sp@-
	jbsr __ZN5ShapeC2Ei
	addql #8,sp
	movel #__ZTV4Rect+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),a0
	movel a6@(12),a0@(8)
	movel a6@(8),a0
	movel a6@(16),a0@(12)
	unlk a6
	rts
	.align	1
__ZNK4Rect4areaEv:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(8),d1
	movel a6@(8),a0
	movel a0@(12),d0
	mulsl d1,d0
	unlk a6
	rts
	.align	1
__ZN4RectD2Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV4Rect+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN5ShapeD2Ev
	addql #4,sp
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L38
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L38:
	unlk a6
	rts
	.align	1
__ZN4RectD1Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV4Rect+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN5ShapeD2Ev
	addql #4,sp
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L43
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L43:
	unlk a6
	rts
	.align	1
__ZN4RectD0Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV4Rect+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN5ShapeD2Ev
	addql #4,sp
	moveq #1,d0
	moveb d0,d0
	tstb d0
	jeq L48
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L48:
	unlk a6
	rts
	.align	1
__ZN6SquareC1Ei:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel a6@(12),sp@-
	movel a6@(12),sp@-
	movel d0,sp@-
	jbsr __ZN4RectC2Eii
	addw #12,sp
	movel #__ZTV6Square+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),a0
	moveq #2,d0
	movel d0,a0@(4)
	unlk a6
	rts
	.align	1
__ZNK6Square4areaEv:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZNK4Rect4areaEv
	addql #4,sp
	addql #1,d0
	unlk a6
	rts
	.align	1
__ZNK6Square5scaleEd:
	pea a6@
	movel sp,a6
	fmoved a6@(12),fp0
	fdivd #0r2.0e+0,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZN5MixinC2Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV5Mixin+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),a0
	moveq #40,d0
	movel d0,a0@(4)
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
__ZN4BothC1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	pea 3:w
	movel d0,sp@-
	jbsr __ZN5ShapeC2Ei
	addql #8,sp
	movel a6@(8),d0
	addql #8,d0
	movel d0,sp@-
	jbsr __ZN5MixinC2Ev
	addql #4,sp
	movel #__ZTV4Both+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel #__ZTV4Both+36,d0
	movel a6@(8),a0
	movel d0,a0@(8)
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
__ZN3VecC1Edd:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a6@(12),d0
	movel a6@(16),d1
	movel d0,a0@
	movel d1,a0@(4)
	movel a6@(8),a0
	movel a6@(20),d0
	movel a6@(24),d1
	movel d0,a0@(8)
	movel d1,a0@(12)
	unlk a6
	rts
	.align	1
__ZNK3VecplERKS_:
	pea a6@
	movel sp,a6
	fmovem #0x4,sp@-
	movel d2,sp@-
	movel a1,d2
	movel a6@(8),a0
	fmoved a0@(8),fp1
	movel a6@(12),a0
	fmoved a0@(8),fp0
	fmovex fp1,fp2
	faddx fp0,fp2
	movel a6@(8),a0
	fmoved a0@,fp1
	movel a6@(12),a0
	fmoved a0@,fp0
	faddx fp1,fp0
	fmoved fp2,sp@-
	fmoved fp0,sp@-
	movel d2,sp@-
	jbsr __ZN3VecC1Edd
	addw #20,sp
	movel d2,d0
	movel a6@(-16),d2
	fmovem a6@(-12),#0x20
	unlk a6
	rts
	.align	1
__ZN3VecmLEd:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	fmoved a0@,fp0
	fmuld a6@(12),fp0
	movel a6@(8),a0
	fmoved fp0,a0@
	movel a6@(8),a0
	fmoved a0@(8),fp0
	fmuld a6@(12),fp0
	movel a6@(8),a0
	fmoved fp0,a0@(8)
	movel a6@(8),d0
	unlk a6
	rts
	.align	1
__ZNK3VeceqERKS_:
	link a6,#-4
	movel a6@(8),a0
	fmoved a0@,fp1
	movel a6@(12),a0
	fmoved a0@,fp0
	fcmpx fp0,fp1
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jne L72
	movel a6@(8),a0
	fmoved a0@(8),fp1
	movel a6@(12),a0
	fmoved a0@(8),fp0
	fcmpx fp0,fp1
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jne L72
	moveb #1,a6@(-1)
	jra L75
L72:
	clrb a6@(-1)
L75:
	clrl d0
	moveb a6@(-1),d0
	unlk a6
	rts
	.align	1
__ZN6GlobalC1Ev:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	moveq #77,d0
	movel d0,a0@
	movel __ZL10ctor_order,d0
	movel d0,d1
	addl d1,d1
	movel d1,d0
	lsll #2,d0
	addl d1,d0
	addql #1,d0
	movel d0,__ZL10ctor_order
	unlk a6
	rts
	.align	1
__ZN6GlobalD1Ev:
	pea a6@
	movel sp,a6
	unlk a6
	rts
	.align	1
__ZL7ref_setRii:
	link a6,#-4
	movel a6@(8),a0
	movel a0@,a6@(-4)
	movel a6@(8),a0
	movel a6@(12),a0@
	movel a6@(-4),d0
	unlk a6
	rts
	.align	1
__ZL10overloadedi:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	unlk a6
	rts
	.align	1
__ZL10overloadedd:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	fmoved a6@(8),fp0
	faddx fp0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel sp@+,d2
	unlk a6
	rts
	.align	1
__ZL10overloadedPKc:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	moveb a0@,d0
	extbl d0
	unlk a6
	rts
	.align	1
__ZN6SquareD1Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV6Square+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN4RectD2Ev
	addql #4,sp
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L94
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L94:
	unlk a6
	rts
	.align	1
__ZN6SquareD0Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV6Square+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN4RectD2Ev
	addql #4,sp
	moveq #1,d0
	moveb d0,d0
	tstb d0
	jeq L99
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L99:
	unlk a6
	rts
	.align	1
__ZN4BothD1Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV4Both+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel #__ZTV4Both+36,d0
	movel a6@(8),a0
	movel d0,a0@(8)
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN5ShapeD2Ev
	addql #4,sp
	clrl d0
	moveb d0,d0
	tstb d0
	jeq L104
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L104:
	unlk a6
	rts
	.align	1
__ZN4BothD0Ev:
	pea a6@
	movel sp,a6
	movel #__ZTV4Both+8,d0
	movel a6@(8),a0
	movel d0,a0@
	movel #__ZTV4Both+36,d0
	movel a6@(8),a0
	movel d0,a0@(8)
	movel a6@(8),d0
	movel d0,sp@-
	jbsr __ZN5ShapeD2Ev
	addql #4,sp
	moveq #1,d0
	moveb d0,d0
	tstb d0
	jeq L109
	movel a6@(8),sp@-
	jbsr __ZdlPv
	addql #4,sp
L109:
	unlk a6
	rts
	.align	1
__Z5maxofIiET_S0_S0_:
	link a6,#-4
	movel a6@(8),d0
	cmpl a6@(12),d0
	jle L111
	movel a6@(8),a6@(-4)
	jra L113
L111:
	movel a6@(12),a6@(-4)
L113:
	movel a6@(-4),d0
	unlk a6
	rts
	.align	1
__Z5maxofIdET_S0_S0_:
	link a6,#-8
	fmoved a6@(8),fp0
	fcmpd a6@(16),fp0
	fjgt L118
	jra L116
L118:
	movel a6@(8),a6@(-8)
	movel a6@(12),a6@(-4)
	jra L119
L116:
	movel a6@(16),a6@(-8)
	movel a6@(20),a6@(-4)
L119:
	movel a6@(-8),d0
	movel a6@(-4),d1
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZNK3ArrIiLi5EE3sumEv:
	link a6,#-8
	clrl a6@(-8)
	clrl a6@(-4)
	jra L122
L123:
	movel a6@(-4),d0
	movel a6@(8),a0
	movel a0@(d0:l:4),d0
	addl d0,a6@(-8)
	addql #1,a6@(-4)
L122:
	moveq #4,d0
	cmpl a6@(-4),d0
	jge L123
	movel a6@(-8),d0
	unlk a6
	rts
	.align	1
__ZNK3ArrIdLi3EE3sumEv:
	link a6,#-12
	clrl a6@(-12)
	clrl a6@(-8)
	clrl a6@(-4)
	jra L127
L128:
	movel a6@(-4),d0
	movel a6@(8),a0
	fmoved a0@(d0:l:8),fp0
	fmoved a6@(-12),fp1
	faddx fp0,fp1
	fmoved fp1,a6@(-12)
	addql #1,a6@(-4)
L127:
	moveq #2,d0
	cmpl a6@(-4),d0
	jge L128
	movel a6@(-12),d0
	movel a6@(-8),d1
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
__ZN7CounterIiEC1Ev:
	pea a6@
	movel sp,a6
	movel __ZN7CounterIiE5countE,d0
	addql #1,d0
	movel d0,__ZN7CounterIiE5countE
	unlk a6
	rts
	.align	1
__ZN7CounterIcEC1Ev:
	pea a6@
	movel sp,a6
	movel __ZN7CounterIcE5countE,d0
	addql #1,d0
	movel d0,__ZN7CounterIcE5countE
	unlk a6
	rts
	.align	1
__Z41__static_initialization_and_destruction_0ii:
	pea a6@
	movel sp,a6
	moveq #1,d0
	cmpl a6@(8),d0
	jne L136
	cmpl #65535,a6@(12)
	jne L136
	pea __ZL10global_obj
	jbsr __ZN6GlobalC1Ev
	addql #4,sp
L136:
	tstl a6@(8)
	jne L142
	cmpl #65535,a6@(12)
	jne L142
	pea __ZL10global_obj
	jbsr __ZN6GlobalD1Ev
	addql #4,sp
L142:
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
.cstring
LC0:
	.ascii "FAIL %d\12\0"
LC1:
	.ascii "A\0"
LC2:
	.ascii "cxxtest: %d failures\12\0"
	.text
	.align	1
	.globl _main
_main:
	link a6,#-212
	movel d2,sp@-
	movel __ZL10global_obj,d0
	moveq #77,d1
	cmpl d0,d1
	jeq L148
	pea 1:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L148:
	movel __ZL10ctor_order,d0
	moveq #1,d1
	cmpl d0,d1
	jeq L150
	pea 2:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L150:
	pea 4:w
	pea 3:w
	lea a6@(-44),a0
	movel a0,sp@-
	jbsr __ZN4RectC1Eii
	addw #12,sp
	pea 5:w
	lea a6@(-60),a0
	movel a0,sp@-
	jbsr __ZN6SquareC1Ei
	addql #8,sp
	lea a6@(-72),a0
	clrl a0@
	addql #4,a0
	clrl a0@
	addql #4,a0
	clrl a0@
	lea a6@(-44),a0
	movel a0,a6@(-72)
	lea a6@(-60),a0
	movel a0,a6@(-68)
	movel a6@(-72),a0
	movel a0@,d0
	movel d0,a0
	addql #8,a0
	movel a0@,a0
	movel a6@(-72),d0
	movel d0,sp@-
	jbsr a0@
	addql #4,sp
	moveq #12,d1
	cmpl d0,d1
	sne d0
	negb d0
	tstb d0
	jeq L152
	pea 3:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L152:
	movel a6@(-68),a0
	movel a0@,d0
	movel d0,a0
	addql #8,a0
	movel a0@,a0
	movel a6@(-68),d0
	movel d0,sp@-
	jbsr a0@
	addql #4,sp
	moveq #26,d1
	cmpl d0,d1
	sne d0
	negb d0
	tstb d0
	jeq L154
	pea 4:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L154:
	movel a6@(-72),d0
	movel d0,sp@-
	jbsr __ZNK5Shape5twiceEv
	addql #4,sp
	moveq #24,d1
	cmpl d0,d1
	jne L156
	movel a6@(-68),d0
	movel d0,sp@-
	jbsr __ZNK5Shape5twiceEv
	addql #4,sp
	moveq #52,d1
	cmpl d0,d1
	jeq L158
L156:
	moveb #1,a6@(-209)
	jra L159
L158:
	clrb a6@(-209)
L159:
	moveb a6@(-209),d0
	tstb d0
	jeq L160
	pea 5:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L160:
	movel a6@(-68),a0
	movel a0@,a0
	addw #12,a0
	movel a0@,a0
	movel a6@(-68),d0
	clrl sp@-
	movel #1076101120,sp@-
	movel d0,sp@-
	jbsr a0@
	addw #12,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r5.0e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jne L162
	movel a6@(-72),a0
	movel a0@,a0
	addw #12,a0
	movel a0@,a0
	movel a6@(-72),d0
	clrl sp@-
	movel #1076101120,sp@-
	movel d0,sp@-
	jbsr a0@
	addw #12,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r1.0e+1,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L164
L162:
	moveb #1,a6@(-208)
	jra L165
L164:
	clrb a6@(-208)
L165:
	moveb a6@(-208),d0
	tstb d0
	jeq L166
	pea 6:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L166:
	movel __ZL6norder,d0
	moveq #2,d1
	cmpl d0,d1
	jne L168
	movel __ZL5order,d0
	moveq #1,d1
	cmpl d0,d1
	jne L168
	movel __ZL5order+4,d0
	moveq #1,d1
	cmpl d0,d1
	jeq L171
L168:
	pea 7:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L171:
	lea a6@(-88),a0
	movel a0,sp@-
	jbsr __ZN4BothC1Ev
	addql #4,sp
	lea a6@(-88),a0
	movel a0,a6@(-12)
	moveq #-88,d0
	addl a6,d0
	movel d0,d1
	addql #8,d1
	movel d1,a6@(-8)
	movel a6@(-12),a0
	movel a0@,d0
	movel d0,a0
	addql #8,a0
	movel a0@,a0
	movel a6@(-12),sp@-
	jbsr a0@
	addql #4,sp
	moveq #100,d1
	cmpl d0,d1
	jne L172
	movel a6@(-8),a0
	movel a0@,a0
	movel a0@,a0
	movel a6@(-8),sp@-
	jbsr a0@
	addql #4,sp
	moveq #42,d1
	cmpl d0,d1
	jeq L174
L172:
	moveb #1,a6@(-207)
	jra L175
L174:
	clrb a6@(-207)
L175:
	moveb a6@(-207),d0
	tstb d0
	jeq L176
	pea 8:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L176:
	movel a6@(-8),d1
	movel a6@(-12),d0
	cmpl d1,d0
	jne L178
	pea 9:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L178:
	tstl a6@(-8)
	jeq L180
	movel a6@(-8),d0
	movel d0,a0
	subql #8,a0
	movel a0,a6@(-206)
	jra L182
L180:
	clrl a6@(-206)
L182:
	movel a6@(-206),a0
	movel a0@(4),d0
	moveq #3,d1
	cmpl d0,d1
	jeq L183
	pea 10:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L183:
	pea 9:w
	pea 3:w
	jbsr __Z5maxofIiET_S0_S0_
	addql #8,sp
	moveq #9,d1
	cmpl d0,d1
	jne L185
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
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L187
L185:
	moveb #1,a6@(-201)
	jra L188
L187:
	clrb a6@(-201)
L188:
	moveb a6@(-201),d0
	tstb d0
	jeq L189
	pea 11:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L189:
	moveq #1,d0
	movel d0,a6@(-108)
	moveq #2,d1
	movel d1,a6@(-104)
	moveq #3,d0
	movel d0,a6@(-100)
	moveq #4,d1
	movel d1,a6@(-96)
	moveq #5,d0
	movel d0,a6@(-92)
	movel #1071644672,a6@(-132)
	clrl a6@(-128)
	movel #1073217536,a6@(-124)
	clrl a6@(-120)
	movel #1073741824,a6@(-116)
	clrl a6@(-112)
	lea a6@(-108),a0
	movel a0,sp@-
	jbsr __ZNK3ArrIiLi5EE3sumEv
	addql #4,sp
	moveq #15,d1
	cmpl d0,d1
	jne L191
	movel a6,d0
	addl #-132,d0
	movel d0,sp@-
	jbsr __ZNK3ArrIdLi3EE3sumEv
	addql #4,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r4.0e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L193
L191:
	moveb #1,a6@(-200)
	jra L194
L193:
	clrb a6@(-200)
L194:
	moveb a6@(-200),d0
	tstb d0
	jeq L195
	pea 12:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L195:
	movel a6,d0
	addl #-134,d0
	movel d0,sp@-
	jbsr __ZN7CounterIiEC1Ev
	addql #4,sp
	movel a6,d0
	addl #-136,d0
	movel d0,sp@-
	jbsr __ZN7CounterIiEC1Ev
	addql #4,sp
	movel a6,d0
	addl #-138,d0
	movel d0,sp@-
	jbsr __ZN7CounterIcEC1Ev
	addql #4,sp
	movel __ZN7CounterIiE5countE,d0
	moveq #2,d1
	cmpl d0,d1
	jne L197
	movel __ZN7CounterIcE5countE,d0
	moveq #1,d1
	cmpl d0,d1
	jeq L199
L197:
	pea 13:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L199:
	clrl sp@-
	movel #1073741824,sp@-
	clrl sp@-
	movel #1072693248,sp@-
	movel a6,d0
	addl #-154,d0
	movel d0,sp@-
	jbsr __ZN3VecC1Edd
	addw #20,sp
	clrl sp@-
	movel #1070596096,sp@-
	clrl sp@-
	movel #1071644672,sp@-
	movel a6,d0
	addl #-170,d0
	movel d0,sp@-
	jbsr __ZN3VecC1Edd
	addw #20,sp
	movel a6,d0
	addl #-170,d0
	movel d0,sp@-
	movel a6,d0
	addl #-154,d0
	movel d0,sp@-
	movel a6,d0
	addl #-186,d0
	movel d0,a1
	jbsr __ZNK3VecplERKS_
	addql #8,sp
	clrl sp@-
	movel #1073741824,sp@-
	movel a6,d0
	addl #-186,d0
	movel d0,sp@-
	jbsr __ZN3VecmLEd
	addw #12,sp
	fmoved a6@(-186),fp0
	fcmpd #0r3.0e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jne L200
	fmoved a6@(-178),fp0
	fcmpd #0r4.5e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L202
L200:
	pea 14:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L202:
	clrl sp@-
	movel #1074921472,sp@-
	clrl sp@-
	movel #1074266112,sp@-
	lea a6@(-28),a0
	movel a0,sp@-
	jbsr __ZN3VecC1Edd
	addw #20,sp
	lea a6@(-28),a0
	movel a0,sp@-
	movel a6,d0
	addl #-186,d0
	movel d0,sp@-
	jbsr __ZNK3VeceqERKS_
	addql #8,sp
	eorb #1,d0
	tstb d0
	jne L203
	movel a6,d0
	addl #-154,d0
	movel d0,sp@-
	movel a6,d0
	addl #-186,d0
	movel d0,sp@-
	jbsr __ZNK3VeceqERKS_
	addql #8,sp
	tstb d0
	jeq L205
L203:
	moveb #1,a6@(-199)
	jra L206
L205:
	clrb a6@(-199)
L206:
	moveb a6@(-199),d0
	tstb d0
	jeq L207
	pea 15:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L207:
	moveq #5,d0
	movel d0,a6@(-190)
	pea 9:w
	movel a6,d0
	addl #-190,d0
	movel d0,sp@-
	jbsr __ZL7ref_setRii
	addql #8,sp
	moveq #5,d1
	cmpl d0,d1
	jne L209
	movel a6@(-190),d0
	moveq #9,d1
	cmpl d0,d1
	jeq L211
L209:
	moveb #1,a6@(-198)
	jra L212
L211:
	clrb a6@(-198)
L212:
	moveb a6@(-198),d0
	tstb d0
	jeq L213
	pea 16:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L213:
	pea 4:w
	jbsr __ZL10overloadedi
	addql #4,sp
	moveq #4,d1
	cmpl d0,d1
	jne L215
	clrl sp@-
	movel #1073217536,sp@-
	jbsr __ZL10overloadedd
	addql #8,sp
	moveq #3,d1
	cmpl d0,d1
	jne L215
	pea LC1
	jbsr __ZL10overloadedPKc
	addql #4,sp
	moveq #65,d1
	cmpl d0,d1
	jeq L218
L215:
	moveb #1,a6@(-197)
	jra L219
L218:
	clrb a6@(-197)
L219:
	moveb a6@(-197),d0
	tstb d0
	jeq L220
	pea 17:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L220:
	addw #-20,sp
	movel sp,a6@(-196)
	movel a6@(-196),d0
	addql #1,d0
	lsrl #1,d0
	addl d0,d0
	movel d0,a6@(-196)
	movel a6@(-196),d0
	movel d0,sp@-
	pea 16:w
	jbsr __ZnwmPv
	addql #8,sp
	movel d0,d2
	pea 3:w
	pea 2:w
	movel d2,sp@-
	jbsr __ZN4RectC1Eii
	addw #12,sp
	movel d2,a6@(-4)
	movel a6@(-4),a0
	movel a0@,d0
	movel d0,a0
	addql #8,a0
	movel a0@,a0
	movel a6@(-4),sp@-
	jbsr a0@
	addql #4,sp
	moveq #6,d1
	cmpl d0,d1
	sne d0
	negb d0
	tstb d0
	jeq L222
	pea 18:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L222:
	movel a6@(-4),a0
	movel a0@,a0
	movel a0@,a0
	movel a6@(-4),sp@-
	jbsr a0@
	addql #4,sp
	movel __ZL10dtor_order,d0
	moveq #1,d1
	cmpl d0,d1
	jeq L224
	pea 19:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d0
	addql #1,d0
	movel d0,__ZL8failures
L224:
	movel __ZL8failures,d0
	movel d0,sp@-
	pea LC2
	jbsr _printf
	addql #8,sp
	movel __ZL8failures,d2
	lea a6@(-88),a0
	movel a0,sp@-
	jbsr __ZN4BothD1Ev
	addql #4,sp
	lea a6@(-60),a0
	movel a0,sp@-
	jbsr __ZN6SquareD1Ev
	addql #4,sp
	lea a6@(-44),a0
	movel a0,sp@-
	jbsr __ZN4RectD1Ev
	addql #4,sp
	movel d2,d0
	movel a6@(-216),d2
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
