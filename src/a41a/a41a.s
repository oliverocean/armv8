/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41a.s
 * @brief: port the C program 'a41a' (~/data/a41a.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
// reserved for executable instructions
            .text
            .global main
main:
            // set stdout to terminal
	    mov x0, #0

            // load memory address of variables
	    ldr x1, f_address
	    ldr x2, g_address
	    ldr x3, i_address
	    ldr x4, j_address

            // load values from memory addresses
	    ldr w1, [x1]      // f
	    ldr w2, [x2]      // g
	    ldr w3, [x3]      // i
	    ldr w4, [x4]      // j

while_loop:
            cmp w3, w4        // does i == j ?
	    beq print_result  // branch if equal
	    add w1, w2, w4    // f = g + j
	    add x4, x4, #1    // j++
	    b while_loop      // branch to top of loop

print_result:
	    mov x8, #64       // sys_write from <uninstd.h>, fs/read_write.c (Linux)
	    svc #0

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
// reserved for initialized and uninitialized (read/write) data
            .data

// small values may be set as 
// .word data type (32bits, ie: W0, W1, W2...)
f_value:    .word    0x00    // i = 0
g_value:    .word    0x01    // i = 1
i_value:    .word    0x0A    // i = 10
j_value:    .word    0x05    // i = 5

// addresses need to be set as 
// .dword data type (64-bits, ie: X0, X1, X2...) 
f_address:  .dword   f_value
g_address:  .dword   g_value
i_address:  .dword   i_value
j_address:  .dword   j_value

// EOF
