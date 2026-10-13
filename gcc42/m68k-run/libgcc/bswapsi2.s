	.text
	.align	1
	.globl ___bswapsi2
___bswapsi2:
	pea a6@
	movel sp,a6
	movel d3,sp@-
	movel d2,sp@-
	movel a6@(8),d2
	movel d2,d0
	andl #16711680,d0
	asrl #8,d0
	movel d2,d1
	moveq #24,d3
	lsrl d3,d1
	orl d1,d0
	movel d2,d1
	andl #65280,d1
	lsll #8,d1
	orl d1,d0
	lsll d3,d2
	orl d2,d0
	movel sp@+,d2
	movel sp@+,d3
	unlk a6
	rts
