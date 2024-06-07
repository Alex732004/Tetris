################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Siwei Zhan, 1008927299
# Student 2: Alex Yao, 1009081468
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    64
# - Display height in pixels:   64
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

GRID_OCC_MAP:
    .space 1536

GRID_INIT_ADD:
    .word 0x10008d0c

lightGREY:
    .word 0xd3d3d3

darkGREY:
    .word 0x454549

midGREY:
    .word 0x848489

RED:  #S
    .word 0xFF0000
ORANGE:  #L
    .word 0xFFA500

YELLOW:  #O
    .word 0xFFFF00

CYAN:  #I
    .word 0x1E90FF

PURPLE:  #T
    .word 0x800080

GREEN:  #Z
    .word 0x00FF00

PINK:  #J
    .word 0xFFC0CB
    
O_Tetro_Original:
    .byte 0 1 1 0
    .byte 0 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

O_Tetro_R1:
    .byte 0 1 1 0
    .byte 0 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

O_Tetro_R2:
    .byte 0 1 1 0
    .byte 0 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

O_Tetro_R3:
    .byte 0 1 1 0
    .byte 0 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

I_Tetro_Original:
    .byte 0 0 0 0
    .byte 1 1 1 1
    .byte 0 0 0 0
    .byte 0 0 0 0

I_Tetro_R1:
    .byte 0 0 1 0
    .byte 0 0 1 0
    .byte 0 0 1 0
    .byte 0 0 1 0

I_Tetro_R2:
    .byte 0 0 0 0
    .byte 0 0 0 0
    .byte 1 1 1 1
    .byte 0 0 0 0

I_Tetro_R3:
    .byte 0 1 0 0
    .byte 0 1 0 0
    .byte 0 1 0 0
    .byte 0 1 0 0

S_Tetro_Original:
    .byte 0 1 1 0
    .byte 1 1 0 0
    .byte 0 0 0 0
    .byte 0 0 0 0

S_Tetro_R1:
    .byte 0 1 0 0
    .byte 0 1 1 0
    .byte 0 0 1 0
    .byte 0 0 0 0

S_Tetro_R2:
    .byte 0 1 1 0
    .byte 1 1 0 0
    .byte 0 0 0 0
    .byte 0 0 0 0

S_Tetro_R3:
    .byte 0 1 0 0
    .byte 0 1 1 0
    .byte 0 0 1 0
    .byte 0 0 0 0


Z_Tetro_Original:
    .byte 0 1 1 0
    .byte 0 0 1 1
    .byte 0 0 0 0
    .byte 0 0 0 0

Z_Tetro_R1:
    .byte 0 0 1 0
    .byte 0 1 1 0
    .byte 0 1 0 0
    .byte 0 0 0 0

Z_Tetro_R2:
    .byte 0 0 0 0
    .byte 1 1 0 0
    .byte 0 1 1 0
    .byte 0 0 0 0

Z_Tetro_R3:
    .byte 0 1 0 0
    .byte 1 1 0 0
    .byte 1 0 0 0
    .byte 0 0 0 0

L_Tetro_Original:
    .byte 0 0 1 0
    .byte 1 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

L_Tetro_R1:
    .byte 0 1 0 0
    .byte 0 1 0 0
    .byte 0 1 1 0
    .byte 0 0 0 0

L_Tetro_R2:
    .byte 0 0 0 0
    .byte 1 1 1 0
    .byte 1 0 0 0
    .byte 0 0 0 0

L_Tetro_R3:
    .byte 0 1 1 0
    .byte 0 0 1 0
    .byte 0 0 1 0
    .byte 0 0 0 0

J_Tetro_Original:
    .byte 0 1 0 0
    .byte 0 1 1 1
    .byte 0 0 0 0
    .byte 0 0 0 0

J_Tetro_R1:
    .byte 0 1 1 0
    .byte 0 1 0 0
    .byte 0 1 0 0
    .byte 0 0 0 0

J_Tetro_R2:
    .byte 0 0 0 0
    .byte 1 1 1 0
    .byte 0 0 1 0
    .byte 0 0 0 0

J_Tetro_R3:
    .byte 0 1 0 0
    .byte 0 1 0 0
    .byte 1 1 0 0
    .byte 0 0 0 0

T_Tetro_Original:
    .byte 0 1 0 0
    .byte 1 1 1 0
    .byte 0 0 0 0
    .byte 0 0 0 0

T_Tetro_R1:
    .byte 0 1 0 0
    .byte 0 1 1 0
    .byte 0 1 0 0
    .byte 0 0 0 0

T_Tetro_R2:
    .byte 0 0 0 0
    .byte 1 1 1 0
    .byte 0 1 0 0
    .byte 0 0 0 0

T_Tetro_R3:
    .byte 0 1 0 0
    .byte 1 1 0 0
    .byte 0 1 0 0
    .byte 0 0 0 0


##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.
main:
    # Initialize the game
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    li $t1, 0xd3d3d3        # $t1 = light grey; form the wall
    li $t2, 0x454549        # $t2 = dark grey; form the background grid
    li $t3, 0x848489        # $t3 = mid grey; form the backgroun grid

    sw $t1, 0($t0)          # paint the first unit (i.e., top-left) red
    sw $t2, 4($t0)          # paint the second unit on the first row green
    sw $t3, 256($t0)        # paint the first unit on the second row blue

    add $t4, $t0, $zero
    addi $t5, $t0, 16384    # paint till the bottom
left:   # paint the left wall grey
    sw $t1, 0($t4)
    sw $t1, 4($t4)
    sw $t1, 8($t4)
    addi $t4, $t4, 256
    beq $t4, $t5, pre_bottom
    j left

pre_bottom:
    addi $t4, $t0, 15616    # $t4 is set to be the first pixel on the thrid bottom line
    addi $t5, $t0, 16384    # $t5 is set to be the upper limit of row
bottom: #paint the bottom wall grey
    sw $t1, 0($t4)
    addi $t4, $t4, 4
    beq $t4, $t5, pre_right
    j bottom

pre_right:
    addi $t4, $t0, 140
    addi $t5, $t0, 16268
right:
    sw $t1, 0($t4)
    sw $t1, 4($t4)
    sw $t1, 8($t4)
    addi $t4, $t4, 256
    beq $t4, $t5, pre_grid
    j right

