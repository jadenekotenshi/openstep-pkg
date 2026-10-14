	.text
	.align	1
"-[Base add:to:]":
	pea a6@
	movel sp,a6
	movel a6@(16),d1
	addl a6@(20),d1
	movel a6@(8),a0
	movel a0@(4),d0
	addl d1,d0
	unlk a6
	rts
	.align	1
"-[Base result:]":
	link a6,#-20
	movel a1,d1
	movel a6@(8),a0
	movel a0@(4),d0
	movel d0,a6@(-20)
	movel a6@(16),a6@(-16)
	movel a6@(8),a0
	movel a0@(4),d0
	addl a6@(16),d0
	movel d0,a6@(-12)
	movel #1074397184,a6@(-8)
	clrl a6@(-4)
	lea a6@(-20),a1
	movel d1,a0
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	movel d1,d0
	unlk a6
	rts
	.align	1
"-[Base dbl]":
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	fmoved a0@(8),fp0
	fmuld #0r3.25e+0,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
"-[Base scaled:]":
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	fmoved a0@(8),fp0
	fmuld a6@(16),fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	unlk a6
	rts
	.align	1
"-[Base setBias:]":
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a6@(16),a0@(4)
	movel a6@(8),a0
	movel #1073741824,a0@(8)
	clrl a0@(12)
	unlk a6
	rts
	.align	1
"-[Base bias]":
	pea a6@
	movel sp,a6
	movel a6@(8),a0
	movel a0@(4),d0
	unlk a6
	rts
	.align	1
"-[Base tiny]":
	link a6,#-4
	moveb #113,a6@(-2)
	movew a6@(-2),d0
	unlk a6
	rts
	.align	1
"-[Base big:]":
	pea a6@
	movel sp,a6
	moveml #0x3800,sp@-
	movel a6@(16),a0
	movel a6@(20),a1
	movel a0,d0
	movel a1,d1
	movel d0,d2
	movel d1,d3
	addl d3,d3
	addxl d2,d2
	addl d3,d3
	addxl d2,d2
	movel d3,d4
	moveq #27,d0
	lsrl d0,d4
	movel d2,d0
	lsll #5,d0
	orl d4,d0
	movel d3,d1
	lsll #5,d1
	subl d3,d1
	subxl d2,d0
	movel a0,d2
	addl a1,d1
	addxl d2,d0
	addl d1,d1
	addxl d0,d0
	addl d1,d1
	addxl d0,d0
	addl d1,d1
	addxl d0,d0
	moveml sp@+,#0x1c
	unlk a6
	rts
	.align	1
"+[Base tag]":
	pea a6@
	movel sp,a6
	moveq #11,d0
	unlk a6
	rts
	.align	1
"-[Kid result:]":
	link a6,#-28
	movel d2,sp@-
	movel a1,d2
	movel a6@(8),d0
	movel d0,a6@(-28)
	movel L_OBJC_CLASS_Kid+4,d0
	movel d0,a6@(-24)
	lea a6@(-28),a0
	movel L_OBJC_SELECTOR_REFERENCES_0,d0
	movel a6@(16),sp@-
	movel d0,sp@-
	movel a0,sp@-
	lea a6@(-20),a0
	movel a0,a1
	jbsr _objc_msgSendSuper_stret
	addw #12,sp
	movel a6@(-12),a0
	addw #100,a0
	movel a0,a6@(-12)
	lea a6@(-20),a1
	movel d2,a0
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	movel d2,d0
	movel a6@(-32),d2
	unlk a6
	rts
	.align	1
"-[Kid add:to:]":
	link a6,#-8
	movel a6@(8),d0
	movel d0,a6@(-8)
	movel L_OBJC_CLASS_Kid+4,d0
	movel d0,a6@(-4)
	movel a6,d1
	subql #8,d1
	movel L_OBJC_SELECTOR_REFERENCES_1,d0
	movel a6@(20),sp@-
	movel a6@(16),sp@-
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSendSuper
	addw #16,sp
	addl d0,d0
	unlk a6
	rts
	.align	1
