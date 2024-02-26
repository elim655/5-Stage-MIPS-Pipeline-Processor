bne1:
	addi $t0, $zero, 5
	addi $t1, $zero, 10
	bne $t0, $t1, bne2
bne3:
	addi $t0, $zero, 5
	addi $t1, $zero, 10
	bne $t0, $t1, bne4
bne5:
	addi $t0, $zero, 5
	addi $t1, $zero, 10
	bne $t0, $t1, beq1
bne4:
	addi $t0, $zero, 5
	addi $t1, $zero, 15
	bne $t0, $t1, bne5
bne2:
	addi $t0, $zero, 5
	addi $t1, $zero, 20
	bne $t0, $t1, bne3
beq1:
	addi $t0, $zero, 10
	addi $t1, $zero, 10
	beq $t0, $t1, beq2
beq4:
	addi $t0, $zero, 10
	addi $t1, $zero, 14
	beq $t0, $t1, beq5
beq5:
	addi $t0, $zero, 150
	addi $t1, $zero, 150
	beq $t0, $t1, j1
beq3:
	addi $t0, $zero, 100
	addi $t1, $zero, 100
	beq $t0, $t1, beq4
beq2:
	addi $t0, $zero, 20
	addi $t1, $zero, 20
	beq $t0, $t1, beq3
j1:
	j j2
j3:
	j j4
j4:
	j jal1
j2:
	j j3
jal1:
	jal jr1
jal2:
	jal jr2
jal3:
	jal jr3
jal4:
	jal jr4
jal5:
	jal jr5
j5:
	j exit
jr1:
	jr $ra
jr2:
	jr $ra
jr3:
	jr $ra
jr4:
	jr $ra
jr5:
	jr $ra

exit:
	halt