pre_grid:
    addi $t8, $t0, 3340
    addi $t4, $t8, 0
    addi $t5, $zero, 8
    addi $t6, $zero, 0
    addi $t7, $zero, 0
    addi $t9, $zero, 12
grid:
    sw $t2, 0($t4)
    sw $t2, 4($t4)
    sw $t2, 256($t4)
    sw $t2, 260($t4)
    sw $t2, 520($t4)
    sw $t2, 524($t4)
    sw $t2, 776($t4)
    sw $t2, 780($t4)
    
    sw $t3, 8($t4)
    sw $t3, 12($t4)
    sw $t3, 264($t4)
    sw $t3, 268($t4)
    sw $t3, 512($t4)
    sw $t3, 516($t4)
    sw $t3, 768($t4)
    sw $t3, 772($t4)
    addi $t4, $t4, 16
    addi $t6, $t6, 1
    beq $t6, $t5, grid_row
    j grid

grid_row:
    addi $t7, $t7, 1
    addi $t8, $t8, 1024
    addi $t4, $t8, 0
    addi $t6, $zero, 0
    beq $t7, $t9, next_tetro_panel
    j grid

next_tetro_panel:
    addi $t4, $t0, 10680
    lw $t1, lightGREY
    sw $t1, 0($t4)
    sw $t1, 4($t4)
    sw $t1, 8($t4)
    sw $t1, 12($t4)
    sw $t1, 16($t4)
    sw $t1, 20($t4)
    sw $t1, 24($t4)
    sw $t1, 28($t4)
    sw $t1, 32($t4)
    sw $t1, 36($t4)
    sw $t1, 40($t4)
    
    sw $t1, 256($t4)
    sw $t1, 296($t4)
    
    sw $t1, 512($t4)
    sw $t1, 552($t4)
    
    sw $t1, 768($t4)
    sw $t1, 808($t4)
    
    sw $t1, 1024($t4)
    sw $t1, 1064($t4)
    
    sw $t1, 1280($t4)
    sw $t1, 1320($t4)
    
    sw $t1, 1536($t4)
    sw $t1, 1576($t4)
    
    sw $t1, 1792($t4)
    sw $t1, 1832($t4)
    
    sw $t1, 2048($t4)
    sw $t1, 2088($t4)
    
    sw $t1, 2304($t4)
    sw $t1, 2308($t4)
    sw $t1, 2312($t4)
    sw $t1, 2316($t4)
    sw $t1, 2320($t4)
    sw $t1, 2324($t4)
    sw $t1, 2328($t4)
    sw $t1, 2332($t4)
    sw $t1, 2336($t4)
    sw $t1, 2340($t4)
    sw $t1, 2344($t4)

    j tetrimino_intro

pre_clear_panel:
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 10940
    addi $t1, $zero, 0
    addi $t2, $zero, 8
clear_panel:
    sw $zero, 0($t0)
    sw $zero, 4($t0)
    sw $zero, 8($t0)
    sw $zero, 12($t0)
    sw $zero, 16($t0)
    sw $zero, 20($t0)
    sw $zero, 24($t0)
    sw $zero, 28($t0)
    
    addi $t1, $t1, 1
    addi $t0, $t0, 256
    bne $t1, $t2, clear_panel

    jr $ra

    
    
tetrimino_intro:
    jal pre_random_layer  
    lw $t0, ADDR_DSPL
  
    addi $t4, $t0, 10680
    addi $t9, $zero, 0          # $t9 keeps track of the levels of the game
    j generate_new_tetro

pre_random_layer:
    lw $t0, GRID_INIT_ADD
    addi $t4, $t0, 9728         # initial index
    addi $t5, $t4, 0            # current index
    addi $t0, $zero, 0          # row iterator
    addi $t1, $zero, 0          # column iterator
random_layer:
    li $v0, 42
    li $a0, 0
    li $a1, 2
    syscall
    addi $t1, $t1, 1
    beq $t1, 17, random_layer_next_row
    beq $a0, 1, random_success
    addi $t5, $t5, 8
    j random_layer
random_success:
    lw $s0, PINK
    sw $s0, 0($t5)
    sw $s0, 4($t5)
    sw $s0, 256($t5)
    sw $s0, 260($t5)
    addi $t5, $t5, 8
    j random_layer
random_layer_next_row:
    addi $t1, $zero, 512
    addi $t0, $t0, 1
    mult $t0, $t1
    mflo $t1
    add $t5, $t4, $t1
    
    addi $t1, $zero, 0
    beq $t0, 5, random_layer_finish
    j random_layer
random_layer_finish:
    jr $ra
    
    
recover_S:      # helper function; need $t4 as the initial point
    addi $t1, $zero, 1024
    lw $t2, GRID_INIT_ADD
    sub $t2, $t4, $t2
    div $t2, $t1
    mfhi $t2
    subi $t1, $t1, 512
    bge $t2, $t1, recover_second
    j recover_first

recover_first:
    addi $t1, $zero, 16
    lw $t2, GRID_INIT_ADD
    sub $t2, $t4, $t2
    div $t2, $t1
    mfhi $t2
    subi $t1, $t1, 8
    bge $t2, $t1, recover_midGREY
    j recover_darkGREY

recover_second:
    addi $t1, $zero, 16
    lw $t2, GRID_INIT_ADD
    sub $t2, $t4, $t2
    div $t2, $t1
    mfhi $t2
    subi $t1, $t1, 8
    bge $t2, $t1, recover_darkGREY
    j recover_midGREY
    
recover_midGREY:
    lw $t1, midGREY
    lw $t2, darkGREY
    sw $t1, 0($t4)
    sw $t1, 4($t4)
    sw $t2, 8($t4)
    sw $t2, 12($t4)
    
    sw $t1, 256($t4)
    sw $t1, 260($t4)
    sw $t2, 264($t4)
    sw $t2, 268($t4)
    
    sw $t1, 504($t4)
    sw $t1, 508($t4)
    sw $t2, 512($t4)
    sw $t2, 516($t4)
    
    sw $t1, 760($t4)
    sw $t1, 764($t4)
    sw $t2, 768($t4)
    sw $t2, 772($t4)
    jr $ra
    
