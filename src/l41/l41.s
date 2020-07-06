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
	    bl print_input

            // need to preserve lr on the stack for get_max and nested calls
	    // ok to save lr to register for get_input because no nested calls
	    bl get_max

	    bl print_max
	    	
	    b exit

get_input:
            mov x27, lr       // preserve link register (x30) when entering function
	    
	    mov x0, xzr       // initialize for printf
            adr x0, input_msg // put the address into x0 for printf
	    bl printf         // printf input_msg

	    //mov x1, xzr       // initialize result
	    sub sp, sp, 48    // make room on stack (ARMv8 stack alignment restriction is 16-bytes/register)
	    str xzr,[sp]      // clean up memory contents where input will be received
	    mov x1, sp        // set x1 with address for scanf to read
	    adr x0, input_format // set x0 with address of input_format
	    bl scanf          // store user input on stack
	    str x2, [sp, 0]
	    str x3, [sp, 16]
	    str x4, [sp, 32]
	    add sp, sp, 48    // reset stack pointer
	    //mov x19, x1       // copy value into x19 to retain after function call

	    adr x0, output_msg
	    bl printf

	    mov lr, x27       // restore link register (x30) before returning function
	    ret               // branch to link register (x30); equivalent to 'br lr'

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
input_msg:    .asciz "> Enter a number:\n"
input_format: .string "%d"
output_msg:   .asciz "> You entered: [ %d ]\n"
result_msg:   .asciz "> The maximum number is: [ %d ]\n"

/* -----------[ EOF ]----------- */
              .end
