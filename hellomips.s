    .data
hello:  .asciiz "Hello world!"
    .text
main:
    la $a0,hello
    li $v0,4
    syscall

    li $v0,10 #exit
    syscall