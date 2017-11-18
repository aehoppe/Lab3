# Test bench function for Lab3 reduced MIPS ISA
# $s7 = ('tests failed') ? 1 : 0
nop
addi $gp, $zero, 0x2000

main: # Run all tests conditionally

jal test_lw_sw
bne $s7, $zero, test_end

jal test_bne
bne $s7, $zero, test_end

jal test_xori
bne $s7, $zero, test_end

jal test_add
bne $s7, $zero, test_end

jal test_sub
bne $s7, $zero, test_end

jal test_slt
bne $s7, $zero, test_end

j test_end


test_lw_sw:
# Initialize values
addi $t0, $zero, 30
addi $t1, $zero, 87
addi $t2, $zero, 4
# store to heap
sw $t0, 16($gp)
sw $t1, 12($gp)
sw $t2, 8($gp)
# load from heap
lw $t3, 16($gp)
lw $t4, 12($gp)
lw $t5, 8($gp)
# compare equality
bne $t0, $t3, lw_sw_fail
bne $t1, $t4, lw_sw_fail
bne $t2, $t5, lw_sw_fail
jr $ra

lw_sw_fail:
addi $s7, $zero, 1 #set testfailed to true
jr $ra

test_bne:
# initialize values
addi $t0, $zero, 40
addi $t1, $zero, 16
addi $t2, $zero, 40

bne $t0, $t2, bne_fail
bne $t0, $t1, bne_pass
bne_fail:
addi $s7, $zero, 1
bne_pass:
jr $ra

test_xori:
#initialize values
addi $t0, $zero, 0xf0
addi $t1, $zero, 0x0f

# xor identical things
xori $t2, $t0, 0xf0
# fail if not zero
bne $t2, $zero, xori_fail
# xor different things
xori $t2, $t1, 0xf0
# pass if zero
bne $t2, $zero, xori_pass
xori_fail:
addi $s7, $zero, 1
xori_pass:
jr $ra

test_add:
# initialize values
addi $t0, $zero, 13
addi $t1, $zero, 31
addi $t2, $zero, 44

# add registers
add $t3, $t0, $t1
# fail if not expected result
bne $t3, $t2, add_fail
# otherwise pass
j add_pass

add_fail:
addi $s7, $zero, 1
add_pass:
jr $ra


test_sub:
# initialize values
addi $t0, $zero, 31
addi $t1, $zero, 13
addi $t2, $zero, 18

# subtract registers
sub $t3, $t0, $t1
# fail if not expected result
bne $t3, $t2, sub_fail
# otherwise pass
j sub_pass

sub_fail:
addi $s7, $zero, 1
sub_pass:
jr $ra

test_slt:
# initialize values
addi $t0, $zero, 13
addi $t1, $zero, 15

# 13 is less than 15
slt $t2, $t0, $t1
bne $t2, 1, slt_fail

# 15 is not less than 13
slt $t2, $t1, $t0
bne $t2, 0, slt_fail
j slt_pass

slt_fail:
addi $s7, $zero, 1
slt_pass:
jr $ra


# End the program
test_end:
add $a0, $s7, $zero
addi $v0, $zero, 1
syscall
j jump_trap

jump_trap:
nop
nop
nop
j jump_trap
