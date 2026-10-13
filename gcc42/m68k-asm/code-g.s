	.stabs	"code.c",100,0,2,Ltext0
	.text
Ltext0:
	.stabs	"",102,0,0,0
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t1=r1;-2147483648;2147483647;",128,0,0,0
	.stabs	"char:t2=r2;0;127;",128,0,0,0
	.stabs	"long int:t3=r3;-2147483648;2147483647;",128,0,0,0
	.stabs	"unsigned int:t4=r4;0;037777777777;",128,0,0,0
	.stabs	"long unsigned int:t5=r5;0;037777777777;",128,0,0,0
	.stabs	"long long int:t6=@s64;r6;01000000000000000000000;0777777777777777777777;",128,0,0,0
	.stabs	"long long unsigned int:t7=@s64;r7;0;01777777777777777777777;",128,0,0,0
	.stabs	"short int:t8=@s16;r8;-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t9=@s16;r9;0;65535;",128,0,0,0
	.stabs	"signed char:t10=@s8;r10;-128;127;",128,0,0,0
	.stabs	"unsigned char:t11=@s8;r11;0;255;",128,0,0,0
	.stabs	"float:t12=r1;4;0;",128,0,0,0
	.stabs	"double:t13=r1;8;0;",128,0,0,0
	.stabs	"long double:t14=r1;12;0;",128,0,0,0
	.stabs	"void:t15=15",128,0,0,0
	.stabs	"va_list:t16=17",128,0,2,0
	.align	1
	.globl _sw
_sw:
	.stabd	46,0,0
	.stabd	68,0,5
LFBB1:
	link a6,#-4
	.stabd	68,0,6
	moveq #7,d0
	cmpl a6@(8),d0
	jcs L2
	.stabd	68,0,6
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
	.stabd	68,0,7
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
	.stabs	"sw:F1",36,0,5,_sw
	.stabs	"x:p1",160,0,5,8
	.stabs	"__builtin_va_list:t17=*15",128,0,0,0
Lscope1:
	.align	1
	.globl _ll
_ll:
	.stabd	46,0,0
	.stabd	68,0,9
LFBB2:
	link a6,#-40
	moveml #0x3c00,sp@-
	moveq #-32,d0
	addl a6@(24),d0
	movel d0,a6@(-36)
	tstl a6@(-36)
	jlt L15
	.stabd	68,0,9
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
	.stabs	"ll:F6",36,0,9,_ll
	.stabs	"a:p6",160,0,9,8
	.stabs	"b:p6",160,0,9,16
	.stabs	"s:p1",160,0,9,24
Lscope2:
	.align	1
	.globl _ull
_ull:
	.stabd	46,0,0
	.stabd	68,0,10
LFBB3:
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
	.stabs	"ull:F7",36,0,10,_ull
	.stabs	"a:p7",160,0,10,8
	.stabs	"b:p7",160,0,10,16
Lscope3:
	.align	1
	.globl _fp
_fp:
	.stabd	46,0,0
	.stabd	68,0,11
LFBB4:
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
	.stabs	"fp:F13",36,0,11,_fp
	.stabs	"a:p13",160,0,11,8
	.stabs	"b:p12",160,0,11,16
	.stabs	"i:p1",160,0,11,20
Lscope4:
	.align	1
	.globl _fp2
_fp2:
	.stabd	46,0,0
	.stabd	68,0,12
LFBB5:
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
	.stabs	"fp2:F12",36,0,12,_fp2
	.stabs	"a:p12",160,0,12,8
	.stabs	"b:p12",160,0,12,12
Lscope5:
	.align	1
	.globl _cmp
_cmp:
	.stabd	46,0,0
	.stabd	68,0,13
LFBB6:
	link a6,#-8
	fmoved a6@(8),fp0
	fcmpd a6@(16),fp0
	fjlt L29
	.stabd	68,0,13
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
	.stabs	"cmp:F1",36,0,13,_cmp
	.stabs	"a:p13",160,0,13,8
	.stabs	"b:p13",160,0,13,16
Lscope6:
	.align	1
	.globl _vsum
_vsum:
	.stabd	46,0,0
	.stabd	68,0,14
LFBB7:
	link a6,#-8
	clrl a6@(-4)
	lea a6@(12),a0
	movel a0,a6@(-8)
	.stabd	68,0,15
	jra L37
L38:
	.stabd	68,0,15
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
	.stabs	"vsum:F1",36,0,14,_vsum
	.stabs	"n:p1",160,0,14,8
	.stabs	"ap:16",128,0,14,-8
	.stabs	"s:1",128,0,14,-4
	.stabn	192,0,0,LFBB7
	.stabn	224,0,0,Lscope7
Lscope7:
	.globl _fptr
	.data
	.align	1
_fptr:
	.long	_ext
	.text
	.align	1
	.globl _callptr
_callptr:
	.stabd	46,0,0
	.stabd	68,0,17
