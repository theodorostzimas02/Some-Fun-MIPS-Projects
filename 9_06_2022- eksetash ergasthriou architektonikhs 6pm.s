#ΕΚΦΩΝΗΣΗ ΘΕΜΑΤΟΣ! 
#Γράψτε πρόγραμμα assembly mips που να διαβάζει συνεχώς σε ένα βρόχο πραγματικούς 
#αριθμούς απλής ακρίβειας μέχρι να διαβάσει το 0. Κάθε φορά που διαβάζει έναν αριθμό
#μετράει και εκτυπώνει το πλήθος των άσσων(=1) και των μηδενικών της δυαδικής 
#του αναπαράστασης

#Fun fact αυτό είναι το πρόβλημα που μου έπεσε στην εξέταση και πήρα 3 οπότε κόπηκε το εργαστήριο. 



#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
	li		$v0, 6				# $f0 <--- float
	syscall
	mov.s	$f12, $f0			# 
	li $v0, 2                   #Printing our float 
	syscall
	addi $t0,$t0,0 #counter for zeros
	addi $t1,$t1,0 #counter for ones
	addi $t2,$t2,0 #(bgt 31 tote exit)
	mov.s $f1,$f0                
	cvt.w.s $f1,$f1             #converting our float to integer
	mfc1 $s1, $f1               #moving it to coprocessor 0 where the integer registers are 
	move $t3,$s1                #copying our integer to register t3. t3 is the register that we manipulate to get the last bit each time 
	move $t4,$s1                #copying ouer integer to register t4. t4 is the register that we shift after every loop so we can check the next bit 
main:
	bgt $t2,31, FinalResults	
	sll $t3,$t3,31 
	srl $t3,$t3,31
	bne $t3,$zero,count1 
	j count0
	
count1:
	addi $t1,$t1,1
	addi $t2,$t2,1
	srl $t4,$t4,1
	move $t3,$t4 
	j main 
count0:
	addi $t0,$t0,1
	addi $t2,$t2,1
	srl $t4,$t4,1
	move $t3,$t4 
	j main 


FinalResults:
			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
			move $a0,$s1			#printing the integer that we converted from our original float 
			li $v0, 1
			syscall	
			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
			move $a0,$t0				#printing the number of 0s on the binary form of our integer
			li $v0, 1
			syscall
			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
			move $a0,$t1				#printing the number of 1s on the binary form of our integer
			li $v0, 1
			syscall
			j Exit
				




Exit:				li 		$v0, 10
					syscall				#au revoir...