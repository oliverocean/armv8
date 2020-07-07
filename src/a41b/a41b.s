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
	    adr x1, array         // array base
	    mov x2, 0             // index k = 0
	    mov x3, max           // array length
	    mov x4, xzr           // a[k] = 0
	    mov x5, 1             // value to populate into array
	    mov x6, 2             // m = 2

	    bl for_loop

for_loop:
	    cmp x2, x3            // eval: k < max
	    bge output_results

	    add x6, x6, x2        // m = m + k

	    add x4, x1, x2, lsl 3  // x4 = x1 + (x2 * 8) : base + (index * offset)
	    str x5, [x4]

	    add x2, x2, 1         // increment index : k++
	    b for_loop

output_results:
            // make room on stack for 5 items (5 * 16 = 80bytes)
	    sub sp, sp, 80
	    
	    // copy values onto stack
	    ldr x7, [x1, 48] 
	    str x7, [sp, 64]

	    ldr x7, [x1, 40] 
	    str x7, [sp, 48]

	    ldr x7, [x1, 32] 
	    str x7, [sp, 48]

	    ldr x7, [x1, 24] 
	    str x7, [sp, 32]

	    ldr x7, [x1, 16] 
	    str x7, [sp, 16]

	    ldr x7, [x1, 8] 
	    str x7, [sp, 0]

	    // zero out x1 to x5
	    mov x1, xzr
	    mov x2, xzr
	    mov x3, xzr
	    mov x4, xzr
	    mov x5, xzr

	    // copy values from stack into x1 to x5
	    ldr x5, [sp, 64]
	    ldr x4, [sp, 48]
	    ldr x3, [sp, 32]
	    ldr x2, [sp, 16]
            ldr x1, [sp, 0]

	    // reset stack pointer
	    add sp, sp, 80

	    adr x0, result_msg
	    bl printf
	    b exit

exit:
	    mov x8, 93	          // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc 0

/* -----------[ Data ]----------- */
            .data
array:      .dword   0x0e, 0x0e, 0x0e, 0x0e, 0x0e // initialize with 0x0e for debugging
            .set     max, 5
//result_msg: .asciz   "> result: [ %d ]\n"
result_msg: .asciz   "> array a[5]: [ %d, %d, %d, %d, %d ]\n> int m: [ %d ]\n"


// EOF
