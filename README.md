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


# Tips for those trying to write Assembly Codes for simple retro-games. 
- Use GitHub repositories only as reference. Don't copy them directly. The code you copied may be wrong at some places, and debugging another person's code is always hard. 
- It is hard to understand assembly codes. In case you are writing assembly, don't rely on GitHub assembly codes or ChatGPT.
    a) If you find some proper assembly code, try to understand each function. You can use AI for that.
    b)**If that is not found, find a code in C or C++ and try to reverse engineer the logic.**
- If you are also building a custom processor to run on an FPGA, then **Write the assembly code first, then decide on which opcodes you require.** We did the mistake of making the CPU first and figuring out how to go ahead next. There were so many unneccessary opcodes that it was easier to write code for a new CPU with reduced opcodes. 