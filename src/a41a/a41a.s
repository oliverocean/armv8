/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41a.s
 * @brief: port the C program 'a41a' (~/data/a41a.c) to assembly language
 */

/* -----------[ Text ]----------- */
// reserved for executable instructions
            .text
            .global main
main:
            // load memory address of variables
	    ldr x0, f_address
	    ldr x1, g_address
	    ldr x2, i_address
	    ldr x3, j_address

            // load values from memory addresses
	    ldr w0, [x0]
	    ldr w1, [x1]
	    ldr w2, [x2]
	    ldr w3, [x3]

while_loop:
	    // while j != i   // test equality of j and i, if equal, exit loop
	    // f = g + j      // add g and j, store in f
	    // j++            // add j and 1, store in j
	    // end of loop    // reevaluate, top of loop 

print_result:
	    ??? x8, #??		// print syscall
	    svc #0

exit:
	    mov x8, #93		// sys_exit
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
