/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: l41.s
 * @brief: port the C program 'l41.c' (~/data/l41.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
            bl get_input
	    mov x0, #0
	    mov x1, xzr       // result
	    mov x2, #4        // a 
	    mov x3, #3        // b 
	    mov x4, x19       // c = get_input
	    bl get_max
	    b exit

get_input:
            adr x0, input_msg
	    bl printf
	    sub sp, sp, #16   // make room on stack (16-bytes is ARMv8 requirement)
	    mov x1, sp        // put the address into x1 for read (scanf)
	    adr x0, input_format // set x0 with address of input_format
	    bl scanf          // store user input on stack
	    ldr x1, [sp]      // load value from stack into x1 
	    mov x19, x1       // copy value into x19 to retain after function call
	    add sp, sp, #16   // reset stack pointer
	    adr x0, output_msg
	    bl printf

get_max:
            mov x1, x2        // result = a
	    cmp x3, x1        // eval :b > result
	    bgt b_greater     // branch if true
	    cmp x4, x1        // eval: c > result
	    bgt c_greater     // branch if true
	    b a_greater       // a is greater

a_greater:
	    b output_results

b_greater:
            cmp x4, x3       // eval: c > b 
	    bgt c_greater    // branch if true
	    mov x1, x3       // else result = b
	    b output_results

c_greater:
            mov x1, x4       // result = c
	    b output_results


output_results:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
              .data
input_msg:    .asciz "> Enter a number: "
input_format: .string "%d"
output_msg:   .asciz "> You entered: [ %d ]\n"
result_msg:   .asciz "> The maximum number is: [ %d ]\n"

// EOF