recover_darkGREY:
    lw $t2, midGREY
    lw $t1, darkGREY
    sw $t1, 0($t4)
    sw $t1, 4($t4)
    sw $t2, 8($t4)
    sw $t2, 12($t4)
    
    sw $t1, 256($t4)
    sw $t1, 260($t4)
    sw $t2, 264($t4)
    sw $t2, 268($t4)
    
    sw $t1, 504($t4)
    sw $t1, 508($t4)
    sw $t2, 512($t4)
    sw $t2, 516($t4)
    
    sw $t1, 760($t4)
    sw $t1, 764($t4)
    sw $t2, 768($t4)
    sw $t2, 772($t4)
    jr $ra

Pre_Paint:
    # $a0: initial address of tetro (shape of tetro)
    # $a1: color of tetro
    # $a2: initial address of the grid that we want to start with
    # $t3: loop through the bytes of tetro
    # $t5: temp variable to store the address of the current pixel
    lb $t0, 0($a0)
    addi $t1, $a1, 0
    addi $t3, $zero, 15
    addi $t2, $zero, 0 		# the iterator
    addi $t5, $a2, 0    # initial adress of the pixel to be painted
Paint:
    # Update and set $t5 to be the current address of the pixel to be painted
    addi $t6, $zero, 4
    div $t2, $t6
    mfhi $t7    # set $t7 to be the remainder, i.e. column number
    mflo $t6    # set $t6 to be the row number
    addi $t8, $zero, 512
    mult $t8, $t6
    mflo $t6    # now $t6 is row * 512
    add $t5, $a2, $t6
    addi $t6, $zero, 8
    mult $t7, $t6
    mflo $t7    # now $t7 is column * 8
    add $t5, $t5, $t7
    
    beq $t0, 1, paint_Color
    
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Paint
    jr $ra
paint_Color:
    sw $t1, 0($t5)
    sw $t1, 4($t5)
    sw $t1, 256($t5)
    sw $t1, 260($t5)

    addi $t5, $t5, 8    # move to the next square
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Paint
    jr $ra


Pre_Restore:
    # $a0: initial address of tetro (shape of tetro)
    # $a1: color of tetro (dakrGREY or midGREY)
    # $a2: initial address of the grid that we want to start with
    # $t2: the iterator
    # $t3: loop through the bytes of tetro
    # $t5: temp variable to store the address of the current pixel
    lb $t0, 0($a0)
    addi $t1, $a1, 0
    addi $t3, $zero, 15
    addi $t2, $zero, 0 		# the iterator
    addi $t5, $a2, 0    # initial adress of the pixel to be painted
Restore:
    # Update and set $t5 to be the current address of the pixel to be painted
    addi $t6, $zero, 4
    div $t2, $t6
    mfhi $t7    # set $t7 to be the remainder, i.e. column number
    mflo $t6    # set $t6 to be the row number
    addi $t8, $zero, 512
    mult $t8, $t6
    mflo $t6    # now $t6 is row * 512
    add $t5, $a2, $t6
    addi $t6, $zero, 8
    mult $t7, $t6
    mflo $t7    # now $t7 is column * 8
    add $t5, $t5, $t7
    
    addi $t6, $zero, 2
    div $t2, $t6

    
    subi $sp, $sp, 4
    sw $ra, 0($sp)
    subi $sp $sp, 4
    sw $t0, 0($sp)
    subi $sp, $sp, 4
    sw $a0, 0($sp)
    addi $a0, $t5, 0
    jal determine_grid_color_by_index
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    beq $t0, 1, restore_Color
    
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Restore
    jr $ra
restore_Color:
    addi $t1, $a1, 0
    sw $t1, 0($t5)
    sw $t1, 4($t5)
    sw $t1, 256($t5)
    sw $t1, 260($t5)

    addi $t5, $t5, 8    # move to the next square
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Restore
    jr $ra

restore_switch_Color:
    lw $t0, midGREY
    beq $t1, $t0, restore_darkGREY
    addi $t1, $t0, 0
    sw $t1, 0($t5)
    sw $t1, 4($t5)
    sw $t1, 256($t5)
    sw $t1, 260($t5)

    addi $t5, $t5, 8    # move to the next square
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Restore
    jr $ra

restore_darkGREY:
    lw $t0, darkGREY
    addi $t1, $t0, 0
    sw $t1, 0($t5)
    sw $t1, 4($t5)
    sw $t1, 256($t5)
    sw $t1, 260($t5)

    addi $t5, $t5, 8    # move to the next square
    addi $t2, $t2, 1    # i += 1
    add $t6, $a0, $t2
    lb $t0, 0($t6)
    bne $t2, $t3, Restore
    jr $ra
#######################################
#DEMONSTRATION_1_Intro:
#    addi $t4, $t0, 3396
#    jal paint_S
#    addi $t5, $t4, 0
#    addi $t6, $zero, 's'
##    jal update_grid_occ_map
#    j game_loop
#    j DEMONSTRATION_1_Intro
#update_grid_occ_map:    # Need $t6 to determine which type of tetrominoes; Need $t5 as the initial point
#    la $t1, GRID_OCC_MAP
#    la $t2, GRID_INIT_ADD
#    sub $t2, $t5, $t2
#    addi $t3, $zero, 8
#    div $t2, $t3
#    beq $t6, 83, update_grid_tetroS     # 's' type of tetro
#    
#update_grid_tetroS:     # helper function of update_grid_occ_map
#    mflo $t6
#    addi $t6, $t6, 1
#    addi $t7, $zero, 4
#    mult $t6, $t7
#    mflo $t6
#    add $t2, $t2, $t6
#    addi $t7, $zero, 1
#    #sw $t7, 0($t6)     To be continued
##    
#    jr $ra
#################################################   
    
game_loop:
    # Should save any changes regarding the type of tetros in $a1
	# 1a. Check if key has been pressed
	li 		$v0, 32
	li 		$a0, 1
	syscall

    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    
    
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	addi $t8, $zero, 500
	sub $t8, $t8, $t9
	li $v0, 32
	addi $a0, $t8, 0
	syscall 
	
	
	j respond_to_S
	
	bge $t9, 10, pre_random_rotation
	# 3. Draw the screen
	# 4. Sleep
    
    #5. Go back to 1
    b game_loop

