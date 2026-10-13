	.text
	.align	1
	.globl _sw
_sw:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	moveq #4,d1
	cmpl d0,d1
	jeq L7
	jge L17
	moveq #6,d1
	cmpl d0,d1
	jeq L9
	jle L18
	moveq #66,d0
	jra L14
L17:
	moveb #1,d1
	cmpl d0,d1
	jeq L4
	jge L19
	moveq #2,d1
	cmpl d0,d1
	jeq L5
	moveb #3,d1
	cmpl d0,d1
	jeq L20
L2:
	moveq #-1,d0
	jra L14
L18:
	moveb #7,d1
	cmpl d0,d1
	jeq L10
	moveb #100,d1
	cmpl d0,d1
	jne L2
	moveq #5,d0
	jra L14
L19:
	tstl d0
	jne L2
	moveq #11,d0
	jra L14
L20:
	moveq #44,d0
	jra L14
L10:
	moveq #88,d0
	jra L14
L4:
	moveq #22,d0
	jra L14
L7:
	moveq #55,d0
	jra L14
L9:
	moveq #77,d0
	jra L14
L5:
	moveq #33,d0
L14:
	unlk a6
	rts
	.align	1
	.globl _mksmall
_mksmall:
	pea a6@
	movel sp,a6
	movel a6@(8),d1
	movel d1,d0
	addl d0,d0
	bfins d1,d0{#0:#8}
	unlk a6
	rts
	.align	1
	.globl _mkbig
_mkbig:
	link a6,#-80
	movel d2,sp@-
	movel a1,d2
	lea a6@(-80),a1
	movel a1,a0
	movel a6@(8),d0
L25:
	movel d0,a0@+
	addql #1,d0
	cmpl a0,a6
	jne L25
	pea 80:w
	movel a1,sp@-
	movel d2,sp@-
	jbsr _memcpy
	movel d2,d0
	movel a6@(-84),d2
	unlk a6
	rts
	.align	1
	.globl _mkmixed
_mkmixed:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	moveb #122,a1@(12)
	movel d0,a1@(8)
	fmoved #0r5.0e-1,fp0
	fmull d0,fp0
	fmoved fp0,a1@
	movel a1,d0
	unlk a6
	rts
	.align	1
	.globl _sumbig
_sumbig:
	pea a6@
	movel sp,a6
	lea a6@(8),a0
	clrl d0
	lea a6@(88),a1
L35:
	addl a0@+,d0
	cmpl a0,a1
	jne L35
	unlk a6
	rts
	.align	1
	.globl _mixarg
_mixarg:
	pea a6@
	movel sp,a6
	fmovem #0x4,sp@-
	fmoved a6@(12),fp2
	faddl a6@(8),fp2
	faddb a6@(23),fp2
	fmoves a6@(24),fp0
	faddx fp0,fp2
	movel a6@(32),sp@-
	movel a6@(28),sp@-
	jbsr ___floatdidf
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	faddx fp0,fp2
	faddw a6@(38),fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	fmovem a6@(-12),#0x20
	unlk a6
	rts
	.align	1
	.globl _fact
_fact:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	movel a6@(8),d1
	moveq #1,d0
	cmpl d1,d0
	jge L46
	moveq #1,d2
	movel d1,d0
	subql #1,d0
	mulsl d1,d2
	moveq #1,d1
	cmpl d0,d1
	jeq L49
L53:
	movel d0,d1
	movel d1,d0
	subql #1,d0
	mulsl d1,d2
	moveq #1,d1
	cmpl d0,d1
	jne L53
	jra L49
L46:
	moveq #1,d2
L49:
	movel d2,d0
	movel sp@+,d2
	unlk a6
	rts
	.align	1
	.globl _apply
_apply:
	pea a6@
	movel sp,a6
	movel a6@(12),sp@-
	movel a6@(8),a0
	jbsr a0@
	unlk a6
	rts
	.align	1
	.globl _twice
_twice:
	pea a6@
	movel sp,a6
	movel a6@(8),d0
	addl d0,d0
	unlk a6
	rts
	.align	1
_bump:
	pea a6@
	movel sp,a6
	addql #1,_cnt
	unlk a6
	rts
	.align	1
	.globl _use_alloca
_use_alloca:
	pea a6@
	movel sp,a6
	movel d2,sp@-
	movel a6@(8),a1
	movel a1,d0
	addql #4,d0
	moveq #-4,d1
	andl d1,d0
	subl d0,sp
	movel sp,a0
	tstl a1
	jle L74
	clrl d0
L65:
	moveb d0,a0@(d0:l)
	addql #1,d0
	cmpl d0,a1
	jne L65
	clrl d1
	clrl d2
L67:
	moveb a0@(d1:l),d0
	extbl d0
	addl d0,d2
	addql #1,d1
	cmpl d1,a1
	jeq L64
	moveb a0@(d1:l),d0
	extbl d0
	addl d0,d2
	addql #1,d1
	cmpl d1,a1
	jne L67
	jra L64
L74:
	clrl d2
L64:
	movel d2,d0
	movel a6@(-4),d2
	unlk a6
	rts
	.align	1
	.globl _dsum
_dsum:
	link a6,#-4
	movel a6@(8),d1
	lea a6@(12),a1
	movel a1,a6@(-4)
	tstl d1
	jeq L86
	movel a1,a0
	fmoved #0r0.0,fp0
	clrl d0
L80:
	faddd a0@+,fp0
	addql #1,d0
	cmpl d0,d1
	jne L80
	lsll #3,d0
	addl a1,d0
	movel d0,a6@(-4)
	jra L79
L86:
	fmoved #0r0.0,fp0
L79:
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
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
	jeq L98
	movel a2,a0
	clrl d0
	clrl d1
L92:
	addl a0@+,d0
	addql #1,d1
	cmpl d1,a1
	jne L92
	lsll #2,d1
	addl a2,d1
	movel d1,a6@(-4)
	jra L91
L98:
	clrl d0
L91:
	movel sp@+,a2
	unlk a6
	rts
.cstring
LC0:
	.ascii "FAIL %d\12\0"
LC1:
	.ascii "%s %d %ld %5.2f %c\12\0"
LC2:
	.ascii "selftest: %d failures\12\0"
	.text
	.align	1
	.globl _main
_main:
	link a6,#-184
	moveml #0x3c38,sp@-
	movel _vi,d1
	movel _vj,d0
	addl d1,d0
	lea _printf,a4
	moveq #4,d1
	cmpl d0,d1
	jeq L101
	pea 1:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L101:
	movel _vi,d0
	movel _vj,d1
	subl d1,d0
	moveq #10,d2
	cmpl d0,d2
	jeq L103
	pea 2:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L103:
	movel _vi,d1
	movel _vj,d0
	mulsl d1,d0
	moveq #-21,d3
	cmpl d0,d3
	jeq L105
	pea 3:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L105:
	movel _vi,d0
	movel _vj,d1
	divsl d1,d0
	moveq #-2,d1
	cmpl d0,d1
	jeq L107
	pea 4:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L107:
	movel _vi,d0
	movel _vj,d1
	divsll d1,d1:d0
	moveq #1,d2
	cmpl d1,d2
	jeq L109
	pea 5:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L109:
	movel _vi,d0
	subql #6,d0
	moveq #1,d3
	cmpl d0,d3
	jcc L111
	pea 6:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L111:
	movel _vu,d0
	lsrl #4,d0
	cmpl #268435455,d0
	jeq L113
	pea 7:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L113:
	movel _vi,d0
	lsll #3,d0
	moveq #56,d1
	cmpl d0,d1
	jeq L115
	pea 8:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L115:
	movel _vj,d0
	asrl #1,d0
	moveq #-2,d2
	cmpl d0,d2
	jeq L117
	pea 9:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L117:
	movel _vu,a0
	addw #16,a0
	moveq #15,d3
	cmpl a0,d3
	jcs L240
L119:
	movel _vu,d2
	movel d2,d1
	mulul #613566757,d0:d1
	movel d2,d1
	subl d0,d1
	lsrl #1,d1
	addl d1,d0
	lsrl #2,d0
	movel d0,d1
	lsll #3,d1
	subl d0,d1
	subl d1,d2
	moveq #2,d0
	cmpl d2,d0
	jeq L121
	pea 11:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L121:
	movew _vs,d1
	movew _vs,d0
	muls d1,d0
	cmpl #90000,d0
	jeq L123
	pea 12:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L123:
	moveb _vc,d0
	extbl d0
	addl d0,d0
	moveq #-10,d1
	cmpl d0,d1
	jeq L125
	pea 13:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L125:
	moveb _vc,d0
	cmpb #-5,d0
	jeq L127
	pea 14:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L127:
	movel _vi,d0
	moveq #5,d2
	andl d2,d0
	cmpl d0,d2
	jeq L241
L129:
	pea 15:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L133:
	movel _vl,d2
	movel _vl+4,d3
	movel _vm,d0
	movel _vm+4,d1
	movel d0,d4
	mulsl d3,d4
	movel d2,d5
	mulsl d1,d5
	addl d5,d4
	mulul d1,d2:d3
	addl d4,d2
	movel #-28254,d0
	movel #-1278945739,d1
	subl d3,d1
	subxl d2,d0
	jeq L134
	pea 16:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L134:
	movel _vl,d0
	movel _vl+4,d1
	movel _vm,a0
	movel _vm+4,a1
	movel a1,sp@-
	movel a0,sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___divdi3
	addw #16,sp
	moveq #-4,d2
	movel #-12004261,d3
	subl d3,d1
	subxl d2,d0
	jeq L136
	pea 17:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L136:
	movel _vl,d0
	movel _vl+4,d1
	movel _vm,a0
	movel _vm+4,a1
	movel a1,sp@-
	movel a0,sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #16,sp
	clrl d2
	moveq #38,d3
	subl d3,d1
	subxl d2,d0
	jeq L138
	pea 18:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L138:
	movel _vl,d0
	movel _vl+4,d1
	movel d1,d2
	moveq #23,d3
	lsrl d3,d2
	moveb #9,d3
	lsll d3,d0
	orl d2,d0
	lsll d3,d1
	movel #149130,d2
	movel #-820816384,d3
	subl d3,d1
	subxl d2,d0
	jeq L140
	pea 19:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L140:
	movel _vl,d0
	movel _vl+4,d1
	movel d0,d2
	moveq #27,d3
	lsll d3,d2
	lsrl #5,d1
	orl d2,d1
	asrl #5,d0
	moveq #9,d2
	movel #439041101,d3
	subl d3,d1
	subxl d2,d0
	jeq L142
	pea 20:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L142:
	movel _vl,d2
	movel _vl+4,d3
	movel _vl,d4
	movel _vl+4,d5
	movel d2,d0
	movel d3,d1
	addl d1,d1
	addxl d0,d0
	pea 3:w
	clrl sp@-
	addl d3,d1
	addxl d2,d0
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___udivdi3
	addw #16,sp
	subl d5,d1
	subxl d4,d0
	jeq L144
	pea 21:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L144:
	movel _vl,d2
	movel _vl+4,d3
	movel _vm,d0
	movel _vm+4,d1
	subl d1,d3
	subxl d0,d2
	jle L146
	movel _vm,d0
	movel _vm+4,d1
	tstl d0
	jmi L242
L146:
	pea 22:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L149:
	movel _vi,d0
	movel _vl,a0
	movel _vl+4,a1
	movel d0,d1
	smi d0
	extbl d0
	movel a0,d3
	addl a1,d1
	addxl d3,d0
	movel #291,d2
	movel #1164413362,d3
	subl d3,d1
	subxl d2,d0
	jeq L150
	pea 23:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L150:
	fmoved _vd,fp0
	fmoved _ve,fp1
	fmulx fp1,fp0
	fcmpd #0r-3.125e-1,fp0
	fjne L243
	fmoved _vd,fp0
	fmoved _ve,fp1
	fdivx fp1,fp0
	fcmpd #0r-2.0e+1,fp0
	fjne L244
L154:
	movel _vf,d0
	fmoved _vd,fp1
	fmoves d0,fp0
	faddx fp1,fp0
	fcmpd #0r4.0e+0,fp0
	fjne L245
L156:
	fmoves _vf,fp0
	faddx fp0,fp0
	fcmps #0r3.00000000e+0,fp0
	fjne L246
L158:
	fmoved _vd,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d3,fpcr
	moveq #2,d2
	cmpl d0,d2
	jeq L247
L160:
	pea 28:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L162:
	movel _vi,d0
	fmovel d0,fp0
	fcmpd #0r7.0e+0,fp0
	fjne L248
L163:
	fmoved _vd,fp0
	fmuld #0r1.0e+10,fp0
	fmoved fp0,sp@-
	jbsr ___fixdfdi
	addql #8,sp
	moveq #5,d2
	movel #-769803776,d3
	subl d3,d1
	subxl d2,d0
	jeq L165
	pea 30:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L165:
	fmoved _vd,fp1
	fmoved _ve,fp0
	fcmpx fp0,fp1
	fjngt L167
	fmoved _ve,fp0
	fjlt L170
L167:
	pea 31:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L170:
	fmoved _vd,fp0
	fmoves fp0,d3
	fmoves d3,fp0
	fcmps #0r2.50000000e+0,fp0
	fjne L249
	fmoved _vd,fp0
	fcmpd #0r2.5e+0,fp0
	fjne L250
L173:
	fmoved _vd,fp0
	fmuld #0r4.0e+0,fp0
	fcmpd #0r2.147483648e+9,fp0
	fjge L176
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
L177:
	moveq #10,d2
	cmpl d0,d2
	jeq L175
	pea 34:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L175:
	moveq #1,d0
	fmoved #0r1.75e+0,fp0
L179:
	fmuld #0r1.5e+0,fp0
	faddd #0r2.5e-1,fp0
	addql #1,d0
	moveq #10,d3
	cmpl d0,d3
	jne L179
	fcmpd #0r8.5900000000000005684342e+1,fp0
	fjngt L181
	fcmpd #0r8.6e+1,fp0
	fjlt L184
L181:
	pea 35:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L184:
	clrl sp@-
	lea _sw,a2
	jbsr a2@
	addql #4,sp
	moveq #11,d1
	cmpl d0,d1
	jeq L251
L185:
	pea 36:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L191:
	clrl d0
	clrl d1
L192:
	addl d0,d1
	addql #1,d0
	moveq #99,d2
	cmpl d0,d2
	jlt L252
L193:
	btst #0,d0
	jeq L192
	addql #1,d0
	moveq #99,d2
	cmpl d0,d2
	jge L193
L252:
	cmpl #2450,d1
	jeq L196
	pea 37:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L196:
	pea 10:w
	jbsr _fact
	addql #4,sp
	cmpl #3628800,d0
	jeq L198
	pea 38:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L198:
	pea 21:w
	pea _twice
	jbsr _apply
	addql #8,sp
	moveq #42,d3
	cmpl d0,d3
	jeq L200
	pea 39:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L200:
	pea 4:w
	pea 3:w
	pea 2:w
	pea 1:w
	pea 4:w
	jbsr _vsum
	addw #20,sp
	moveq #10,d1
	cmpl d0,d1
	jeq L202
	pea 40:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L202:
	clrl sp@-
	movel #1074266112,sp@-
	clrl sp@-
	movel #1074003968,sp@-
	clrl sp@-
	movel #1073217536,sp@-
	pea 3:w
	jbsr _dsum
	addw #28,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r7.0e+0,fp0
	fjne L253
L204:
	pea 9:w
	jbsr _mksmall
	addql #4,sp
	andl #-16711681,d0
	cmpl #150994962,d0
	jeq L206
	pea 42:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L206:
	pea 5:w
	lea a6@(-102),a2
	movel a2,a1
	lea _mkbig,a3
	jbsr a3@
	addql #4,sp
	moveq #5,d0
	cmpl a6@(-102),d0
	jeq L254
	pea 43:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L210:
	addw #-80,sp
	movel sp,d0
	pea 80:w
	movel a2,sp@-
	movel d0,sp@-
	jbsr _memcpy
	addw #12,sp
	jbsr _sumbig
	addw #80,sp
	cmpl #290,d0
	jeq L211
	pea 44:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L211:
	pea 7:w
	lea a6@(-22),a1
	jbsr _mkmixed
	addql #4,sp
	fmoved a6@(-22),fp0
	fcmpd #0r3.5e+0,fp0
	fjne L213
	moveq #7,d0
	cmpl a6@(-14),d0
	jeq L255
L213:
	pea 45:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L217:
	pea -4:w
	movel #705032704,sp@-
	pea 1:w
	movel #0x3f000000,sp@-
	pea 3:w
	clrl sp@-
	movel #1074003968,sp@-
	pea 1:w
	jbsr _mixarg
	addw #32,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r5.000000003e+9,fp0
	fjne L256
L218:
	pea 1:w
	lea a6@(-182),a1
	jbsr a3@
	addql #4,sp
	moveq #4,d0
	cmpl a6@(-170),d0
	jeq L220
	pea 47:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L220:
	pea 10:w
	jbsr _use_alloca
	addql #4,sp
	moveq #45,d1
	cmpl d0,d1
	jeq L222
	pea 48:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L222:
	moveq #5,d0
	bfins d0,d2{#0:#3}
	moveb #20,d0
	bfins d0,d2{#3:#5}
	moveb #100,d0
	bfins d0,d2{#8:#7}
	moveq #-7,d0
	bfins d0,d2{#15:#6}
	andw #63488,d2
	cmpl #-1261844480,d2
	jeq L224
	pea 49:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
L224:
	moveb #120,_buf+3
	tstb _buf+4
	jne L257
L226:
	moveb #104,a6@(-8)
	moveb #105,a6@(-7)
	clrb a6@(-6)
	pea 113:w
	movel #-266631570,sp@-
	movel #1074340345,sp@-
	movel #1234567,sp@-
	pea 42:w
	pea a6@(-8)
	pea LC1
	lea _printf,a3
	jbsr a4@
	addw #28,sp
	moveq #22,d2
	cmpl d0,d2
	jeq L228
	pea 51:w
	pea LC0
	jbsr a3@
	addql #1,_failures
	addql #8,sp
L228:
	lea _bump,a2
	jbsr a2@
	jbsr a2@
	moveq #2,d3
	cmpl _cnt,d3
	jeq L230
	pea 52:w
	pea LC0
	jbsr a3@
	addql #1,_failures
	addql #8,sp
	jra L230
L176:
	faddd #0r-2.147483648e+9,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d3,fpcr
	addl #-2147483648,d0
	jra L177
L254:
	moveq #24,d1
	cmpl a6@(-26),d1
	jeq L210
	pea 43:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L210
L247:
	fmoved _ve,fp0
	fmuld #0r1.6e+1,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d3,fpcr
	moveq #-2,d2
	cmpl d0,d2
	jeq L162
	pea 28:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L162
L241:
	movel _vi,d0
	moveq #8,d3
	orl d3,d0
	moveq #15,d1
	cmpl d0,d1
	jne L129
	movel _vi,d0
	moveb #7,d2
	cmpl d0,d2
	jne L129
	movel _vi,d0
	cmpl d0,d2
	jeq L133
	pea 15:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L133
L246:
	pea 27:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	fmoved _vd,fp0
	fmoveml fpcr,d3
	moveq #16,d1
	orl d3,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d3,fpcr
	moveq #2,d2
	cmpl d0,d2
	jne L160
	jra L247
L245:
	pea 26:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	fmoves _vf,fp0
	faddx fp0,fp0
	fcmps #0r3.00000000e+0,fp0
	fjeq L158
	jra L246
L253:
	pea 41:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L204
L250:
	pea 33:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L173
L249:
	pea 32:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	fmoved _vd,fp0
	fcmpd #0r2.5e+0,fp0
	fjeq L173
	jra L250
L248:
	pea 29:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L163
L244:
	pea 25:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	movel _vf,d0
	fmoved _vd,fp1
	fmoves d0,fp0
	faddx fp1,fp0
	fcmpd #0r4.0e+0,fp0
	fjeq L156
	jra L245
L243:
	pea 24:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	fmoved _vd,fp0
	fmoved _ve,fp1
	fdivx fp1,fp0
	fcmpd #0r-2.0e+1,fp0
	fjeq L154
	jra L244
L240:
	pea 10:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L119
L257:
	pea 50:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L226
L256:
	pea 46:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L218
L251:
	pea 3:w
	jbsr a2@
	addql #4,sp
	moveq #44,d2
	cmpl d0,d2
	jne L185
	pea 7:w
	jbsr a2@
	addql #4,sp
	moveq #88,d3
	cmpl d0,d3
	jne L185
	pea 8:w
	jbsr a2@
	addql #4,sp
	moveq #-1,d1
	cmpl d0,d1
	jne L185
	pea 100:w
	jbsr a2@
	addql #4,sp
	moveb #5,d2
	cmpl d0,d2
	jne L185
	pea -1:w
	jbsr a2@
	addql #4,sp
	moveq #-1,d3
	cmpl d0,d3
	jeq L191
	pea 36:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L191
L255:
	cmpb #122,a6@(-10)
	jeq L217
	pea 45:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L217
L242:
	movel _vl,d2
	movel _vl+4,d3
	movel _vm,d0
	movel _vm+4,d1
	subl d1,d3
	subxl d0,d2
	jne L149
	pea 22:w
	pea LC0
	jbsr a4@
	addql #1,_failures
	addql #8,sp
	jra L149
L230:
	movel _failures,sp@-
	pea LC2
	jbsr a3@
	movel _failures,d0
	moveml a6@(-212),#0x1c3c
	unlk a6
	rts
	.globl _vi
	.data
	.align	1
_vi:
	.long	7
	.globl _vj
	.align	1
_vj:
	.long	-3
	.globl _vu
	.align	1
_vu:
	.long	-16
	.globl _vl
	.align	1
_vl:
	.long	291
	.long	1164413355
	.globl _vm
	.align	1
_vm:
	.long	-1
	.long	-97
	.globl _vd
	.align	1
_vd:
	.long	1074003968
	.long	0
	.globl _ve
	.align	1
_ve:
	.long	-1077936128
	.long	0
	.globl _vf
	.align	1
_vf:
	.long	1069547520
	.globl _vs
	.align	1
_vs:
	.word	-300
	.globl _vc
_vc:
	.byte	-5
.lcomm _failures,4,1
.lcomm _cnt,4,1
	.comm _buf,16
