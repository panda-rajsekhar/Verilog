# Verilog Basics 

This is a simple guide to the building blocks of Verilog: **data types**, **keywords**, **identifiers**, and **operators**.

---

## 1. Data Types

Verilog has two main groups: **nets** (carry signals) and **variables** (store values).

### 1.1 Net Types

Nets act like wires. They don't store a value - they just show whatever is being pushed onto them.

| Type | Simple Meaning |
|------|-----------------|
| `wire` | A basic wire. Carries a signal. Most commonly used net. |
| `tri` | Same as `wire`. Used when many things might drive it. |
| `wand` | If many things drive it, combine them with AND. |
| `wor` | If many things drive it, combine them with OR. |
| `triand` | Tri-state version of `wand`. |
| `trior` | Tri-state version of `wor`. |
| `trireg` | Remembers its last value even when nothing is driving it. |
| `tri0` | Falls back to `0` when nothing drives it. |
| `tri1` | Falls back to `1` when nothing drives it. |
| `supply0` | Always `0` (like a ground wire). |
| `supply1` | Always `1` (like a power wire). |

### 1.2 Variable Types

Variables store a value and keep it until something changes it.

| Type | Simple Meaning |
|------|-----------------|
| `reg` | Stores a value. Set inside `initial` or `always` blocks. Can be 1 bit or many bits (e.g. `reg [7:0] data;`). |
| `integer` | A whole number, 32 bits, can be negative. Good for loop counters. |
| `real` | A decimal (floating-point) number. Only for simulation, not real hardware. |
| `time` | Stores a simulation time value (64-bit). |
| `realtime` | Same as `time`, but as a decimal number. |
| `logic` *(SystemVerilog)* | A newer type that works like both `wire` and `reg` combined. Easier to use, fewer rules. |

### 1.3 Wire vs Reg - Quick Comparison

| | `wire` | `reg` |
|---|--------|-------|
| Who sets the value? | `assign` statement | `initial` / `always` block |
| Stores the value? | No, just reflects driver | Yes, keeps it until changed |
| Default value | `z` (floating) | `x` (unknown) |
| Multiple drivers? | Allowed (with rules) | Only one source should drive it |

---

## 2. Identifiers

An **identifier** is just a *name* - the name you give to a wire, register, module, or variable.

### Rules for Naming (Simple)
- Can use letters (`a-z`, `A-Z`), numbers (`0-9`), underscore `_`, and dollar sign `$`.
- Must **start** with a letter or underscore - never a number.
- Verilog is **case-sensitive** - `Data` and `data` are two different names.
- Cannot be a reserved **keyword** (see below), like `wire` or `always`.

**Good examples:** `clk`, `data_in`, `Reg1`, `_temp`, `count$`

**Bad examples:** `1data` (starts with a number), `wire` (reserved word)

### Escaped Identifiers
If you really need special characters or a name starting with a number, you can escape it with a backslash:
```verilog
\2bit_signal
```

---

## 3. Keywords

Keywords are **reserved words** that already have a special meaning in Verilog. You can't use them as your own variable names.

### 3.1 Module & Structure Keywords

| Keyword | Simple Meaning |
|---------|-----------------|
| `module` | Starts a hardware block/design. |
| `endmodule` | Ends a module. |
| `input` | Marks a signal coming into a module. |
| `output` | Marks a signal going out of a module. |
| `inout` | A signal that can go both in and out. |
| `parameter` | A constant value you can set for a module. |

### 3.2 Data-Type Keywords

`wire`, `reg`, `tri`, `wand`, `wor`, `trireg`, `integer`, `real`, `time`, `realtime`, `supply0`, `supply1`

### 3.3 Procedural Keywords

| Keyword | Simple Meaning |
|---------|-----------------|
| `initial` | A block that runs **once**, at the start (used in testbenches). |
| `always` | A block that runs **repeatedly**, whenever something changes. |
| `begin` / `end` | Group several lines together, like `{ }` in other languages. |
| `if` / `else` | Basic decision-making. |
| `case` / `endcase` | Choose between many options, like a switch statement. |
| `for` | A loop that repeats a set number of times. |
| `while` | A loop that repeats while a condition is true. |
| `assign` | Continuously drives a value onto a `wire`. |
| `posedge` | Triggers on a signal's rising edge (0 → 1). |
| `negedge` | Triggers on a signal's falling edge (1 → 0). |

### 3.4 Simulation & Debug Keywords (System Tasks)

