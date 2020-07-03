/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41b.s
 * @brief: port the C program 'a41b' (~/data/a41b.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
            // set stdout to terminal
	    mov x0, #0
	    mov x1, #0        // k = 0 (for_loop)
	    mov x2, array_max_length
	    adr x3, a_array
	    mov x4, #2        // m = 2

	    bl for_loop
	    b exit

for_loop:
            cmp x1, #5        // is k < 5 ?
	    bge output_results // branch if so (ge: greater than or equal to)

	    add x4, x4, x1    // m = m + k

	    // store address for a[k] in x5
	    lsl x5, x1, #8    // x5 = k * 8 (offset)
	    add x5, x3, x5    // x5 = a[] + offset
	
	    // set a[k] = 1
	    mov x5, #1

            // increment index and loop
	    add x1, x1, #1    // k++
	    b for_loop

output_results:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
            .data

a_array:    .dword   0x00, 0x00, 0x00,0x00, 0x00 // initialize with zeros
            .set     array_max_length, 5

// printf output format
result_msg: .asciz   "> results:\n [ %d ] (k)\n [ %d ] (max)\n [ %d ] (a_array)\n [ %d ] (m)\n"


// EOF
