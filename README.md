# Custom Processor for Snake Game


This is an 8-bit processor built solely for snake game.
The game works only on an 8 by 8 LED matrix.
Has only the opcodes required for the game.


# Explanation about CPU

CPU is a 2 bus architecutre.
The data bus is 8 bits.
The instruction bus is 16 bits.
Due to the common bus Architecture, it takes multiple clock cycles for a single instruction.
The maximum number of cycles is taken by ALU (6 cycles).    


# Explanation of the Assembly code

Coordinates are stored in a byte this way
| 0 (3 bytes for ROW) | 0 (3 bytes for Column) |

In the Data Memory, I have allorted an array of 64 bytes to store the coordiates of Snake Body.