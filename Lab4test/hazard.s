//forwarding
addi $t2,$t2,0x4
lw $t1,0($t2)
add $t3,$t1,$t0 // stall and forwarding

//machine 
0x214A0004
0x8D490000
0x01285820