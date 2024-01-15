    .data
array:  .word 292, 34, 16, 61
len:     .word 4
blue:   .asciiz "Blue:"
green:   .asciiz "Green:"
red:     .asciiz "Red:"
gray:    .asciiz "Gray:"
    .text
    .globl main
    .ent main
main:
# s0 - base address of array1
# t0 - base address of array2
# s2 - each word from array1
# s3 - each word from array2
# t1 - blue and final gray value
# t2 - green
# t3 - red
# t4 - all zeroes
# t8- temp=3

    la $s0, array 
    lw $s1, len 
rgb2gray:
    blt $s1,1,exit
    # lw $s2, ($s0)
    # lw $s3,($t0)
    lb $t1,0($s0)
    la $a0,blue
    li $v0,4
    syscall
    addi $a0,$t1,0
    li $v0,4
    syscall
    lb $t2,1($s0)
    la $a0,green
    li $v0,4
    syscall
    addi $a0,$t2,0
    li $v0,4
    syscall
    lb $t3,2($s0)
    la $a0,red
    li $v0,4
    syscall
    addi $a0,$t3,0
    li $v0,4
    syscall
    lb $t4,3($s0)
    add $t1,$t1,$t2
    add $t1,$t1,$t3
    addi $t8,$zero,3
    div $t1,$t8
    la $a0, gray
    li $v0,4
    syscall
    addi $a0,$t1,0
    li $v0,4
    syscall
    addi $s0,$s0,4
    sub $s1,$s1,1
    j rgb2gray
exit:
    li $v0, 10
    syscall 
.end main 