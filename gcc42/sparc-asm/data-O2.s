	.text
	.align	2
	.globl _use
_use:
	sethi	%hi(_common_int), %g1
	sethi	%hi(_local_zero+4), %g2
	ld	[%g1+%lo(_common_int)], %g3
	ld	[%g2+%lo(_local_zero+4)], %g1
	sethi	%hi(_local_byte), %g2
	add	%g3, %g1, %g3
	ldsb	[%g2+%lo(_local_byte)], %o0
	jmp	%o7+8
	 add	%g3, %o0, %o0
	.globl _buf
	.data
	.align	3
_buf:
	.byte	1
	.byte	2
	.byte	3
	.space 97
	.globl _shorts
	.align	1
_shorts:
	.half	1
	.half	-2
	.half	3
	.half	-4
	.globl _ints
	.align	2
_ints:
	.word	1
	.word	-2
	.word	3
	.word	-4
	.globl _quads
	.align	3
_quads:
	.word	287454020
	.word	1432778632
	.word	-1
	.word	-1
	.globl _flts
	.align	2
_flts:
	.word	1069547520
	.word	3222274048
	.globl _dbls
	.align	3
_dbls:
	.word	1074340345
	.word	4028335726
	.word	-726513235
	.word	630506365
	.globl _ld
	.align	3
_ld:
	.word	1074003968
	.word	0
	.globl _strs
.cstring
	.align	3
LC0:
	.ascii "alpha\0"
	.align	3
LC1:
	.ascii "beta\12\0"
	.align	3
LC2:
	.ascii "gamma\11\"quoted\"\0"
	.data
	.align	2
_strs:
	.word	LC0
	.word	LC1
	.word	LC2
	.globl _msg
.const
	.align	3
_msg:
	.ascii "hello, world\0"
	.globl _ptrs
	.data
	.align	2
_ptrs:
	.word	_common_int
	.word	_ints
	.word	_ints+8
	.globl _packed_val
_packed_val:
	.byte	1
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	0
	.byte	5
	.globl _packed_arr
_packed_arr:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	3
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	5
	.byte	0
	.byte	6
	.globl _bits
	.align	2
_bits:
	.byte	34
	.byte	0
	.byte	0
	.byte	3
	.globl _ext_ptr
	.align	2
_ext_ptr:
	.word	_ext_sym
.lcomm _local_zero,40,2
.lcomm _local_byte,1,0
	.comm _common_int,8
	.comm _common_dbl,24
	.comm _uninit_big,4000
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
