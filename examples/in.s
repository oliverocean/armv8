// @example: in.s
            .text
            .global main
main:
            adr x0, input_msg
	    bl printf

	    sub sp, sp, #16
	    mov x1, sp
	    adr x0, input_format
	    bl scanf
	    ldr x1, [sp]
	    add sp, sp, #16

	    adr x0, output_msg
	    bl printf

	    mov x8, #93	
	    svc #0

/* -----------[ Data ]----------- */
              .data
input_msg:    .asciz "> Enter a number:\n"
input_format: .string "%d"
output_msg:   .asciz "You Entered: [ %d ]\n"
result_msg:   .asciz "> The maximum number is: [ %d ]\n"

// EOF
