# combench
A test suite for C64 BASIC compilers.

This has been written mainly to test and improve the MOSpeed BASIC compiler: https://github.com/EgonOlsen71/basicv2

It contains the test suite as BASIC V2-sources in the "basic" subdirectory as well as a collection of executable version of it compiled by various C64 BASIC compilers in the "bin" directory.

In the "doc" directory, you can find a document (Libre Office as well as PDF) with the latest results.

The test suite will take its time, especially when run in the interpreter. Please note that no compiler hints have been used as it's MOSpeed's goal to be fast without them. If you intend to use hints with other compilers, please be aware that this might change the calculation but the test suite doesn't really check them for validity.