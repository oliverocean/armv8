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
	    mov x2, 4            // a
	    mov x3, 3            // b
	    mov x4, x19          // c from get_input results (x19)
	    bl get_max
	    b exit

get_input:
            mov x27, lr          // preserve link register (x30) when entering function
	    
            adr x0, input_msg    // set x0 with address for printf to write
	    bl printf            // invoke printf (input_msg)

	    sub sp, sp, 16       // make room on stack (ARMv8 stack alignment restriction is 16-bytes/register)
	    str xzr,[sp]         // clean up memory contents where input will be received
	    adr x0, input_format // set x0 with address of input_format
	    mov x1, sp           // set x1 with address for scanf to read
	    bl scanf             // invoke scanf (scans input, puts into x1, which points to sp, thus put into stack)
	    ldr x1, [sp]         // load contents of sp into x1
	    add sp, sp, 16       // reset stack pointer
	    mov x19, x1          // copy x1 into x19 to preserve

	    adr x0, output_msg   // set x0 with address for printf to write
	    bl printf            // invoke printf (output_msg)

	    mov lr, x27          // restore link register (x30) before returning function
	    ret                  // branch to link register (x30); equivalent to 'br lr'

get_max:
            mov x1, x2           // result = a
	    cmp x3, x1           // eval :b > result
	    bgt b_greater        // branch if true
	    cmp x4, x1           // eval: c > result
	    bgt c_greater        // branch if true
	    b a_greater          // a is greater

a_greater:
	    b output_results

b_greater:
            cmp x4, x3           // eval: c > b 
	    bgt c_greater        // branch if true
	    mov x1, x3           // else result = b
	    b output_results

c_greater:
            mov x1, x4           // result = c
	    b output_results

output_results:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, 93	         // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc 0

/* -----------[ Data ]----------- */
              .data
input_msg:    .asciz "> Enter a number:  "
input_format: .string "%d"
output_msg:   .asciz "> The maximum of [ %d ], [ 4 ], [ 3 ] is:\n"
result_msg:   .asciz "> [ %d ]\n"

/* -----------[ EOF ]----------- */
              .end
