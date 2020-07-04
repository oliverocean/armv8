/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: a42.s
 * @brief: port the C program 'a42.c' (~/data/a42.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
	    mov x0, #0
	    mov x1, #31   // c in main(), a in f3()
	    mov x2, #128  // p in main(), b in f3()
	    bl f3_func
	    b exit

f3_func:
	    lsr x3, x1, #2 // c = a >> 2 (=7)
	    add x2, x1, x2 // *b = a + *b
	    b if_sub

if_sub:
	    // eval: a < 2 
	    cmp x1, #2
	    blt output_results

	    // eval: c < 0
	    cmp x3, xzr
	    blt output_results

	    // c = c | a
	    orr x3, x3, x1
	    b output_results


output_results:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
            .data
result_msg: .asciz "> f3(c, &p): [ %d ]\n"


// EOF
