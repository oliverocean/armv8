/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a41b.s
 * @brief: port the C program 'a41b' (~/data/a41b.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
            bl get_input
	    adr x1, array             // array base
	    mov x2, xzr               // index k = 0
	    mov x3, max               // array length = 5 as in a41b.c
	    mov x4, xzr               // a[k] = 0
	    mov x5, x19               // value to populate into array (from get_input)
	    mov x6, 2                 // m = 2 (initialized as in a41b.c)
	    bl for_loop

get_input:
	    mov x27, lr               // preserve link register (x30)

	    adr x0, input_msg         // ask user for input
	    bl printf

	    sub sp, sp, 16            // make room on stack
	    str xzr, [sp]             // clear memory
	    adr x0, input_format      // set format for scanf
	    mov x1, sp                // set address for scanf to write to (sp)
	    bl scanf                  // invoke scanf
	    ldr x1, [sp]              // load contents of memory (sp) into x1
	    add sp, sp, 16            // reset stack pointer
	    mov x19, x1               // copy data to x19 to retain after ret

	    mov lr, x27               // restore link register
	    ret

for_loop:
	    cmp x2, x3                // eval: k < max
	    bge output_results

	    add x6, x6, x2            // m = m + k

	    add x4, x1, x2, lsl 3     // x4 = x1 + (x2 * 8) : base + (index * offset)
	    str x5, [x4]              // put x5 into the array index (constant: 1)

	    add x2, x2, 1             // increment index : k++
	    b for_loop

output_results:
            // make room on stack for 5 items from the array (5 * 16 = 80bytes)
	    sub sp, sp, 80
	    
	    // copy each array value onto stack
	    ldr x7, [x1, 0] 
	    str x7, [sp, 0]

	    ldr x7, [x1, 8] 
	    str x7, [sp, 16]

	    ldr x7, [x1, 16] 
	    str x7, [sp, 32]

	    ldr x7, [x1, 24] 
	    str x7, [sp, 48]

	    ldr x7, [x1, 32] 
	    str x7, [sp, 64]

	    // zero out x1 to x5
	    //mov x1, 11
	    //mov x2, 12
	    //mov x3, 13
	    //mov x4, 14
	    //mov x5, 15

	    // copy values from stack into x1 to x5
            ldr x1, [sp, 0]
	    ldr x2, [sp, 16]
	    ldr x3, [sp, 32]
	    ldr x4, [sp, 48]
	    ldr x5, [sp, 64]

	    // reset stack pointer
	    add sp, sp, 80

	    adr x0, result_msg
	    bl printf
	    b exit

exit:
	    mov x8, 93	              // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc 0

/* -----------[ Data ]----------- */
               .data
input_msg:     .asciz  "\n---[ Input ]---\n\n> Enter a number to populate the array:\n"
input_format:  .string  "%d"

array:         .dword   0, 0, 0, 0, 0 // initialize to 0 for debugging
               .set     max, 5
result_msg:    .asciz   "\n---[ Output ]---\n\n  a[5]: [ %d, %d, %d, %d, %d ]\n int m: [ %d ]\n\n"

/* -----------[ EOF ]----------- */
               .end
