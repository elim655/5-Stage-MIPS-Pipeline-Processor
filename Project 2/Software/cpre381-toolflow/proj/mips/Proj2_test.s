#
# Test software scheduled pipeline by avoiding control and data hazards
# Avoid data hazards by having instructions in-between read after right
#

# data section
.data

# code/instruction section

.text
lui   $4,  0x1001   	 # Store address in $4
addi  $1,  $0,  1    	 # $1 = 1
addi  $2,  $0,  2   	 # $2 = 2
lui   $3,  0xFFFF   	 
addi  $3,  $0,  23   	 # $3 = 0xFFFFFFFF
NOP
sw	$2,  0($4)   	 # Mem 0x10010000 = 2
sub   $5,  $1,  $2   	 # $5 = 0xFFFFFFFF
sll   $1,  $1,  2   	 # $1 = 4
lw	$6,  0($4)   	 # $6 = 2

add   $0,  $0,  $0   	 # NOOP
NOP
slt   $8,  $2,  $1   	 # $8 = 0
slt   $7,  $6,  $1   	 # $7 = 1

beq   $5,  $0,  L1   	 # Should evaluate to false, no controll hazard
addi  $9,  $1,  -2   	 # $9 = 2
beq   $5,  $3,  L2   	 # Should evaluate to true, and branch to
add   $0,  $0,  $0   	 # NOOP
add   $0,  $0,  $0   	 # NOOP
add   $0,  $0,  $0   	 # NOOP
addi  $9,  $0,  0   	 # $9 = 2, instruction should not get loaded

L2:
andi $5, $5, 0x0000   	 # $5 = 0xFFFF0000
ori  $4, $4, 0x0001   	 # $4 = 0x10010001
add  $0,  $0,  $0   	 # NOOP
add  $0,  $0,  $0   	 # NOOP
xor  $3,  $3,  $1   	 # $3 = 0xFFFFFFFC

j	L1   			 # Go to L1
add   $0,  $0,  $0   	 # NOOP
add   $0,  $0,  $0   	 # NOOP
add   $0,  $0,  $0   	 # NOOP
addi  $9,  $0,  0   	 # $9 = 2, instruction should not get loaded


L1:     
halt

