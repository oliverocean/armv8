/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41b.s
 * @brief: port the C program 'a41b' (~/data/a41b.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
	    mov x0, 0
	    mov x1, 0         // k = 0 (for_loop)
	    mov x2, max
	    adr x3, array     // &array
	    mov x4, #2        // m = 2
	    bl for_loop
	    b exit

for_loop:
            cmp x1, x2        // eval: k < max
	    bge output_results

	    add x4, x4, x1    // m = m + k

	    //lsl x5, x1, #8    // x5 = k * 8 (offset)
	    //add x5, x3, x5    // x5 = a[k] (a[] + offset)
	    //mov x5, #1        // set a[k] = 1

	    add x5, x3, x1, lsl 3
	    str x3, [x5]
	    add x3, x3, #1

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
array:      .dword   0, 0, 0, 0, 0 // initialize with zeros for debugging
            .set     max, 5
result_msg: .asciz   "> result: [ %d ]\n"
//result_msg: .asciz   "> results:\n [ %d ] (k)\n [ %d ] (max)\n [ %d ] (a_array)\n [ %d ] (m)\n"


// EOF
