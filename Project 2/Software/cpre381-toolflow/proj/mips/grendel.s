#
# Topological sort using an adjacency matrix. Maximum 4 nodes.
# 
# The expected output of this program is that the 1st 4 addresses of the data segment
# are [4,0,3,2]. should take ~2000 cycles in a single cycle procesor.
#

.data
res:
	.word -1-1-1-1
nodes:
        .byte   97 # a
        .byte   98 # b
        .byte   99 # c
        .byte   100 # d
adjacencymatrix:
        .word   6
        .word   0
        .word   0
        .word   3
visited:
	.byte 0 0 0 0
res_idx:
        .word   3
.text
	#li $sp, 0x10011000 
	lui $sp, 0x1001
	NOP
	NOP
	NOP
	ori $sp, $sp, 0x1000

	#li $fp, 0
	lui $fp, 0x0000

 
	lasw $ra pump
	j main # jump to the starting location
	NOP
	NOP
	NOP
	NOP
pump:
	halt


main:
        addiu   $sp,$sp,-40 # MAIN
	NOP
	NOP
	NOP
        sw      $31,36($sp)
        sw      $fp,32($sp)
        add    	$fp,$sp,$zero
	NOP
	NOP
	NOP
        sw      $0,24($fp)
        j       main_loop_control
	NOP
	NOP
	NOP
	NOP

main_loop_body:
        lw      $4,24($fp)
        lasw 	$ra, trucks
        j     is_visited
	NOP
	NOP
	NOP
	NOP

        trucks:

        xori    $2,$2,0x1
	NOP
	NOP
	NOP
        andi    $2,$2,0x00ff
	NOP
	NOP
	NOP
        beq     $2,$0,kick
	NOP
	NOP
	NOP
	NOP

        lw      $4,24($fp)
        # addi 	$k0, $k0,1# breakpoint
        lasw 	$ra, billowy
        j     	topsort
	NOP
	NOP
	NOP
	NOP
        billowy:

kick:
        lw      $2,24($fp)
	NOP
	NOP
	NOP
        addiu   $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,24($fp)
	NOP
	NOP
	NOP
main_loop_control:
        lw      $2,24($fp)
	NOP
	NOP
	NOP
	NOP
        slti     $2,$2, 4
	NOP
	NOP
	NOP
	NOP
        beq	$2, $zero, hew # beq, j to simulate bne
	NOP
	NOP
	NOP
        j       main_loop_body
	NOP
	NOP
	NOP
	NOP
        hew:
        sw      $0,28($fp)
        j       welcome
	NOP
	NOP
	NOP

wave:
        lw      $2,28($fp)
	NOP
	NOP
	NOP
	NOP
        addiu   $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,28($fp)
welcome:

        lw      $2,28($fp)
	NOP
	NOP
	NOP
	NOP
        slti    $2,$2,4
	NOP
	NOP
	NOP
        xori	$2,$2,1 # xori 1, beq to simulate bne where val in [0,1]
	NOP
	NOP
	NOP
        beq     $2,$0,wave
	NOP
	NOP
	NOP

        move    $2,$0
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
	NOP
	NOP
        jr       $ra
	NOP
	NOP
	NOP
        
interest:
        lw      $4,24($fp)
        lasw	$ra, new
        j	is_visited
	NOP
	NOP
	NOP

	new:
        xori    $2,$2,0x1
	NOP
	NOP
	NOP
        andi    $2,$2,0x00ff
	NOP
	NOP
	NOP
        beq     $2,$0,tasteful
	NOP
	NOP
	NOP

        lw      $4,24($fp)
        lasw	$ra, partner
        j     	topsort
	NOP
	NOP
	NOP
        partner:

tasteful:
        addiu   $2,$fp,28
	NOP
	NOP
	NOP
        move    $4,$2
        lasw	$ra, badge
        j     next_edge
	NOP
	NOP
	NOP
        badge:
        sw      $2,24($fp)
        