"-[Kid viaSuper]":
	link a6,#-8
	movel a6@(8),d0
	movel d0,a6@(-8)
	movel L_OBJC_CLASS_Kid+4,d0
	movel d0,a6@(-4)
	movel a6,d1
	subql #8,d1
	movel L_OBJC_SELECTOR_REFERENCES_2,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSendSuper
	addql #8,sp
	addl #1000,d0
	unlk a6
	rts
	.align	1
"+[Kid tag]":
	link a6,#-8
	movel a6@(8),a6@(-8)
	movel L_OBJC_METACLASS_Kid+4,d0
	movel d0,a6@(-4)
	movel a6,d1
	subql #8,d1
	movel L_OBJC_SELECTOR_REFERENCES_3,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSendSuper
	addql #8,sp
	addql #1,d0
	unlk a6
	rts
.cstring
LC0:
	.ascii "FAIL %d\12\0"
LC1:
	.ascii "objctest: %d failures\12\0"
	.text
	.align	1
	.globl _main
_main:
	link a6,#-56
	movel d3,sp@-
	movel d2,sp@-
	movel L_OBJC_CLASS_REFERENCES_0,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_4,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel d0,a6@(-12)
	movel L_OBJC_CLASS_REFERENCES_1,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_4,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel d0,a6@(-8)
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_5,d0
	pea 5:w
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #12,sp
	movel a6@(-8),d1
	movel L_OBJC_SELECTOR_REFERENCES_5,d0
	pea 7:w
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #12,sp
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_2,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	moveq #5,d1
	cmpl d0,d1
	jne L28
	movel a6@(-8),d0
	movel L_OBJC_SELECTOR_REFERENCES_2,d1
	movel d1,sp@-
	movel d0,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	moveq #7,d1
	cmpl d0,d1
	jeq L30
L28:
	pea 1:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L30:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_1,d0
	pea 4:w
	pea 3:w
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #16,sp
	moveq #12,d1
	cmpl d0,d1
	jeq L31
	pea 2:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L31:
	movel a6@(-8),d1
	movel L_OBJC_SELECTOR_REFERENCES_1,d0
	pea 4:w
	pea 3:w
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #16,sp
	moveq #28,d1
	cmpl d0,d1
	jeq L33
	pea 3:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L33:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_0,d0
	pea 11:w
	movel d0,sp@-
	movel d1,sp@-
	lea a6@(-32),a0
	movel a0,a1
	jbsr _objc_msgSend_stret
	addw #12,sp
	movel a6@(-32),d0
	moveq #5,d1
	cmpl d0,d1
	jne L35
	movel a6@(-28),d0
	moveq #11,d1
	cmpl d0,d1
	jne L35
	movel a6@(-24),d0
	moveq #16,d1
	cmpl d0,d1
	jne L35
	fmoved a6@(-20),fp0
	fcmpd #0r3.25e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L39
L35:
	pea 4:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L39:
	movel a6@(-8),d1
	movel L_OBJC_SELECTOR_REFERENCES_0,d0
	pea 11:w
	movel d0,sp@-
	movel d1,sp@-
	lea a6@(-56),a0
	movel a0,a1
	jbsr _objc_msgSend_stret
	addw #12,sp
	lea a6@(-56),a1
	lea a6@(-32),a0
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	addql #4,a0
	addql #4,a1
	movel a1@,a0@
	movel a6@(-32),d0
	moveq #7,d1
	cmpl d0,d1
	jne L40
	movel a6@(-28),d0
	moveq #11,d1
	cmpl d0,d1
	jne L40
	movel a6@(-24),d0
	moveq #118,d1
	cmpl d0,d1
	jne L40
	fmoved a6@(-20),fp0
	fcmpd #0r3.25e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L44
L40:
	pea 5:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L44:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_6,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r6.5e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jne L45
	movel a6@(-8),d1
	movel L_OBJC_SELECTOR_REFERENCES_6,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r6.5e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L47