pre_random_rotation:
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    addi $sp, $sp, -4
    sw $a1, 0($sp)
    
    li $v0, 42   
    li $a0, 0
    li $a1, 9  
    syscall  
    
    addi $t1, $t1, 10
    div $a0, $t1
    mfhi $t1
    
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    
    beq $t1, 0, random_rotation
    b game_loop
    
random_rotation:
    j respond_to_W
    b game_loop

keyboard_input:                     # A key is pressed
    lw $a0, 4($t0)                  # Load second word from keyboard
    beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed
    beq $a0, 0x61, respond_to_A
    beq $a0, 0x73, respond_to_S
    beq $a0, 0x64, respond_to_D
    beq $a0, 0x77, respond_to_W
    beq $a0, 0x6a, respond_to_A
    beq $a0, 0x6b, respond_to_S
    beq $a0, 0x6c, respond_to_D
    beq $a0, 0x69, respond_to_W
    li $v0, 1                       # ask system to print $a0
    syscall

    b game_loop

respond_to_W:
    # $a1 is the function parameter for the type of tetro
    # $t4 is the function parameter for the initial index of the tetro
    # $t5 is used to detect whether the tetro will hit the wall after pressing A
    la $t0, O_Tetro_Original
    beq $a1, $t0, respond_to_W_O_tetro
    la $t0, O_Tetro_R1
    beq $a1, $t0, respond_to_W_O_R1
    la $t0, O_Tetro_R2
    beq $a1, $t0, respond_to_W_O_R2
    la $t0, O_Tetro_R3
    beq $a1, $t0, respond_to_W_O_R3
    
    la $t0, I_Tetro_Original
    beq $a1, $t0, respond_to_W_I_tetro
    la $t0, I_Tetro_R1
    beq $a1, $t0, respond_to_W_I_R1
    la $t0, I_Tetro_R2
    beq $a1, $t0, respond_to_W_I_R2
    la $t0, I_Tetro_R3
    beq $a1, $t0, respond_to_W_I_R3
    
    la $t0, S_Tetro_Original
    beq $a1, $t0, respond_to_W_S_tetro
    la $t0, S_Tetro_R1
    beq $a1, $t0, respond_to_W_S_R1
    la $t0, S_Tetro_R2
    beq $a1, $t0, respond_to_W_S_R2
    la $t0, S_Tetro_R3
    beq $a1, $t0, respond_to_W_S_R3
    
    la $t0, L_Tetro_Original
    beq $a1, $t0, respond_to_W_L_tetro
    la $t0, L_Tetro_R1
    beq $a1, $t0, respond_to_W_L_R1
    la $t0, L_Tetro_R2
    beq $a1, $t0, respond_to_W_L_R2
    la $t0, L_Tetro_R3
    beq $a1, $t0, respond_to_W_L_R3
    
    la $t0, J_Tetro_Original
    beq $a1, $t0, respond_to_W_J_tetro
    la $t0, J_Tetro_R1
    beq $a1, $t0, respond_to_W_J_R1
    la $t0, J_Tetro_R2
    beq $a1, $t0, respond_to_W_J_R2
    la $t0, J_Tetro_R3
    beq $a1, $t0, respond_to_W_J_R3
    
    la $t0, Z_Tetro_Original
    beq $a1, $t0, respond_to_W_Z_tetro
    la $t0, Z_Tetro_R1
    beq $a1, $t0, respond_to_W_Z_R1
    la $t0, Z_Tetro_R2
    beq $a1, $t0, respond_to_W_Z_R2
    la $t0, Z_Tetro_R3
    beq $a1, $t0, respond_to_W_Z_R3
    
    la $t0, T_Tetro_Original
    beq $a1, $t0, respond_to_W_T_tetro
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_W_T_R1
    la $t0, T_Tetro_R2
    beq $a1, $t0, respond_to_W_T_R2
    la $t0, T_Tetro_R3
    beq $a1, $t0, respond_to_W_T_R3
    
respond_to_W_O_tetro:
    la $t2, O_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_O_R1:
    la $t2, O_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_O_R2:
    la $t2, O_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_O_R3:
    la $t2, O_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W

respond_to_W_I_tetro:
    la $t2, I_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 1040
    addi $a2, $zero, 1552
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_I_R1:
    la $t2, I_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1032
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_I_R2:
    la $t2, I_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 520
    addi $a2, $zero, 1544
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_I_R3:
    la $t2, I_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 512
    addi $a1, $zero, 528
    addi $a2, $zero, 536
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
    
respond_to_W_S_tetro:
    la $t2, S_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 528
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_S_R1:
    la $t2, S_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_S_R2:
    la $t2, S_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 528
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_S_R3:
    la $t2, S_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W

respond_to_W_Z_tetro:
    la $t2, Z_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 520
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_Z_R1:
    la $t2, Z_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 512
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_Z_R2:
    la $t2, Z_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 1024
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_Z_R3:
    la $t2, Z_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 536
    addi $a2, $zero, 528
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W

respond_to_W_J_tetro:
    la $t2, J_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 16
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_J_R1:
    la $t2, J_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 528
    addi $a1, $zero, 512
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_J_R2:
    la $t2, J_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 1032
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_J_R3:
    la $t2, J_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 536
    addi $a2, $zero, 528
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
    
respond_to_W_L_tetro:
    la $t2, L_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 8
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_L_R1:
    la $t2, L_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 512
    addi $a2, $zero, 528
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_L_R2:
    la $t2, L_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 16
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_L_R3:
    la $t2, L_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 512
    addi $a1, $zero, 520
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
    
