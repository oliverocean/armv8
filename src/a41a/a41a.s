/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41a.s
 * @brief: port the C program 'a41a' (~/data/a41a.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
            // set stdout to terminal
	    mov x0, #0

            // load 64-bit memory address of variables
	    ldr x1, f_address
	    ldr x2, g_address
	    ldr x3, i_address
	    ldr x4, j_address

            // load 32-bit values from memory addresses
	    ldr w1, [x1]      // f
	    ldr w2, [x2]      // g
	    ldr w3, [x3]      // i
	    ldr w4, [x4]      // j

	    bl while_loop
	    b exit

while_loop:
            cmp w3, w4        // does i == j ?
	    beq print_results // branch if equal
	    add w1, w2, w4    // f = g + j
	    add x4, x4, #1    // j++
	    b while_loop      // branch to top of loop

print_results:
	    adr x0, msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
            .data

// small values may be set as 32-bit data type (W0, W1, W2...)
f_value:    .word    0x00    // f = 0
g_value:    .word    0x01    // g = 1
i_value:    .word    0x0A    // i = 10
j_value:    .word    0x05    // j = 5

// addresses need to be set as 64-bit data type (X0, X1, X2...) 
f_address:  .dword   f_value
g_address:  .dword   g_value
i_address:  .dword   i_value
j_address:  .dword   j_value

// format printf output
msg:        .asciz   "f=%d\n"

// EOF