L45:
	pea 6:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L47:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_7,d0
	clrl sp@-
	movel #1072955392,sp@-
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #16,sp
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fcmpd #0r2.5e+0,fp0
	fseq d0
	negb d0
	eorb #1,d0
	tstb d0
	jeq L48
	pea 7:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L48:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_8,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movew d0,a6@(-34)
	moveb a6@(-34),d0
	cmpb #113,d0
	jeq L50
	pea 8:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L50:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_9,d0
	movel #5000000,sp@-
	clrl sp@-
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addw #16,sp
	moveq #1,d2
	movel #705032704,d3
	subl d1,d3
	subxl d0,d2
	jeq L52
	pea 9:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L52:
	movel L_OBJC_CLASS_REFERENCES_0,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_3,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	moveq #11,d1
	cmpl d0,d1
	jne L54
	movel L_OBJC_CLASS_REFERENCES_1,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_3,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	moveq #12,d1
	cmpl d0,d1
	jeq L56
L54:
	pea 10:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L56:
	movel a6@(-8),d0
	movel L_OBJC_SELECTOR_REFERENCES_10,d1
	movel d1,sp@-
	movel d0,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	cmpl #1007,d0
	jeq L57
	pea 11:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L57:
	movel a6@(-8),d2
	movel L_OBJC_CLASS_REFERENCES_0,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_11,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel L_OBJC_SELECTOR_REFERENCES_12,d1
	movel d0,sp@-
	movel d1,sp@-
	movel d2,sp@-
	jbsr _objc_msgSend
	addw #12,sp
	tstl d0
	jeq L59
	movel a6@(-12),d2
	movel L_OBJC_CLASS_REFERENCES_1,d0
	movel d0,d1
	movel L_OBJC_SELECTOR_REFERENCES_11,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel L_OBJC_SELECTOR_REFERENCES_12,d1
	movel d0,sp@-
	movel d1,sp@-
	movel d2,sp@-
	jbsr _objc_msgSend
	addw #12,sp
	tstl d0
	jeq L61
L59:
	pea 12:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L61:
	movel L_OBJC_SELECTOR_REFERENCES_1,a6@(-4)
	movel L_OBJC_SELECTOR_REFERENCES_1,d0
	cmpl a6@(-4),d0
	jeq L62
	pea 13:w
	pea LC0
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	addql #1,d0
	movel d0,_failures
L62:
	movel a6@(-12),d1
	movel L_OBJC_SELECTOR_REFERENCES_13,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel a6@(-8),d1
	movel L_OBJC_SELECTOR_REFERENCES_13,d0
	movel d0,sp@-
	movel d1,sp@-
	jbsr _objc_msgSend
	addql #8,sp
	movel _failures,d0
	movel d0,sp@-
	pea LC1
	jbsr _printf
	addql #8,sp
	movel _failures,d0
	movel a6@(-64),d2
	movel a6@(-60),d3
	unlk a6
	rts
.objc_class
.objc_meta_class
.objc_cat_cls_meth
.objc_cat_inst_meth
.objc_cls_meth
.objc_inst_meth
.objc_message_refs
.objc_symbols
.objc_category
.objc_protocol
.objc_class_vars
.objc_instance_vars
.objc_module_info
.objc_string_object
.objc_class_names
.objc_meth_var_names
.objc_meth_var_types
.objc_cls_refs
.objc_symbols
	.align	1
L_OBJC_SYMBOLS:
	.long	0
	.long	0
	.word	2
	.word	0
	.long	L_OBJC_CLASS_Kid
	.long	L_OBJC_CLASS_Base
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_0:
	.ascii "extra\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_0:
	.ascii "i\0"
.objc_instance_vars
	.align	1
L_OBJC_INSTANCE_VARIABLES_Kid:
	.long	1
	.long	L_OBJC_METH_VAR_NAME_0
	.long	L_OBJC_METH_VAR_TYPE_0
	.long	16
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_1:
	.ascii "tag\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_1:
	.ascii "i8@0:4\0"
.objc_cls_meth
	.align	1
L_OBJC_CLASS_METHODS_Kid:
	.long	0
	.long	1
	.long	L_OBJC_METH_VAR_NAME_1
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	"+[Kid tag]"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_2:
	.ascii "viaSuper\0"
L_OBJC_METH_VAR_NAME_3:
	.ascii "add:to:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_2:
	.ascii "i16@0:4i8i12\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_4:
	.ascii "result:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_3:
	.ascii "{?=iiid}12@0:4i8\0"
.objc_inst_meth
	.align	1