turkey:
	NOP
	NOP
	NOP
        lw      $3,24($fp)
        #li      $2,-1
	lui	$2, 0xFFFF
	NOP
	NOP
	NOP
	ori	$2, $2, 0xFFFF
	NOP
	NOP
	NOP

        beq	$3,$2,telling # beq, j to simulate bne
	NOP
	NOP
	NOP
        j	interest
	NOP
	NOP
	NOP
        telling:
	lasw 	$v0, res_idx
	NOP
	NOP
	NOP
	lw	$v0, 0($v0)
	NOP
	NOP
	NOP
        addiu   $4,$2,-1
        lasw 	$3, res_idx
	NOP
	NOP
	NOP
        sw 	$4, 0($3)
        lasw	$4, res
        #lui     $3,%hi(res_idx)
        #sw      $4,%lo(res_idx)($3)
        #lui     $4,%hi(res)
        sll     $3,$2,2
	NOP
	NOP
	NOP
        srl	$3,$3,1
	NOP
	NOP
	NOP
        sra	$3,$3,1
	NOP
	NOP
	NOP
        sll     $3,$3,2
       
       	xor	$at, $ra, $2 # does nothing 
        nor	$at, $ra, $2 # does nothing 
        
        lasw	$2, res
	NOP
	NOP
	NOP
        andi	$at, $2, 0xffff # -1 will sign extend (according to assembler), but 0xffff won't
	NOP
	NOP
	NOP
        addu 	$2, $4, $at
	NOP
	NOP
	NOP
        addu    $2,$3,$2
        lw      $3,48($fp)
	NOP
	NOP
	NOP
        sw      $3,0($2)
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $31,44($sp)
        lw      $fp,40($sp)
        addiu   $sp,$sp,48
	NOP
	NOP
        jr      $ra
	NOP
	NOP
	NOP
   
topsort:
        addiu   $sp,$sp,-48
	NOP
	NOP
	NOP
        sw      $31,44($sp)
        sw      $fp,40($sp)
        move    $fp,$sp
	NOP
	NOP
	NOP
        sw      $4,48($fp)
        lw      $4,48($fp)
        lasw	$ra, verse
        j	mark_visited
	NOP
	NOP
	NOP

        verse:

        addiu   $2,$fp,28
        lw      $5,48($fp)
	NOP
	NOP
        move    $4,$2
        lasw 	$ra, joyous
        j	iterate_edges
	NOP
	NOP
	NOP
        joyous:

        addiu   $2,$fp,28
	NOP
	NOP
	NOP
        move    $4,$2
        lasw	$ra, whispering
        j     	next_edge
	NOP
	NOP
	NOP
        whispering:

        sw      $2,24($fp)
        j       turkey
	NOP
	NOP
	NOP

iterate_edges:
        addiu   $sp,$sp,-24
	NOP
	NOP
	NOP
        sw      $fp,20($sp)
        move    $fp,$sp
	NOP
	NOP
	NOP
        subu	$at, $fp, $sp
        sw      $4,24($fp)
        sw      $5,28($fp)
        lw      $2,28($fp)
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        sw      $0,12($fp)
        lw      $2,24($fp)
        lw      $4,8($fp)
        lw      $3,12($fp)
	NOP
	NOP
	NOP
        sw      $4,0($2)
        sw      $3,4($2)
        lw      $2,24($fp)
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        jr      $ra
	NOP
	NOP
	NOP
        
next_edge:
        addiu   $sp,$sp,-32
	NOP
	NOP
	NOP
        sw      $31,28($sp)
        sw      $fp,24($sp)
        add	$fp,$zero,$sp
	NOP
	NOP
	NOP
        sw      $4,32($fp)
        j       waggish
	NOP
	NOP
	NOP

snail:
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        lw      $3,0($2)
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        lw      $2,4($2)
	NOP
	NOP
	NOP
	NOP
        move    $5,$2
        move    $4,$3
        lasw	$ra,induce
        j       has_edge
	NOP
	NOP
	NOP
        induce:
        beq     $2,$0,quarter
	NOP
	NOP
	NOP
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        lw      $2,4($2)
	NOP
	NOP
	NOP
	NOP
        addiu   $4,$2,1
        lw      $3,32($fp)
	NOP
	NOP
	NOP
	NOP
        sw      $4,4($3)
        j       cynical
	NOP
	NOP
	NOP


quarter:
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        lw      $2,4($2)
	NOP
	NOP
	NOP
	NOP
        addiu   $3,$2,1
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        sw      $3,4($2)

waggish:
        lw      $2,32($fp)
	NOP
	NOP
	NOP
	NOP
        lw      $2,4($2)
	NOP
	NOP
	NOP
        slti    $2,$2,4
	NOP
	NOP
	NOP
	NOP
        beq	$2,$zero,mark # beq, j to simulate bne 
	NOP
	NOP
	NOP
        j	snail
	NOP
	NOP
	NOP
        mark:
        #li      $2,-1
	lui $2, 0xFFFF
	NOP
	NOP
	NOP
	ori $2, $2, 0xFFFF

cynical:
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
	NOP
	NOP
        jr      $ra
	NOP
	NOP
	NOP

