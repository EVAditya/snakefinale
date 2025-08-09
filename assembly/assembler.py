import re

OPCODES = {
    "ADD": 0b0000,
    "SUB": 0b0001,
    "ADDI": 0b0010,
    "ROW": 0b0011,
    "COL": 0b0100,
    "INCL": 0b0101,
    "F": 0b0110,
    "LD": 0b1000,
    "LDI": 0b1001,
    "ST": 0b1010,
    "JE": 0b1100,
    "JNE": 0b1101,
    "J": 0b1110,
    "LFSR": 0b1111
}

CONSTANTS = {
    "UP": 1,
    "DOWN": 2,
    "LEFT": 3,
    "RIGHT": 0,
    "MEM_INP": 255,
    "MEM_LENGTH": 73,
    "MEM_OLDINP": 74
}

REGISTERS = {f"R{i}": i for i in range(16)}
REGISTERS.update({"LENGTH": 8, "HEAD": 9, "FRUIT": 10, "INPUT": 11, "OLD_INP": 12})


def assemble_line(line, labels, current_addr, first_pass=False):
    # Remove comments
    line = line.split("//")[0].split(";")[0].strip()
    if not line:
        return None

    # Check for label (supports `label:` or `label: instr ...`)
    while ":" in line:
        label, rest = line.split(":", 1)
        label = label.strip()
        if first_pass:
            labels[label.upper()] = current_addr
        line = rest.strip()
        if not line:
            return None  # Label only, no instruction on this line

    # If after removing label, no instruction remains
    if not line:
        return None

    tokens = re.split(r"[,\s]+", line.strip().upper())
    instr = tokens[0]
    args = tokens[1:]
    return instr, args


def parse_operand(operand, labels=None):
    operand = operand.strip().upper()
    if operand in REGISTERS:
        return REGISTERS[operand], "reg"
    if operand in CONSTANTS:
        return CONSTANTS[operand], "imm"
    if operand.startswith("0x"):  # hex literal
        return int(operand, 16), "imm"
    if operand.isdigit():
        return int(operand), "imm"
    raise ValueError(f"Unknown operand: {operand}")

def assemble_line2(line, labels, current_addr):
    # Remove comments
    line = line.split("//")[0].split(";")[0].strip()
    if not line:
        return None

    # Label definition
    if ":" in line and not line.upper().startswith(("LDI","LD","ST","ADD","SUB","ADDI","ROW","COL","INCL","F","JE","JNE","J","LFSR")):
        label = line.replace(":", "").strip()
        labels[label] = current_addr
        return None

    tokens = re.split(r"[,\s]+", line.strip().upper())
    instr = tokens[0]
    args = tokens[1:]

    return instr, args

def encode_instruction(instr, args, labels):
    opcode = OPCODES[instr]
    if instr in ("ADD", "SUB", "ROW", "COL", "INCL", "F"):
        ra, _ = parse_operand(args[0])
        rb, _ = parse_operand(args[1])
        return (opcode << 12) | (ra << 8) | (rb << 4)

    elif instr in ("ADDI", "LDI", "LD", "ST"):
        ra, _ = parse_operand(args[0])
        imm, _ = parse_operand(args[1])
        return (opcode << 12) | (ra << 8) | (imm & 0xFF)
    
    elif instr in ("JE", "JNE", "J"):
        if args[0] in labels:
            addr = labels[args[0]]
        else:
            addr, _ = parse_operand(args[0])
        return (opcode << 12) | (0 << 8) | (addr & 0xFF)
    elif instr in ("LFSR",):
        ra, _ = parse_operand(args[0])
        return (opcode << 12) | (ra << 8) | (0x00)

def assemble(program):
    lines = program.strip().splitlines()
    labels = {}
    machine_code = []
    addr = 0

    # First pass: find labels
    for line in lines:
        parsed = assemble_line(line, labels, addr, first_pass=True)
        if parsed:
            addr += 1

    # Second pass: assemble
    for line in lines:
        parsed = assemble_line(line, labels, None, first_pass=False)
        if parsed:
            instr, args = parsed
            code = encode_instruction(instr, args, labels)
            machine_code.append(code)

    return machine_code

# Example usage:

def read_file_to_string(filename):
    try:
        with open(filename, 'r') as file:
            file_contents = file.read()
        return file_contents
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.")
        return ""
    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
        return ""


assembly_code = """
led :

ldi r8, 1
st r8, MEM_LENGTH
lfsr fruit
f r10, r9
jne led
"""

machine = assemble(assembly_code)
for code in machine:
    print(f"{code:04X}")
