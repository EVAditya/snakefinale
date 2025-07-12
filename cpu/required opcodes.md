# ALU
add a,b
sub a,b
addi a,imm (imm is 8b)
subi b,imm (imm is 8b)
row a,b ; row of the coord (b) stored in a
col a,b ; col of the coord
incl a,b ; a|=(1<<b) (preferably custom hardware must be designed) decoder and or gates


# LFSR
lfsr FRUIT; new fruit in r10 (FRUIT)

# Load and store
ld a, addr_reg
ldi a, imm_addr
st a, addr_reg

# Branch
f a,b
je addr
jne addr
j addr

# NOP
nop