has_edge:
        addiu   $sp,$sp,-32
	NOP
	NOP
	NOP
        sw      $fp,28($sp)
        move    $fp,$sp
	NOP
	NOP
	NOP
        sw      $4,32($fp)
        sw      $5,36($fp)
        lasw      $2,adjacencymatrix
        lw      $3,32($fp)
	NOP
	NOP
	NOP
        sll     $3,$3,2
	NOP
	NOP
	NOP
        addu    $2,$3,$2
	NOP
	NOP
	NOP
        lw      $2,0($2)
	NOP
	NOP
	NOP
        sw      $2,16($fp)
        #li      $2,1
	lui	$2, 0x0000
	NOP
	NOP
	NOP
	ori 	$2, $2, 0x0001
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       measley
	NOP
	NOP
	NOP

look:
        lw      $2,8($fp)
	NOP
	NOP
	NOP
        sll     $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        lw      $2,12($fp)
	NOP
	NOP
	NOP
        addiu   $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,12($fp)
measley:
        lw      $3,12($fp)
        lw      $2,36($fp)
	NOP
	NOP
	NOP
        slt     $2,$3,$2
	NOP
	NOP
	NOP
	NOP
        beq     $2,$0,experience # beq, j to simulate bne 
	NOP
	NOP
	NOP
        j 	look
	NOP
	NOP
	NOP
       	experience:
        lw      $3,8($fp)
        lw      $2,16($fp)
	NOP
	NOP
	NOP
        and     $2,$3,$2
	NOP
	NOP
	NOP
        slt     $2,$0,$2
	NOP
	NOP
	NOP
        andi    $2,$2,0x00ff
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
	NOP
	NOP
	NOP
        
mark_visited:
        addiu   $sp,$sp,-32
	NOP
	NOP
	NOP
        sw      $fp,28($sp)
        move    $fp,$sp
	NOP
	NOP
	NOP
        sw      $4,32($fp)
        #li      $2,1
	lui	$2, 0x0000
	NOP
	NOP
	NOP
	ori	$2, $2, 0x0001
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       recast
	NOP
	NOP
	NOP

example:
        lw      $2,8($fp)
	NOP
	NOP
	NOP
        sll     $2,$2,8
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        lw      $2,12($fp)
	NOP
	NOP
	NOP
        addiu   $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,12($fp)
recast:
        lw      $3,12($fp)
        lw      $2,32($fp)
	NOP
	NOP
	NOP
        slt     $2,$3,$2
	NOP
	NOP
	NOP
	NOP
        beq	$2,$zero,pat # beq, j to simulate bne
	NOP
	NOP
	NOP
        j	example
	NOP
	NOP
	NOP
        pat:

       	lasw	$2, visited
	NOP
	NOP
	NOP
        sw      $2,16($fp)
        lw      $2,16($fp)
	NOP
	NOP
	NOP
        lw      $3,0($2)
        lw      $2,8($fp)
	NOP
	NOP
	NOP
        or      $3,$3,$2
        lw      $2,16($fp)
	NOP
	NOP
	NOP
        sw      $3,0($2)
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
	NOP
	NOP
	NOP
        
is_visited:
        addiu   $sp,$sp,-32
	NOP
	NOP
	NOP
        sw      $fp,28($sp)
        move    $fp,$sp
	NOP
	NOP
	NOP
        sw      $4,32($fp)
        ori     $2,$zero,1
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       evasive
	NOP
	NOP
	NOP

justify:
        lw      $2,8($fp)
	NOP
	NOP
	NOP
        sll     $2,$2,8
	NOP
	NOP
	NOP
        sw      $2,8($fp)
        lw      $2,12($fp)
	NOP
	NOP
	NOP
        addiu   $2,$2,1
	NOP
	NOP
	NOP
        sw      $2,12($fp)
evasive:
        lw      $3,12($fp)
        lw      $2,32($fp)
	NOP
	NOP
	NOP
        slt     $2,$3,$2
	NOP
	NOP
	NOP
	NOP
        beq	$2,$0,representitive # beq, j to simulate bne
	NOP
	NOP
	NOP
        j     	justify
	NOP
	NOP
	NOP
        representitive:

        lasw	$2,visited
	NOP
	NOP
	NOP
        lw      $2,0($2)
	NOP
	NOP
	NOP
        sw      $2,16($fp)
        lw      $3,16($fp)
        lw      $2,8($fp)
	NOP
	NOP
	NOP
        and     $2,$3,$2
	NOP
	NOP
	NOP
        slt     $2,$0,$2
	NOP
	NOP
	NOP
        andi    $2,$2,0x00ff
        move    $sp,$fp
	NOP
	NOP
	NOP
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
