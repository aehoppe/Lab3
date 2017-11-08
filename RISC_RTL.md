# Single cycle MIPS RISC RTL

## Instructions:
`lw`, `sw`, `j`, `jr`, `jal`, `bne`, `xori`, `addi`, `add`, `sub`, `slt`

## RTL

### `lw`
I-type
Load Word - 23
```
R[rt] = M[R[rs]+SignExtImm]
```
### `sw`
I-type
Store Word - 43
```
M[R[rs]+SignExtImm] = R[rt]
```

### `j`
J-type
Jump - 2
```
PC=JumpAdd
```

### `jr`
R-type Funct 8
Jump Register - 0
```
PC=R[rs]
```

### `jal`
J-type
Jump and Link - 3
```
R[31] = PC+8;
PC = JumpAddr
```
### `bne`

### `xori`

### `addi`

### `add`

### `sub`
R-type Funct 22
Subtract - 0
```
R[rd] = R[rs] - R[rt]
```

### `slt`
R-type Funct 42
Set Less Than - 0
```
R    R[rd] = (R[rs] < R[rt]) ? 1 : 0
```