L_OBJC_INSTANCE_METHODS_Kid:
	.long	0
	.long	3
	.long	L_OBJC_METH_VAR_NAME_2
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	"-[Kid viaSuper]"
	.long	L_OBJC_METH_VAR_NAME_3
	.long	L_OBJC_METH_VAR_TYPE_2
	.long	"-[Kid add:to:]"
	.long	L_OBJC_METH_VAR_NAME_4
	.long	L_OBJC_METH_VAR_TYPE_3
	.long	"-[Kid result:]"
.objc_class_names
L_OBJC_CLASS_NAME_0:
	.ascii "Kid\0"
L_OBJC_CLASS_NAME_1:
	.ascii "Base\0"
L_OBJC_CLASS_NAME_2:
	.ascii "Object\0"
.objc_meta_class
	.align	1
L_OBJC_METACLASS_Kid:
	.long	L_OBJC_CLASS_NAME_2
	.long	L_OBJC_CLASS_NAME_1
	.long	L_OBJC_CLASS_NAME_0
	.long	0
	.long	2
	.long	48
	.long	0
	.long	L_OBJC_CLASS_METHODS_Kid
	.long	0
	.long	0
	.long	0
	.long	0
.objc_class
	.align	1
L_OBJC_CLASS_Kid:
	.long	L_OBJC_METACLASS_Kid
	.long	L_OBJC_CLASS_NAME_1
	.long	L_OBJC_CLASS_NAME_0
	.long	0
	.long	1
	.long	20
	.long	L_OBJC_INSTANCE_VARIABLES_Kid
	.long	L_OBJC_INSTANCE_METHODS_Kid
	.long	0
	.long	0
	.long	0
	.long	0
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_5:
	.ascii "bias\0"
L_OBJC_METH_VAR_NAME_6:
	.ascii "scale\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_4:
	.ascii "d\0"
.objc_instance_vars
	.align	1
L_OBJC_INSTANCE_VARIABLES_Base:
	.long	2
	.long	L_OBJC_METH_VAR_NAME_5
	.long	L_OBJC_METH_VAR_TYPE_0
	.long	4
	.long	L_OBJC_METH_VAR_NAME_6
	.long	L_OBJC_METH_VAR_TYPE_4
	.long	8
.objc_cls_meth
	.align	1
L_OBJC_CLASS_METHODS_Base:
	.long	0
	.long	1
	.long	L_OBJC_METH_VAR_NAME_1
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	"+[Base tag]"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_7:
	.ascii "big:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_5:
	.ascii "q16@0:4q8\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_8:
	.ascii "tiny\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_6:
	.ascii "{?=c}8@0:4\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_9:
	.ascii "setBias:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_7:
	.ascii "v12@0:4i8\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_10:
	.ascii "scaled:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_8:
	.ascii "d16@0:4d8\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_11:
	.ascii "dbl\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_9:
	.ascii "d8@0:4\0"
.objc_inst_meth
	.align	1
L_OBJC_INSTANCE_METHODS_Base:
	.long	0
	.long	8
	.long	L_OBJC_METH_VAR_NAME_7
	.long	L_OBJC_METH_VAR_TYPE_5
	.long	"-[Base big:]"
	.long	L_OBJC_METH_VAR_NAME_8
	.long	L_OBJC_METH_VAR_TYPE_6
	.long	"-[Base tiny]"
	.long	L_OBJC_METH_VAR_NAME_5
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	"-[Base bias]"
	.long	L_OBJC_METH_VAR_NAME_9
	.long	L_OBJC_METH_VAR_TYPE_7
	.long	"-[Base setBias:]"
	.long	L_OBJC_METH_VAR_NAME_10
	.long	L_OBJC_METH_VAR_TYPE_8
	.long	"-[Base scaled:]"
	.long	L_OBJC_METH_VAR_NAME_11
	.long	L_OBJC_METH_VAR_TYPE_9
	.long	"-[Base dbl]"
	.long	L_OBJC_METH_VAR_NAME_4
	.long	L_OBJC_METH_VAR_TYPE_3
	.long	"-[Base result:]"
	.long	L_OBJC_METH_VAR_NAME_3
	.long	L_OBJC_METH_VAR_TYPE_2
	.long	"-[Base add:to:]"
.objc_meta_class
	.align	1
