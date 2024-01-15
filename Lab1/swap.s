    .data
array1:  .word 13, 34, 16, 61
array2:  .word 8, 7, 2, 6, 0
len:     .word 5
    .text
    .globl main
    .ent main
main:
# s0 - base address of array1
# t0 - base address of array2
# t1 - no of elements in the array
# s2 - each word from array1
# s3 - each word from array2
# t4 - temp

    la $s0, array1
    la $t0, array2 
    lw $t1, len  
loop:
    blt $t1,1,exit
    lw $s2, ($s0)
    lw $s3,($t0)
    add $t4,$s2,$zero
    add $s2,$s3,$zero
    add $s3,$t4,$zero
    sw $s2,($s0)
    sw $s3,($t0) 
    addi $s0,$s0,4
    addi $t0,$t0,4
    sub $t1,$t1,1
    j loop
exit:
    li $v0, 10
    syscall 
.end main 