respond_to_W_T_tetro:
    la $t2, T_Tetro_R1
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1032
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_T_R1:
    la $t2, T_Tetro_R2
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_T_R2:
    la $t2, T_Tetro_R3
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
respond_to_W_T_R3:
    la $t2, T_Tetro_Original
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 528
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_W
response_W:
    # Function parameters: $a0, detection parameter 1
    # Function parameters: $a1, detection parameter 2
    # Function parameters: $a2, detection parameter 3
    # Function parameters: $t0, color
    # Function parameters: $t1, detection parameter 4
    # Function parameters: $t2, tetro type
    # t2 (new shape) -> t0
    addi $a1, $a1, 0
    jal collision_detect
    
    addi $a1, $a0, 0
    jal collision_detect
    
    addi $a1, $a2, 0
    jal collision_detect
    
    addi $a1, $t1, 0
    jal collision_detect

    
    addi $a0, $t4, 0
    jal determine_grid_color_by_index
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    addi $a2, $t4, 0
    

    addi $sp, $sp, -4
    sw $t2, 0($sp)
    jal Pre_Restore
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    
    # $a0: initial address of tetro (shape of tetro)
    # $a1: color of tetro
    # $a2: initial address of the grid that we want to start with

    lw $t0, ADDR_DSPL    
    
    lw $a1, 0($sp)          # #a1: color
    addi $sp, $sp, 4
    
    lw $a0, 0($sp)
    addi $sp, $sp, 4        # Set $a0 as the shape of tetro  
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    jal Pre_Paint
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    b game_loop

respond_to_A:
    # $a1 is the function parameter for the type of tetro
    # $t4 is the function parameter for the initial index of the tetro
    # $t5 is used to detect whether the tetro will hit the wall after pressing A
    la $t0, O_Tetro_Original
    beq $a1, $t0, respond_to_A_O_tetro
    la $t0, O_Tetro_R1
    beq $a1, $t0, respond_to_A_O_R1
    la $t0, O_Tetro_R2
    beq $a1, $t0, respond_to_A_O_R2
    la $t0, O_Tetro_R3
    beq $a1, $t0, respond_to_A_O_R3
    
    la $t0, I_Tetro_Original
    beq $a1, $t0, respond_to_A_I_tetro
    la $t0, I_Tetro_R1
    beq $a1, $t0, respond_to_A_I_R1
    la $t0, I_Tetro_R2
    beq $a1, $t0, respond_to_A_I_R2
    la $t0, I_Tetro_R3
    beq $a1, $t0, respond_to_A_I_R3
    
    la $t0, S_Tetro_Original
    beq $a1, $t0, respond_to_A_S_tetro
    la $t0, S_Tetro_R1
    beq $a1, $t0, respond_to_A_S_R1
    la $t0, S_Tetro_R2
    beq $a1, $t0, respond_to_A_S_R2
    la $t0, S_Tetro_R3
    beq $a1, $t0, respond_to_A_S_R3
    
    la $t0, L_Tetro_Original
    beq $a1, $t0, respond_to_A_L_tetro
    la $t0, L_Tetro_R1
    beq $a1, $t0, respond_to_A_L_R1
    la $t0, L_Tetro_R2
    beq $a1, $t0, respond_to_A_L_R2
    la $t0, L_Tetro_R3
    beq $a1, $t0, respond_to_A_L_R3
    
    la $t0, J_Tetro_Original
    beq $a1, $t0, respond_to_A_J_tetro
    la $t0, J_Tetro_R1
    beq $a1, $t0, respond_to_A_J_R1
    la $t0, J_Tetro_R2
    beq $a1, $t0, respond_to_A_J_R2
    la $t0, J_Tetro_R3
    beq $a1, $t0, respond_to_A_J_R3
    
    la $t0, Z_Tetro_Original
    beq $a1, $t0, respond_to_A_Z_tetro
    la $t0, Z_Tetro_R1
    beq $a1, $t0, respond_to_A_Z_R1
    la $t0, Z_Tetro_R2
    beq $a1, $t0, respond_to_A_Z_R2
    la $t0, Z_Tetro_R3
    beq $a1, $t0, respond_to_A_Z_R3
    
    la $t0, T_Tetro_Original
    beq $a1, $t0, respond_to_A_T_tetro
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_A_T_R1
    la $t0, T_Tetro_R2
    beq $a1, $t0, respond_to_A_T_R2
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_A_T_R3

respond_to_A_O_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_O_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_O_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_O_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
    
respond_to_A_I_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 504
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_I_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 1032
    addi $a2, $zero, 520
    addi $t1, $zero, 1544
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_I_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1016
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_I_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1024
    addi $t1, $zero, 1536
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
    
respond_to_A_S_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_S_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 4
    addi $a2, $zero, 8
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_S_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_S_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A

respond_to_A_Z_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 520
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_Z_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 512
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_Z_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 504
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_Z_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 1016
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A

respond_to_A_J_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_J_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_J_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 504
    addi $a1, $zero, 0
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_J_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1016
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
    
respond_to_A_L_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 8
    addi $a1, $zero, 504
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_L_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_L_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 504
    addi $a1, $zero, 1016
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_L_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 520
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
    
respond_to_A_T_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_T_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 512
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_T_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 504
    addi $a1, $zero, 1024
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
respond_to_A_T_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_A
response_A:
    # Function parameters: $a0, detection parameter 1
    # Function parameters: $a1, detection parameter 2
    # Function parameters: $a2, detection parameter 3
    # Function parameters: $t0, color
    # Function parameters: $t1, detection parameter 4
    # Function parameters: $t2, tetro type

    addi $a1, $a1, 0
    jal collision_detect
    
    addi $a1, $a0, 0
    jal collision_detect
    
    addi $a1, $a2, 0
    jal collision_detect
    
    addi $a1, $t1, 0
    jal collision_detect
    
    
    addi $a0, $t4, 0
    jal determine_grid_color_by_index
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    jal Pre_Restore
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    
    subi $t4, $t4, 8
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    jal Pre_Paint
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    b game_loop
    
    
determine_grid_color_by_index:
    # $a0 is the index
    # this function will set $a1 as the color
    addi $t0, $zero, 1024
    lw $t1, GRID_INIT_ADD
    sub $t1, $a0, $t1
    div $t1, $t0
    mfhi $t0        # $t0 is the position inside a two-line
    addi $t1, $zero, 512
    bge $t0, $t1, grid_secondline_by_index         # goto grid_secondline_by_index if $t4 is on the second line
    addi $t1, $zero, 16
    div $t0, $t1
    mfhi $t0
    bge $t0, 8, grid_assign_midGREY_by_index
    j grid_assign_darkGREY_by_index
grid_secondline_by_index:
    addi $t1, $zero, 16
    div $t0, $t1
    mfhi $t0
    bge $t0, 8, grid_assign_darkGREY_by_index
    j grid_assign_midGREY_by_index
grid_assign_darkGREY_by_index:
    lw $a1, darkGREY
    jr $ra
