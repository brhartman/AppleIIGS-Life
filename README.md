# Conway's Game of Life for the Apple IIGS

This is an implementation of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) written in 65c816 assembly for the Apple IIGS.

# Cross Platform Development Tools

- [Merlin 32](https://www.brutaldeluxe.fr/products/crossdevtools/merlin/index.html) - 65c816 assembler and linker from Brutal Deluxe
- [Cadius](https://www.brutaldeluxe.fr/products/crossdevtools/cadius/index.html) - Apple II disk image utility from Brutal Deluxe ([Linux port](https://github.com/mach-kernel/cadius))
- [KEGS](http://kegs.sourceforge.net/) - Apple IIGS emulator

# Development Environment

All development is done in Linux.  [Visual Studio Code](https://code.visualstudio.com/) is used for code editing and [GNU Make](https://www.gnu.org/software/make/) is used to build and run the project.  The tool chain consists of assembling and linking the source code with Merlin 32, creating an Apple II disk image with Cadius, and executing the program with KEGS.

# Implementation Notes

## Screen Updating

The Apple IIGS is not fast enough to write to every pixel on the screen in a single vertical refresh.  To reduce the time taken to update the screen and minimize tearing, a version of [PEI Slamming](https://www.kansasfest.org/wp-content/uploads/2004-sheppy-wolf3d.pdf) is used.  This technique uses memory shadowing, relocation of the stack and direct page pointers, and pushing words between the two in as few cycles as possible to copy memory to the screen.

This implementation is a bit weird in that at start up, the code copies a portion of itself to a different memory bank and updates the associated memory addresses.  This is to avoid issues with memory locations during the PEI slam.  There might be some sort of code relocation technique for doing this that would be better here or some way to avoid the issue altogether

## Random Numbers

Pseudorandom numbers are generated using a [16-bit xorshift](http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html).  This seems like a good balance between speed and pseudorandomness.

## Memory Management

Memory for the current and previous boards and the memory for relocating the PEI slam into are allocated using NewHandle from the Memory Manager built into the Apple IIGS Toolbox.  When not running from GS/OS, all of memory banks 0 and 1 are allocated and used by the program before starting the Memory Manager.

# Remaining Work

This current implementation is incredibly slow and needs significant optimizations.
