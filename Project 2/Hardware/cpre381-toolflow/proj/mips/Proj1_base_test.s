# data section
.data
tmp:.word   0 : 19
      
# code/instruction section
.text
  	la   $11, tmp    	# load address of array
addi  $1,  $0,  1
addi  $2,  $0,  2
addi  $3,  $0,  3
addi  $4,  $0,  4
addi  $5,  $0,  5
addiu  $6,  $0,  -6
addiu  $7,  $0,  -7
addiu  $8,  $0,  8
addiu  $9,  $0,  9
addiu  $10, $0,  10
#add     $11, $10, $1
add  $12, $10, $2
add  $13, $10, $3
add     $14, $10, $4
add  $15, $10, $5
add  $16, $10, $6
add  $17, $10, $7
add  $18, $10, $8
add  $19, $10, $9
add  $20, $10, $10
add  $21, $10, $10
add  $22, $10, $12
add  $23, $10, $13
addi $14, $0, -14
addi $15, $0, -15
addu $24, $10, $14
addu $25, $10, $15
addu $26, $10, $16
addu $27, $10, $17
addu $28, $10, $18
addu $29, $10, $19
addu $30, $10, $20
addu $31, $10, $21   	 # Every register contains its own numeric value

and  $31, $1, $2
and  $30, $2, $3
and  $29, $3, $4
and  $28, $0, $1
andi $27, $3, 2
andi $26, $1, 2
andi $25, $0, 4294

lui  $24, 5
lui  $23, 3
lui  $22, 9
lui  $21, 0

sw   $20, 0($11)
sw   $19, 4($11)
sw   $18, 8($11)

lw   $18, 0($11)
lw   $20, 4($11)
lw   $19, 8($11)

addi $11, $0, 11

nor  $17, $1, $2
nor  $16, $2, $3
nor  $15, $3, $4

xor  $14, $1, $2
xor  $13, $2, $3
xor  $12, $3, $4

xori $11, $1, 2
xori $31, $2, 3
xori $30, $3, 4

or   $29, $1, $2
or   $28, $2, $3
or   $27, $3, $4

ori  $26, $1, 2
ori  $25, $2, 3
ori  $24, $3, 4

addi $3, $0, -3
addi $15, $0, -10
slt  $23, $1, $2
slt  $22, $4, $2
slt  $21, $5, $5
slt  $22, $15, $3

slti $20, $1, 2
slti $19, $4, -3
slti $18, $5, 5
slti $22, $15, -3


addi $1, $0, 1
sll $11, $1, 2
addi $3, $0, 3
sll $31, $3, 31
addi $7, $0, 7
sll $30, $7, 0

srl $29, $8, 2
srl $28, $10, 31
srl $27, $8, 0

sra $26, $8, 2
sra $25, $31, 16
sra $24, $31, 0

sub $14, $31, $10
sub $13, $9, $4
sub $12, $3, $6
sub $11, $3, $0

subu $30, $31, $10
subu $29, $9, $4
subu $28, $3, $6
subu $27, $3, $0



	# Exit program
	halt

