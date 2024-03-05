addi $t1,$t1,0
add $t0,$t0,$zero
addi $t3, $t3, 4
beq $t1,$t3,0x18
add $t0,$t0,$t1
addi $t1,$t1,1
j 0x8
addi $t2, $t2, 1

// machine code
0x21290000
0x01004020
0x216B0004
0x112B0018
0x01094020
0x2129000
0x08000008
0x214A0001
