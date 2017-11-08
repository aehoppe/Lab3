# Single cycle MIPS RISC RTL

## Instructions:
`LW`, `SW`, `J`, `JR`, `JAL`, `BNE`, `XORI`, `ADDI`, `ADD`, `SUB`, `SLT`

## RTL

### `LW`
I-type
Load Word - 23
```
R[rt] = M[R[rs]+SignExtImm]
```

### `SW`
I-type
Store Word - 43
```
M[R[rs]+SignExtImm] = R[rt]
```

### `J`
J-type
Jump - 2
```
PC=JumpAddr
```

### `JR`
R-type Funct 8
Jump Register - 0
```
PC=R[rs]
```

### `JAL`
J-type
Jump and Link - 3
```
R[31] = PC+8;
PC = JumpAddr
```

### `BNE`
I-type
Branch On Not Equal - 5
```
if(R[rs]!=R[rt])
  PC=PC+4+BranchAddr
```

### `XORI`
I-type
Xor immediate - 14
```
R[rt] = R[rs] ^ ZeroExtImm
```

### `ADDI`
I-type
Add Immediate - 8
```
R[rt] = R[rs] + SignExtImm
```

### `ADD`
R-Type Funct 8
Add - 0
```
R[rd] = R[rs] + R[rt]
```

### `SUB`
R-type Funct 22
Subtract - 0
```
R[rd] = R[rs] - R[rt]
```

### `SLT`
R-type Funct 42
Set Less Than - 0
```
R[rd] = (R[rs] < R[rt]) ? 1 : 0
```