grid_assign_midGREY_by_index:
    lw $a1, midGREY
    jr $ra
    
    
respond_to_S:
    # $a1 is the function parameter for the type of tetro
    # $t4 is the function parameter for the initial index of the tetro
    # $t5 is used to detect whether the tetro will hit the wall after pressing A
    la $t0, O_Tetro_Original
    beq $a1, $t0, respond_to_S_O_tetro
    la $t0, O_Tetro_R1
    beq $a1, $t0, respond_to_S_O_R1
    la $t0, O_Tetro_R2
    beq $a1, $t0, respond_to_S_O_R2
    la $t0, O_Tetro_R3
    beq $a1, $t0, respond_to_S_O_R3
    
    la $t0, I_Tetro_Original
    beq $a1, $t0, respond_to_S_I_tetro
    la $t0, I_Tetro_R1
    beq $a1, $t0, respond_to_S_I_R1
    la $t0, I_Tetro_R2
    beq $a1, $t0, respond_to_S_I_R2
    la $t0, I_Tetro_R3
    beq $a1, $t0, respond_to_S_I_R3
    
    la $t0, S_Tetro_Original
    beq $a1, $t0, respond_to_S_S_tetro
    la $t0, S_Tetro_R1
    beq $a1, $t0, respond_to_S_S_R1
    la $t0, S_Tetro_R2
    beq $a1, $t0, respond_to_S_S_R2
    la $t0, S_Tetro_R3
    beq $a1, $t0, respond_to_S_S_R3
    
    la $t0, Z_Tetro_Original
    beq $a1, $t0, respond_to_S_Z_tetro
    la $t0, Z_Tetro_R1
    beq $a1, $t0, respond_to_S_Z_R1
    la $t0, Z_Tetro_R2
    beq $a1, $t0, respond_to_S_Z_R2
    la $t0, Z_Tetro_R3
    beq $a1, $t0, respond_to_S_Z_R3
    
    la $t0, L_Tetro_Original
    beq $a1, $t0, respond_to_S_L_tetro
    la $t0, L_Tetro_R1
    beq $a1, $t0, respond_to_S_L_R1
    la $t0, L_Tetro_R2
    beq $a1, $t0, respond_to_S_L_R2
    la $t0, L_Tetro_R3
    beq $a1, $t0, respond_to_S_L_R3
    
    la $t0, J_Tetro_Original
    beq $a1, $t0, respond_to_S_J_tetro
    la $t0, J_Tetro_R1
    beq $a1, $t0, respond_to_S_J_R1
    la $t0, J_Tetro_R2
    beq $a1, $t0, respond_to_S_J_R2
    la $t0, J_Tetro_R3
    beq $a1, $t0, respond_to_S_J_R3
    
    la $t0, T_Tetro_Original
    beq $a1, $t0, respond_to_S_T_tetro
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_S_T_R1
    la $t0, T_Tetro_R2
    beq $a1, $t0, respond_to_S_T_R2
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_S_T_R3

respond_to_S_O_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW

    j response_S
respond_to_S_O_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW

    j response_S
respond_to_S_O_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW

    j response_S
respond_to_S_O_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW

    j response_S
    
respond_to_S_I_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1024
    addi $a2, $zero, 1040
    addi $t1, $zero, 1048
    lw $t0, CYAN

    j response_S
respond_to_S_I_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 2064
    addi $t1, $zero, 0
    lw $t0, CYAN

    j response_S
respond_to_S_I_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 1536
    addi $a2, $zero, 1552
    addi $t1, $zero, 1560
    lw $t0, CYAN

    j response_S
respond_to_S_I_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 2056
    addi $t1, $zero, 0
    lw $t0, CYAN

    j response_S
    
respond_to_S_S_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1032
    addi $a2, $zero, 528
    addi $t1, $zero, 0
    lw $t0, RED

    j response_S
respond_to_S_S_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 1032
    addi $t1, $zero, 1552
    lw $t0, RED

    j response_S
respond_to_S_S_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1024
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, RED

    j response_S
respond_to_S_S_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1552
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, RED

    j response_S

respond_to_S_Z_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 520
    addi $a1, $zero, 1040
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, GREEN

    j response_S
respond_to_S_Z_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, GREEN

    j response_S
respond_to_S_Z_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1552
    addi $a1, $zero, 1544
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, GREEN

    j response_S
respond_to_S_Z_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 4
    addi $a1, $zero, 504
    addi $a2, $zero, 1016
    addi $t1, $zero, 0
    lw $t0, GREEN

    j response_S

respond_to_S_J_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1032
    addi $a1, $zero, 1040
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, PINK

    j response_S
respond_to_S_J_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 528
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK

    j response_S
respond_to_S_J_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1032
    addi $a2, $zero, 1552
    addi $t1, $zero, 0
    lw $t0, PINK

    j response_S
respond_to_S_J_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 512
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK

    j response_S
    
respond_to_S_L_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1032
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, ORANGE

    j response_S
respond_to_S_L_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 1552
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE

    j response_S
respond_to_S_L_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1536
    addi $a1, $zero, 1032
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, ORANGE

    j response_S
respond_to_S_L_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 520
    addi $a1, $zero, 0
    addi $a2, $zero, 1552
    addi $t1, $zero, 0
    lw $t0, ORANGE

    j response_S
    
respond_to_S_T_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1032
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PURPLE
    j response_S
respond_to_S_T_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 1544
    addi $a1, $zero, 1040
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    j response_S
respond_to_S_T_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 1024
    addi $a1, $zero, 1544
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PURPLE
    j response_S
respond_to_S_T_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1544
    addi $a2, $zero, 1024
    addi $t1, $zero, 0
    lw $t0, PURPLE
    j response_S
    
