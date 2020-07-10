/* *
 * @author: Oliver Ocean <github@oliverocean.co>
 * @file: l42.s
 * @brief: 
 *     Modify the assembly program 'l42_origin.s' to 'pass' the values from 
 *     main() to write() using the stack. The add operation in write()
 *     should use the values of x1, x2 as defined in the main subroutine.
 * @note:
 *     ARMv8 requires full 16-bytes per register; stp/ldp may be used for pairs.
 *     Otherwise use str/ldr and manually move the stack pointer (sp) by 
 *     16-byte increments if your data doesn't fit neatly into a pair.
 *        
 */

/* -----------[ Text ]----------- */
            .text
            .global main
main:
	    mov x1, 1
	    mov x2, 2

	    sub sp, sp, 32
	    str x1, [sp, 16]
	    str x2, [sp, 0]
	    // stp x1, x2, [sp, -16]! // alt: 'store pair' (push) onto stack (note "!")

	    bl write
	    bl exit

write:
	    ldr x1, [sp, 16]
	    ldr x2, [sp, 0]
	    add sp, sp, 32
            // ldp x1, x2, [sp], 16  // alt: 'load pair' (pop) from stack

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
