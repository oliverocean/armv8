// add.s

	.text
	.global main

main:
	ldr x1, value1_addr
	ldr x2, value2_addr
	ldr w1, [x1]
	ldr w2, [x2]
	add w0, w1, w2

	mov x8, #93
	svc #0

	.data
value1: .word	0x01
value2: .word	0x10

value1_addr: 	.dword	value1
value2_addr: 	.dword	value2

// EOF