LFBB8:
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
	.stabs	"callptr:F1",36,0,17,_callptr
	.stabs	"f:p18",160,0,17,8
	.stabs	"x:p1",160,0,17,12
	.stabs	":t18=*19",128,0,0,0
	.stabs	":t19=f1",128,0,0,0
Lscope8:
	.align	1
	.globl _al
_al:
	.stabd	46,0,0
	.stabd	68,0,18
LFBB9:
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
	.stabs	"al:F1",36,0,18,_al
	.stabs	"n:p1",160,0,18,8
	.stabs	"p:20",128,0,18,-4
	.stabn	192,0,0,LFBB9
	.stabn	224,0,0,Lscope9
	.stabs	":t20=*2",128,0,0,0
Lscope9:
	.align	1
	.globl _mixed
_mixed:
	.stabd	46,0,0
	.stabd	68,0,19
LFBB10:
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
	.stabs	"mixed:F1",36,0,19,_mixed
	.stabs	"a:p1",160,0,19,8
	.stabs	"b:p13",160,0,19,12
	.stabs	"c:p1",160,0,19,20
	.stabs	"d:p13",160,0,19,24
	.stabs	"e:p1",160,0,19,32
	.stabs	"f:p1",160,0,19,36
	.stabs	"g:p1",160,0,19,40
	.stabs	"h:p1",160,0,19,44
Lscope10:
	.stabs	"big:T21=s80a:22,0,640;;",128,0,0,0
	.align	1
	.globl _retbig
_retbig:
	.stabd	46,0,0
	.stabd	68,0,21
LFBB11:
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
	.stabs	"retbig:F21",36,0,21,_retbig
	.stabs	"x:p1",160,0,21,8
	.stabs	"b:21",128,0,21,-80
	.stabn	192,0,0,LFBB11
	.stabn	224,0,0,Lscope11
	.stabs	":t22=ar23=r23;0;037777777777;;0;19;1",128,0,0,0
Lscope11:
	.align	1
	.globl _usebig
_usebig:
	.stabd	46,0,0
	.stabd	68,0,22
LFBB12:
	link a6,#-80
	pea 3:w
	lea a6@(-80),a0
	movel a0,a1
	jbsr _retbig
	addql #4,sp
	movel a6@(-80),d0
	unlk a6
	rts
	.stabs	"usebig:F1",36,0,22,_usebig
Lscope12:
	.align	1
	.globl _ctor
_ctor:
	.stabd	46,0,0
	.stabd	68,0,23
LFBB13:
	pea a6@
	movel sp,a6
	pea 1:w
	jbsr _ext
	addql #4,sp
	unlk a6
	rts
	.stabs	"ctor:F15",36,0,23,_ctor
Lscope13:
.constructor
	.align	2
	.long	_ctor
.reference .constructors_used
	.text
	.align	1
	.globl _dtor
_dtor:
	.stabd	46,0,0
	.stabd	68,0,24
LFBB14:
	pea a6@
	movel sp,a6
	pea 2:w
	jbsr _ext
	addql #4,sp
	unlk a6
	rts
	.stabs	"dtor:F15",36,0,24,_dtor
Lscope14:
.destructor
	.align	2
	.long	_dtor
.reference .destructors_used
	.text
	.align	1
	.globl _weakfn
_weakfn:
	.stabd	46,0,0
	.stabd	68,0,25
LFBB15:
	pea a6@
	movel sp,a6
	moveq #1,d0
	unlk a6
	rts
	.stabs	"weakfn:F1",36,0,25,_weakfn
Lscope15:
	.align	1
	.globl _weakref_user
_weakref_user:
	.stabd	46,0,0
	.stabd	68,0,26
LFBB16:
	pea a6@
	movel sp,a6
	jbsr _weakfn
	unlk a6
	rts
	.stabs	"weakref_user:F1",36,0,26,_weakref_user
Lscope16:
	.align	1
	.globl _usesq
_usesq:
	.stabd	46,0,0
	.stabd	68,0,28
LFBB17:
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
	.stabs	"usesq:F1",36,0,28,_usesq
	.stabs	"x:p1",160,0,28,8
Lscope17:
	.align	1
_sq:
	.stabd	46,0,0
	.stabd	68,0,27
LFBB18:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	mulsl a6@(8),d0
	unlk a6
	rts
	.stabs	"sq:f1",36,0,27,_sq
	.stabs	"x:p1",160,0,27,8
Lscope18:
	.align	1
	.globl _volatile_rw
_volatile_rw:
	.stabd	46,0,0
	.stabd	68,0,29
LFBB19:
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	moveq #1,d0
	movel d0,a0@
	movel a6@(8),a0
	movel a0@,d0
	unlk a6
	rts
	.stabs	"volatile_rw:F1",36,0,29,_volatile_rw
	.stabs	"p:p24",160,0,29,8
	.stabs	":t24=*25",128,0,0,0
	.stabs	":t25=B1",128,0,0,0
Lscope19:
	.stabs	"fptr:G18",32,0,16,0
	.text
	.stabs "",100,0,0,Letext
Letext:
