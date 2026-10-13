	.globl _buf
	.data
_buf:
	.byte	1
	.byte	2
	.byte	3
	.space 97
	.globl _shorts
	.align	1
_shorts:
	.word	1
	.word	-2
	.word	3
	.word	-4
	.globl _ints
	.align	1
_ints:
	.long	1
	.long	-2
	.long	3
	.long	-4
	.globl _quads
	.align	1
_quads:
	.long	287454020
	.long	1432778632
	.long	-1
	.long	-1
	.globl _flts
	.align	1
_flts:
	.long	1069547520
	.long	3222274048
	.globl _dbls
	.align	1
_dbls:
	.long	1074340345
	.long	4028335726
	.long	-726513235
	.long	630506365
	.globl _ld
	.align	1
_ld:
	.long	1073741824
	.long	2684354560
	.long	0
	.globl _strs
.cstring
LC0:
	.ascii "alpha\0"
LC1:
	.ascii "beta\12\0"
LC2:
	.ascii "gamma\11\"quoted\"\0"
	.data
	.align	1
_strs:
	.long	LC0
	.long	LC1
	.long	LC2
	.globl _msg
.const
_msg:
	.ascii "hello, world\0"
	.globl _ptrs
	.data
	.align	1
_ptrs:
	.long	_common_int
	.long	_ints
	.long	_ints+8
	.globl _packed_val
_packed_val:
	.byte	1
	.long	16909060
	.word	5
	.globl _packed_arr
_packed_arr:
	.byte	1
	.long	2
	.word	3
	.byte	4
	.long	5
	.word	6
	.globl _bits
	.align	1
_bits:
	.byte	34
	.byte	0
	.byte	0
	.byte	3
	.globl _ext_ptr
	.align	1
_ext_ptr:
	.long	_ext_sym
	.text
	.align	1
	.globl _use
_use:
	pea a6@
	movel sp,a6
	movel _local_zero+4,d1
	moveb _local_byte,d0
	extbl d0
	addl d0,d1
	movel _common_int,d0
	addl d1,d0
	unlk a6
	rts
.lcomm _local_zero,40,1
.lcomm _local_byte,1,0
	.comm _common_int,4
	.comm _common_dbl,24
	.comm _uninit_big,4000
