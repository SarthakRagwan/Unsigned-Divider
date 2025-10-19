# Unsigned-Divider
Parameterized unsigned divider in Verilog using restoring division algorithm, producing both quotient and remainder with full testbench support.

Author; Sarthak Kumar

##  Overview
This project implements a **parameterized unsigned binary divider** in Verilog.  
It performs integer division of an M-bit **dividend (`A`)** by an N-bit **divisor (`B`)**, generating both **quotient (`Q`)** and **remainder (`R`)**.  
The design is based on the **Restoring Division Algorithm**, a simple yet powerful hardware division technique.

---

##  Module: `divider.v`

### 🔧 Parameters
- `M` → Width of the dividend (default = 3)  
- `N` → Width of the divisor (default = 2)

###  I/O Ports
| Signal | Direction | Width | Description |
|:--------|:-----------|:--------|:-------------|
| `A` | Input | M bits | Unsigned dividend |
| `B` | Input | N bits | Unsigned divisor |
| `Q` | Output | (M–N+1) bits | Unsigned quotient |
| `R` | Internal | N bits | Unsigned remainder |

---

##  Theory – Restoring Division Algorithm

The **restoring division** method mimics manual long division in binary form.  
It processes each bit of the dividend from **MSB to LSB**, performing **subtract–restore** operations.

###  Step-by-Step Working
1. Initialize partial remainder (`sub`) with the `N` MSBs of `A`.  
2. For each bit:
   - Compare `sub` with `B`.  
   - If `sub ≥ B`:  
     - Subtract `B` from `sub`.  
     - Set quotient bit = `1`.  
   - Else:  
     - Restore `sub` (no subtraction).  
     - Set quotient bit = `0`.  
   - Bring down the next bit of `A` into `sub`.  
3. After all iterations, `sub` becomes the **remainder (`R`)** and the built bits form the **quotient (`Q`)**.

---

##  Example

Divide `A = 13 (1101)` by `B = 3 (11)`:

| Step | Partial Remainder (`sub`) | Compare | Quotient Bit | Action |
|:------|:--------------------------|:---------|:--------------|:--------|
| 1 | 11 (from A) | ≥ B | 1 | `sub = 00` |
| 2 | 00 + next bit (0) | < B | 0 | restore |
| 3 | 00 + next bit (1) | < B | 0 | restore |
| 4 | 01 + next bit (1) | < B | 0 | restore |

**Result:**  
- Quotient = `0100 (4)`  
- Remainder = `01 (1)`  
- Therefore, `13 ÷ 3 = 4 R1`

---

**Schematic**

<img width="1813" height="532" alt="divider" src="https://github.com/user-attachments/assets/cb083433-6c97-42bc-9f7f-9a1915852d34" />

##  Example Run Output
 0  |  A = 6  |  B = 2  |  Q = 3  |  R = 0
 
 5  |  A = 7  |  B = 2  |  Q = 3  |  R = 1
 
 10 |  A = 5  |  B = 3  |  Q = 1  |  R = 2
 

**Features**

- Fully parameterized for flexible bit-widths

- Implements Restoring Division Algorithm

- Produces both quotient and remainder

- Simple, educational, and FPGA-friendly design



