    .text
    .align 2
    .global main
main:
    stmfd sp!,{r0,r1,r2,r3,r4,r5,r6,fp,lr}
    mov r4, #0          @ r4 store the length of string
    ldr r6, [r1, #4]    @ r5 store the address of argv[1][0]
    mov r5,r6

count:                  @ check string's length
    ldrb r0, [r5], #1   @ r0 store char argv[1][r4]
    cmp r0, #0          @ compare r0,'\0'
    moveq r5,r6         @ restore r6 to r5
    subeq r4, r4, #1    @ update r4 to len(string)-1 (index)
    beq printstr        @ quit if r0=='\0'

    add r4, r4, #1      @ update string's length

    b count             @ if argv[1][r4]!='\0' , branch back to count

printstr:
    ldrb r0, [r5 ,r4]   @ r0 store argv[1][r4] (last char)

    cmp r0,#'A'         @ check if 'A'<=r0<='Z', if so, turn into lowercase
    blt printori        @ if not, print original char

    cmpge r0,#'Z'
    bgt printori

    suble r0, r0, #'A'
    addle r0, r0, #'a'
    
printori:
    bl putchar

    sub r4, r4, #1      @ update r4
    cmp r4, #-1         @ if r4==-1,printing complete
    bne printstr

exit:
    ldmfd sp!,{r0,r1,r2,r3,r4,r5,r6,fp,lr}
    bx lr
