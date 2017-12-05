import std.stdio;
import std.conv;
import std.algorithm;
import std.array : array;

void main() {
    alias strToInt = map!(to!int);
    int[] l = strToInt(stdin.byLineCopy().array()).array();
    
    int steps = 0;
    int position = 0;
    int inputLength = cast(int)l.length;
    
    while (position < inputLength) {
        int oldPos = position;
        position += l[position];
        l[oldPos] += 1;
        steps++;
    }
    
    writeln(steps);
}