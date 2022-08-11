#Εμεις επρεπε να διαβασουμε δυο string, να τα εκτυπωσουμε και να βρουμε τους κοινους χαρακτηρες και σε ποιες θεσεις βρισκονταν στα δυο strings

#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
firststring: .space 80
secondstring: .space 80
prompt0: .asciiz "Same character was:"
prompt1: .asciiz "Same character on positions: "
strend: .word 0


#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
__start:
                la $t7,strend
                lw $s3,0($t7)
read_str:	li $v0, 8					# code to read a string
		la $a0, firststring			
		li $a1, 80					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
		syscall

print_str:	li $v0, 4
		la $a0, firststring				
		syscall
		jal print_endl

		li $v0, 8					# code to read a string
		la $a0, secondstring				
		li $a1, 80					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
		syscall
                    
                li $v0, 4
		la $a0, secondstring				
		syscall
                jal print_endl
                    
                    
                li $t0, 0                   #i loop
                    
loop1: lbu $s0, firststring($t0)
        li $t1, 0                   #j loop
        beq $s0, $s3, Exit       
        loop2: lbu $s1, secondstring($t1) 
                beq $s1,$s3, loop1plus 
                beq $s0, $s1,same
                bne $s0, $s1, else

Exit:				li $v0, 10
				syscall				#au revoir...


print_endl:		la $a0,endl 			# system call to print
		 	li $v0, 4 			# out a newline
			syscall
			jr $ra



same:     
                    li $v0, 4
		    la $a0, prompt0				
		    syscall
		    move $a0, $s1
                    li $v0, 11
                    syscall
                    jal print_endl
                    li $v0, 4
		    la $a0, prompt1				
		    syscall
                    move $a0, $t0 
                    li $v0, 1
		    syscall 
                    jal print_endl
		    move $a0, $t1 
                    li $v0, 1
                    syscall
                    jal print_endl
                    addi $t1, $t1, 1
                    beq $s1, $zero, loop1plus
                    j loop2
else:  
        addi $t1, $t1, 1
        j loop2
loop1plus: addi $t0,$t0,1
            beq $s0,$s3, Exit 
            bne $s0, $s3,loop1               
