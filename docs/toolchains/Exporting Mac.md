# Exporting Mac / Darwin Toolchain

Well bad new, this can't be done automatically :(.

The meta-darwin layer provided by Yocto uses gdb 4 which is not supported by Poky to my knowledge. I have started a new repo in the QutiPi Github group, which upgrades the layer to use gdb 7 and fixed propagating errors.

However odcctools that was provided by apple for cross compiling for darwin on linux only supports upto gdb 4.7 i believe. This project is now dead and i don't know of any replacement for it.

If anyone could look into this, that would be awesome!

## Where now?

I have created a cross compiler for the CM3 with QutiPi on Darwin, however i have yet to compile Qt's libraries or test it; this means that qmake is not available to use.

Another option is to use MacOS's default compiler to cross compile for CM3 with QutiPi. MacOS comes with clang which is a cross compiler by default this differs from gdb. This means if you have a mac you can compile for the CM3 right now. However as above we'll have to create a sysroot to package with the compiler's setup which requires me to compile Qt libs using the clang compiler.

P.S i hate compiling Qt, it's never an easy process.

## Time

I would not wait for this to be finished anytime soon. 
