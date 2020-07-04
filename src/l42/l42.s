/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: l42.s
 * @brief: 
 *     Modify the assembly program 'l42_origin.s' (~/data/l42.s) to 'pass' the
 *     values from main() to write() using the stack. The add operation in write()
 *     should use the values of x1, x2 as defined in the main subroutine.
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
	    mov x1, 1
	    mov x2, 2
	    bl write
	    bl exit

write:
            mov x1, #10
            mov x2, #20
	    add x3, x1, x2
	    ldr x0, =msg
	    bl printf

exit:
	    mov x8, #93
	    svc 0

/* -----------[ Data ]----------- */
            .data
msg:        .asciz  "%d + %d = %d\n"


// EOF
