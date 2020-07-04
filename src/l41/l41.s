/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: l41.s
 * @brief: port the C program 'l41.c' (~/data/l41.c) to ARMv8 assembly language
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
	    mov x0, #0

	    b exit

branch:


output_results:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
            .data


// EOF
