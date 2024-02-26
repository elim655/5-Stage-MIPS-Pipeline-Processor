  .data
arr: .word 63, 54, 28, 76, 32, 91, 12, 5, 85, 60, 53
  space: .asciiz " "
  .text
  .globl main

main:
  lui $s0, 0x1001        		 
  li $t0, 0               		 
  li $t1, 0              		 
  li $s1, 11            		 
  li $s2, 11              		 
  add $t2, $zero, $s0     		 
  add $t3, $zero, $s0    		 

  addi $s1, $s1, -1

outer_loop:
  li  $t1, 0              		 
  addi $s2, $s2, -1       		 
  add $t3, $zero, $s0  
NOP
NOP 	 

  inner_loop:
NOP
NOP
NOP
    lw $s3, 0($t3)        		 
    addi $t3, $t3, 4
NOP
NOP
NOP     		 
    lw $s4, 0($t3) 
NOP
NOP
NOP      		 
        		 
NOP
NOP
    slt $t4, $s3, $s4

NOP    
NOP
addi $t1, $t1, 1 
    bne $t4, $zero, cond
NOP
NOP
NOP
    swap:
      sw $s3, 0($t3)
      sw $s4, -4($t3)
NOP
NOP
NOP
      lw $s4, 0($t3)
    cond:
      bne $t1, $s2, inner_loop
      
NOP
NOP
NOP
    addi $t0, $t0, 1 
NOP
NOP
NOP       		 
  bne $t0, $s1, outer_loop  
NOP
NOP
NOP	 
  li $t0, 0
  addi $s1, $s1, 1

#Finished sorting, exit program

NOP
NOP
NOP
halt


