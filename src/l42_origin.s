// l42_origin.s

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
            
.data
msg: .asciz "%d + %d = %d\n"