response_S:
    # Function parameters: $a0, detection parameter 1
    # Function parameters: $a1, detection parameter 2
    # Function parameters: $a2, detection parameter 3
    # Function parameters: $t0, color
    # Function parameters: $t1, detection parameter 4
    # Function parameters: $t2, tetro type
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    addi $sp, $sp, -4
    sw $a1, 0($sp)
    addi $sp, $sp, -4
    sw $a2, 0($sp)
    addi $sp, $sp, -4
    sw $t1, 0($sp)
    addi $sp, $sp, -4
    sw $t0, 0($sp)          # t2 -> a0 -> a1 -> a2 -> t1 -> t0
    
    addi $a0, $a0, 0        
    jal bottom_collision_detect_for_S
    
    addi $a0, $a1, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $a2, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $t1, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $t4, 0
    jal determine_grid_color_by_index
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $t2, 0($sp)      # t2 -> a0 -> a1 -> a2 -> t1 -> t0 -> t2
    jal Pre_Restore
    lw $t2, 0($sp)
    addi $sp, $sp, 4        # t2 -> a0 -> a1 -> a2 -> t1 -> t0
    
    addi $t4, $t4, 512
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    
    lw $a1, 0($sp)
    addi $sp, $sp, 4        # t2 -> a0 -> a1 -> a2 -> t1
    addi $a2, $t4, 0
    
    jal Pre_Paint
    
    lw $t1, 0($sp)
    addi $sp, $sp, 4
    lw $a2, 0($sp)
    addi $sp, $sp, 4
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    addi $sp, $sp, 4        # t2   
    
    addi $a0, $a0, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $a1, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $a2, 0
    jal bottom_collision_detect_for_S
    
    addi $a0, $t1, 0
    jal bottom_collision_detect_for_S
    
    lw $a1, 0($sp)
    addi $sp, $sp, 4 
    
    b game_loop

respond_to_D:
    # $a1 is the function parameter for the type of tetro
    # $t4 is the function parameter for the initial index of the tetro
    # $t5 is used to detect whether the tetro will hit the wall after pressing A
    la $t0, O_Tetro_Original
    beq $a1, $t0, respond_to_D_O_tetro
    la $t0, O_Tetro_R1
    beq $a1, $t0, respond_to_D_O_R1
    la $t0, O_Tetro_R2
    beq $a1, $t0, respond_to_D_O_R2
    la $t0, O_Tetro_R3
    beq $a1, $t0, respond_to_D_O_R3
    
    la $t0, I_Tetro_Original
    beq $a1, $t0, respond_to_D_I_tetro
    la $t0, I_Tetro_R1
    beq $a1, $t0, respond_to_D_I_R1
    la $t0, I_Tetro_R2
    beq $a1, $t0, respond_to_D_I_R2
    la $t0, I_Tetro_R3
    beq $a1, $t0, respond_to_D_I_R3
    
    la $t0, S_Tetro_Original
    beq $a1, $t0, respond_to_D_S_tetro
    la $t0, S_Tetro_R1
    beq $a1, $t0, respond_to_D_S_R1
    la $t0, S_Tetro_R2
    beq $a1, $t0, respond_to_D_S_R2
    la $t0, S_Tetro_R3
    beq $a1, $t0, respond_to_D_S_R3
    
    la $t0, Z_Tetro_Original
    beq $a1, $t0, respond_to_D_Z_tetro
    la $t0, Z_Tetro_R1
    beq $a1, $t0, respond_to_D_Z_R1
    la $t0, Z_Tetro_R2
    beq $a1, $t0, respond_to_D_Z_R2
    la $t0, Z_Tetro_R3
    beq $a1, $t0, respond_to_D_Z_R3
    
    la $t0, L_Tetro_Original
    beq $a1, $t0, respond_to_D_L_tetro
    la $t0, L_Tetro_R1
    beq $a1, $t0, respond_to_D_L_R1
    la $t0, L_Tetro_R2
    beq $a1, $t0, respond_to_D_L_R2
    la $t0, L_Tetro_R3
    beq $a1, $t0, respond_to_D_L_R3
    
    la $t0, J_Tetro_Original
    beq $a1, $t0, respond_to_D_J_tetro
    la $t0, J_Tetro_R1
    beq $a1, $t0, respond_to_D_J_R1
    la $t0, J_Tetro_R2
    beq $a1, $t0, respond_to_D_J_R2
    la $t0, J_Tetro_R3
    beq $a1, $t0, respond_to_D_J_R3
    
    la $t0, T_Tetro_Original
    beq $a1, $t0, respond_to_D_T_tetro
    la $t0, T_Tetro_R1
    beq $a1, $t0, respond_to_D_T_R1
    la $t0, T_Tetro_R2
    beq $a1, $t0, respond_to_D_T_R2
    la $t0, T_Tetro_R3
    beq $a1, $t0, respond_to_D_T_R3

respond_to_D_O_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_O_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_O_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_O_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, YELLOW
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
    
respond_to_D_I_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 544
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_I_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 1048
    addi $t1, $zero, 1560
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_I_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 0
    addi $a2, $zero, 0
    addi $t1, $zero, 1056
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_I_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 528
    addi $a2, $zero, 1040
    addi $t1, $zero, 1552
    lw $t0, CYAN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
    
respond_to_D_S_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 528
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_S_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 1048
    addi $a2, $zero, 16
    addi $t1, $zero, 536
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_S_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 528
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_S_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 536
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, RED
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D

respond_to_D_Z_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 544
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_Z_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_Z_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 0
    addi $a1, $zero, 528
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_Z_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 528
    addi $a2, $zero, 1032
    addi $t1, $zero, 0
    lw $t0, GREEN
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D

respond_to_D_J_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 544
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_J_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 528
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_J_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 536
    addi $a1, $zero, 1048
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_J_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 528
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PINK
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
    
respond_to_D_L_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_L_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 528
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_L_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 536
    addi $a1, $zero, 1032
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_L_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 24
    addi $a1, $zero, 536
    addi $a2, $zero, 1048
    addi $t1, $zero, 0
    lw $t0, ORANGE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
    
respond_to_D_T_tetro:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 536
    addi $a2, $zero, 0
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_T_R1:
    addi $t2, $a1, 0
    addi $a0, $zero, 16
    addi $a1, $zero, 536
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_T_R2:
    addi $t2, $a1, 0
    addi $a0, $zero, 536
    addi $a1, $zero, 0
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
respond_to_D_T_R3:
    addi $t2, $a1, 0
    addi $a0, $zero, 528
    addi $a1, $zero, 16
    addi $a2, $zero, 1040
    addi $t1, $zero, 0
    lw $t0, PURPLE
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    j response_D
    
