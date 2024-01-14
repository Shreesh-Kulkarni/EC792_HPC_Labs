    .data
array:  .word 13, 34, 16, 61, 28
        .word 24, 58, 11, 26, 41
        .word 19, 7, 38, 12, 13
len: .word 15
hdr:    .ascii "\nprogram to find max and"
        .asciiz " min\n\n"
newLine: .asciiz "\n"
a1Msg: .asciiz "min = "
a2Msg: .asciiz "max = "
    .text
    .globl main
    .ent main
main:
# s0 - base address of array
# t1 - no of elements in the array
# s2 - min
# s3 - max
# t4 - each word from array
    la $a0, hdr
    li $v0, 4
    syscall # print header

    la $s0, array 
    lw $t1, len 
    lw $s2, ($s0) # min 
    lw $s3, ($s0) # max
loop:
    lw $t4, ($s0) 
    bge $t4, $s2, NotMin 
    move $s2, $t4 # set new min
NotMin:
    ble $t4, $s3, NotMax
    move $s3, $t4 # set new max
NotMax:
    sub $t1, $t1, 1 
    addu $s0, $s0, 4 # move to next address
    bnez $t1, loop

    la $a0, a1Msg
    li $v0, 4
    syscall 
    move $a0, $s2
    li $v0, 1
    syscall 
    la $a0, newLine 
    li $v0, 4
    syscall
    la $a0, a2Msg
    li $v0, 4
    syscall 
    move $a0, $s3
    li $v0, 1
    syscall 
    la $a0, newLine 
    li $v0, 4
    syscall
 
    li $v0, 10
    syscall 
.end main 