| Keyword | Simple Meaning |
|---------|-----------------|
| `$display` | Prints text/values to the console. |
| `$monitor` | Prints values automatically whenever they change. |
| `$dumpfile` | Sets the name of the waveform file. |
| `$dumpvars` | Chooses which signals to record for the waveform. |
| `$finish` | Ends the simulation. |
| `$time` | Gives the current simulation time. |

### 3.5 Other Common Keywords

`function`, `endfunction`, `task`, `endtask`, `generate`, `endgenerate`, `defparam`, `specify`, `endspecify`, `fork`, `join`

---

## 4. Operators

Operators are symbols used to **do actions** on values - like math, comparisons, or logic.

### 4.1 Arithmetic Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `+` | Add | `a + b` |
| `-` | Subtract | `a - b` |
| `*` | Multiply | `a * b` |
| `/` | Divide | `a / b` |
| `%` | Remainder (modulus) | `a % b` |
| `**` | Power (exponent) | `a ** b` |

### 4.2 Relational Operators (Comparisons)

Result is always `1` (true) or `0` (false).

| Operator | Meaning | Example |
|----------|---------|---------|
| `>` | Greater than | `a > b` |
| `<` | Less than | `a < b` |
| `>=` | Greater than or equal | `a >= b` |
| `<=` | Less than or equal | `a <= b` |
| `==` | Equal to | `a == b` |
| `!=` | Not equal to | `a != b` |
| `===` | Exact equal (checks `x`/`z` too) | `a === b` |
| `!==` | Exact not equal | `a !== b` |

### 4.3 Logical Operators

Treat the whole value as **true** (nonzero) or **false** (zero). Always give a 1-bit result.

| Operator | Meaning | Example |
|----------|---------|---------|
| `&&` | Logical AND | `a && b` |
| `\|\|` | Logical OR | `a \|\| b` |
| `!` | Logical NOT | `!a` |

### 4.4 Bitwise Operators

Work on values **bit by bit**. Result has the same width as the inputs.

| Operator | Meaning | Example |
|----------|---------|---------|
| `&` | Bitwise AND | `a & b` |
| `\|` | Bitwise OR | `a \| b` |
| `^` | Bitwise XOR | `a ^ b` |
| `~` | Bitwise NOT (invert) | `~a` |
| `^~` or `~^` | Bitwise XNOR | `a ^~ b` |

### 4.5 Reduction Operators

Take **one multi-bit value** and squash it down to a **single bit** by applying the operator across all its bits.

| Operator | Meaning | Example |
|----------|---------|---------|
| `&` | AND all bits together | `&a` |
| `\|` | OR all bits together | `\|a` |
| `^` | XOR all bits together | `^a` |
| `~&` | NAND all bits together | `~&a` |
| `~\|` | NOR all bits together | `~\|a` |
| `~^` / `^~` | XNOR all bits together | `~^a` |

### 4.6 Shift Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `<<` | Shift bits left | `a << 2` |
| `>>` | Shift bits right | `a >> 2` |
| `<<<` | Arithmetic shift left | `a <<< 2` |
| `>>>` | Arithmetic shift right (keeps sign) | `a >>> 2` |

### 4.7 Concatenation & Replication

| Operator | Meaning | Example |
|----------|---------|---------|
| `{ }` | Join values together | `{a, b}` joins `a` and `b` |
| `{n{...}}` | Repeat a value `n` times | `{4{a}}` repeats `a` four times |

### 4.8 Conditional (Ternary) Operator

| Operator | Meaning | Example |
|----------|---------|---------|
| `? :` | If-else in one line | `y = (a > b) ? a : b;` → picks `a` if true, else `b` |

---

## 5. Quick Summary Table

| Category | Examples |
|----------|----------|
| Net types | `wire`, `tri`, `wand`, `wor`, `trireg` |
| Variable types | `reg`, `integer`, `real`, `time` |
| Structure keywords | `module`, `input`, `output`, `parameter` |
| Procedural keywords | `initial`, `always`, `if`, `case`, `for` |
| Debug keywords | `$display`, `$monitor`, `$finish` |
| Arithmetic operators | `+ - * / % **` |
| Relational operators | `> < >= <= == !=` |
| Logical operators | `&& \|\| !` |
| Bitwise operators | `& \| ^ ~` |
| Shift operators | `<< >> <<< >>>` |
| Special operators | `{ }` (concatenation), `? :` (ternary) |

---

*Tip: `&&` `\|\|` `!` (logical) work on the whole value as true/false. `&` `\|` `~` (bitwise) work on each bit separately. This is the most common mix-up for beginners.*