response_D:
    # Function parameters: $a0, detection parameter 1
    # Function parameters: $a1, detection parameter 2
    # Function parameters: $a2, detection parameter 3
    # Function parameters: $t0, color
    # Function parameters: $t1, detection parameter 4
    # Function parameters: $t2, tetro type

    addi $a1, $a1, 0
    jal collision_detect
    
    addi $a1, $a0, 0
    jal collision_detect
    
    addi $a1, $a2, 0
    jal collision_detect
    
    addi $a1, $t1, 0
    jal collision_detect
    
    addi $a0, $t4, 0
    jal determine_grid_color_by_index
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    jal Pre_Restore
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    
    addi $t4, $t4, 8
    lw $t0, ADDR_DSPL
    addi $a0, $t2, 0
    
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    addi $a2, $t4, 0
    
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    jal Pre_Paint
    lw $a1, 0($sp)
    addi $sp, $sp, 4
    b game_loop

bottom_collision_detect_for_S:
    beq $a0, $zero, bottom_collision_zero
    add $t5, $t4, $a0
    lw $t6, 0($t5)
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal bottom_collision_detect
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
bottom_collision_zero:
    jr $ra
collision_detect:
    beq $a1, $zero, collision_zero
    add $t5, $t4, $a1
    lw $t6, 0($t5)
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal collision_detect_helper
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
collision_zero:
    jr $ra
collision_detected:
    addi $a1, $t2, 0
    b game_loop
collision_detect_helper:
    # $t6: pixel being detected
    lw $t7, lightGREY
    beq $t6, $t7, collision_detected
    lw $t7, RED
    beq $t6, $t7, collision_detected
    lw $t7, ORANGE
    beq $t6, $t7, collision_detected
    lw $t7, PURPLE
    beq $t6, $t7, collision_detected
    lw $t7, YELLOW
    beq $t6, $t7, collision_detected
    lw $t7, CYAN
    beq $t6, $t7, collision_detected
    lw $t7, GREEN
    beq $t6, $t7, collision_detected
    lw $t7, PINK
    beq $t6, $t7, collision_detected
    jr $ra

bottom_collision_detect:
    # $t6: pixel being detected
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    lw $t7, lightGREY
    beq $t6, $t7, generate_new_tetro
    lw $t7, RED
    beq $t6, $t7, generate_new_tetro
    lw $t7, ORANGE
    beq $t6, $t7, generate_new_tetro
    lw $t7, PURPLE
    beq $t6, $t7, generate_new_tetro
    lw $t7, YELLOW
    beq $t6, $t7, generate_new_tetro
    lw $t7, CYAN
    beq $t6, $t7, generate_new_tetro
    lw $t7, GREEN
    beq $t6, $t7, generate_new_tetro
    lw $t7, PINK
    beq $t6, $t7, generate_new_tetro
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

pre_full_row_detect:
    lw $t0, GRID_INIT_ADD
    addi $t1, $zero, 0      # row iterator
    addi $t3, $zero, 0     # column iterator
    addi $t2, $t0, 0        # grid iterator
full_row_detect:
    lw $t5, darkGREY
    lw $t6, midGREY
    lw $a0, 0($t2)          # $a0: the color on the iterator grid
    beq $t5, $a0, not_full_detected
    beq $t6, $a0, not_full_detected     # break the loop if the grid is dark/midGREY
    addi $t2, $t2, 8
    addi $t3, $t3, 1
    beq $t3, 16, full_row_detected
    j full_row_detect

not_full_detected:
    addi $t2, $zero, 512
    addi $t1, $t1, 1
    mult $t2, $t1       # 512 * i
    mflo $t2
    add $t2, $t0, $t2        # $t2 = $t0 + 512 * i
    addi $t3, $zero, 0     # reset column iterator
    beq $t1, 24, row_detect_complete
    j full_row_detect
row_detect_complete:
    addi $t9, $t9, 1
    jr $ra
full_row_detected:
    # Restore the full row
    addi $t2, $zero, 512
    mult $t2, $t1       # 512 * i
    mflo $t2
    add $t2, $t0, $t2        # $t2 = $t0 + 512 * i
    addi $t3, $zero, 0      # reset column iterator
    j restore_row
restore_row:
    addi $a0, $t2, 0        # set $a0 as the square to be examined
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    addi $sp, $sp, -4
    sw $t1, 0($sp)
    addi $sp, $sp, -4
    sw $t2, 0($sp)

    jal determine_grid_color_by_index
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    sw $a1, 0($t2)
    sw $a1, 4($t2)
    sw $a1, 256($t2)
    sw $a1, 260($t2)
    addi $t3, $t3, 1
    addi $t2, $t2, 8
    beq $t3, 16, not_full_detected
    j restore_row
    
generate_new_tetro:
    jal pre_full_row_detect
    # generate_X function sets $a0 as the address of X
    li $v0, 42   
    li $a0, 0
    li $a1, 7    
    syscall            
    move $t1, $a0
    lw $t0, ADDR_DSPL
    beq $t1, 0, generate_O
    beq $t1, 1, generate_I
    beq $t1, 2, generate_S
    beq $t1, 3, generate_Z
    beq $t1, 4, generate_L
    beq $t1, 5, generate_J
    beq $t1, 6, generate_T
generate_O:
    la $a0, O_Tetro_Original
    lw $a1, YELLOW
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, O_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_I:
    la $a0, I_Tetro_Original
    lw $a1, CYAN
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, I_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_S:
    la $a0, S_Tetro_Original
    lw $a1, RED
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, S_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_Z:
    la $a0, Z_Tetro_Original
    lw $a1, GREEN
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
   
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, Z_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_L:
    la $a0, L_Tetro_Original
    lw $a1, ORANGE
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, L_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_J:
    la $a0, J_Tetro_Original
    lw $a1, PINK
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, J_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop
generate_T:
    la $a0, T_Tetro_Original
    lw $a1, PURPLE
    addi $a2, $t0, 10940
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pre_clear_panel
    jal Pre_Paint
    
    lw $t0, ADDR_DSPL
    addi $a2, $t0, 3396
    addi $t4, $a2, 0        # Reset $t4
    jal Pre_Paint
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    la $a1, T_Tetro_Original
    lw $t0, ADDR_DSPL
    addi $t4, $t0, 3396
    j game_loop

respond_to_Q:
	li $v0, 10                      # Quit gracefully
	syscall