L_OBJC_METACLASS_Base:
	.long	L_OBJC_CLASS_NAME_2
	.long	L_OBJC_CLASS_NAME_2
	.long	L_OBJC_CLASS_NAME_1
	.long	0
	.long	2
	.long	48
	.long	0
	.long	L_OBJC_CLASS_METHODS_Base
	.long	0
	.long	0
	.long	0
	.long	0
.objc_class
	.align	1
L_OBJC_CLASS_Base:
	.long	L_OBJC_METACLASS_Base
	.long	L_OBJC_CLASS_NAME_2
	.long	L_OBJC_CLASS_NAME_1
	.long	0
	.long	1
	.long	16
	.long	L_OBJC_INSTANCE_VARIABLES_Base
	.long	L_OBJC_INSTANCE_METHODS_Base
	.long	0
	.long	0
	.long	0
	.long	0
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_12:
	.ascii "free\0"
.objc_message_refs
	.align	1
L_OBJC_SELECTOR_REFERENCES_13:
	.long	L_OBJC_METH_VAR_NAME_12
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_13:
	.ascii "isKindOf:\0"
.objc_message_refs
	.align	1
L_OBJC_SELECTOR_REFERENCES_12:
	.long	L_OBJC_METH_VAR_NAME_13
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_14:
	.ascii "class\0"
.objc_message_refs
	.align	1
L_OBJC_SELECTOR_REFERENCES_11:
	.long	L_OBJC_METH_VAR_NAME_14
	.align	1
L_OBJC_SELECTOR_REFERENCES_10:
	.long	L_OBJC_METH_VAR_NAME_2
	.align	1
L_OBJC_SELECTOR_REFERENCES_9:
	.long	L_OBJC_METH_VAR_NAME_7
	.align	1
L_OBJC_SELECTOR_REFERENCES_8:
	.long	L_OBJC_METH_VAR_NAME_8
	.align	1
L_OBJC_SELECTOR_REFERENCES_7:
	.long	L_OBJC_METH_VAR_NAME_10
	.align	1
L_OBJC_SELECTOR_REFERENCES_6:
	.long	L_OBJC_METH_VAR_NAME_11
	.align	1
L_OBJC_SELECTOR_REFERENCES_5:
	.long	L_OBJC_METH_VAR_NAME_9
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_15:
	.ascii "new\0"
.objc_message_refs
	.align	1
L_OBJC_SELECTOR_REFERENCES_4:
	.long	L_OBJC_METH_VAR_NAME_15
	.align	1
L_OBJC_SELECTOR_REFERENCES_3:
	.long	L_OBJC_METH_VAR_NAME_1
	.align	1
L_OBJC_SELECTOR_REFERENCES_2:
	.long	L_OBJC_METH_VAR_NAME_5
	.align	1
L_OBJC_SELECTOR_REFERENCES_1:
	.long	L_OBJC_METH_VAR_NAME_3
	.align	1
L_OBJC_SELECTOR_REFERENCES_0:
	.long	L_OBJC_METH_VAR_NAME_4
.const
	.align	1
L_OBJC_IMAGE_INFO:
	.space 8
.objc_class_names
L_OBJC_CLASS_NAME_3:
	.ascii "\0"
.objc_module_info
	.align	1
L_OBJC_MODULES:
	.long	7
	.long	16
	.long	L_OBJC_CLASS_NAME_3
	.long	L_OBJC_SYMBOLS
	.data
	.align	1
_.objc_class_ref_Base:
	.long	.objc_class_name_Base
.objc_cls_refs
	.align	1
L_OBJC_CLASS_REFERENCES_0:
	.long	L_OBJC_CLASS_NAME_1
	.data
	.align	1
_.objc_class_ref_Kid:
	.long	.objc_class_name_Kid
.objc_cls_refs
	.align	1
L_OBJC_CLASS_REFERENCES_1:
	.long	L_OBJC_CLASS_NAME_0
	.data
	.align	1
_.objc_class_ref_Object:
	.long	.objc_class_name_Object
	.globl .objc_class_name_Kid
.const
	.align	1
.objc_class_name_Kid:
	.space 4
	.globl .objc_class_name_Base
	.align	1
.objc_class_name_Base:
	.space 4
.lcomm _failures,4,1
