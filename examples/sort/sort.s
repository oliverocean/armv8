// sort.s

/* -----------[ Text ]----------- */
            .text
            .global main
main:
            // initialize 5 arbitrary values for an array
            mov x1, 5
            mov x2, 4
            mov x3, 3
            mov x4, 2
            mov x5, 1

            
            // save values to stack
	    sub sp, sp 80
	    str x5, [sp, 64] 
	    str x4, [sp, 48]
	    str x3, [sp, 32]
	    str x2, [sp, 16]
	    str x1, [sp, 0]

	    b swap
	    b 


swap:
            sub sp, sp 40      // make room on stack for 5 registers 
	    str x30, [sp, 32]  // save lr on stack
	    str x22, [sp, 24]  // save x22 on stack
	    str x21, [sp, 16]  // save x21 on stack
	    str x20, [sp, 8]   // save x20 on stack
	    str x19, [sp, 0]   // save x19 on stack

	    mov x21, x0
	    mov x22, x1
	    b outer_loop

	    str x19, [sp, 0]   // save x19 on stack
	    str x20, [sp, 8]   // save x20 on stack
	    str x21, [sp, 16]  // save x21 on stack
	    str x22, [sp, 24]  // save x22 on stack
	    str x30, [sp, 32]  // save lr on stack
            add sp, sp 40      // make room on stack for 5 registers 

return:
            ret


outer_loop:
	    mov x19, xzr
            cmp x19, x1
	    bge swap
	    add x19, x19, 1
	    b outer_loop

inner_loop:
	    sub x20, x19, 1
	    cmp x20, xzr
	    blt return
	    lsl x10, x20, 3
	    add x11, x0, x10
	    ldr x12, [x11, 0]
	    ldr x13, [x11, 8]
	    cmp x12, x13
	    ble return

	    mov x0, x21
	    mov x1, x20
	    bl swap

	    sub x20, x20, 1
	    b inner_loop
	    
swap:
            // x0 = address of v[]
	    // x1 = k

	    // save v[k] address into x10
	    lsl x10, x1, 3      // x10 = k * 8
	    add x10, x0, x10     // x10 = v + (k * 8)

            // swap steps
	    ldr x9, [x10, 0]   // temp x9  = v[k]
	    ldr x11, [x10, 8]  // temp x11 = v[k + 1]
	    str x11, [x10, 0]  // v[k] = v[k + 1] from temp x11
	    str x9, [x10, 8]   // v[k + 1] = v[k] from temp x9
	    
	    br lr

result:
	    adr x0, result_msg
	    bl printf

exit:
	    mov x8, #93	      // sys_exit from <unistd.h>, kernel/exit.c (Linux)
	    svc #0

/* -----------[ Data ]----------- */
            .data
result_msg: .asciz "> result: [ %d, %d, %d, %d, %d ]\n"


// EOF
