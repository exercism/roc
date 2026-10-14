# Instructions Append

## Operator syntax

The arithmetic functions support regular function calls, static dispatch (i.e., method call syntax), and operators:

| Function call | Method call | Operator |
| --- | --- | --- |
| `plus(r1, r2)` | `r1.plus(r2)` | `r1 + r2` |
| `minus(r1, r2)` | `r1.minus(r2)` | `r1 - r2` |
| `times(r1, r2)` | `r1.times(r2)` | `r1 * r2` |
| `div_by(r1, r2)` | `r1.div_by(r2)` | `r1 / r2` |

Implement `reduce` to reduce a rational number to its lowest terms, for example from `6 / 8` to `3 / 4`.
