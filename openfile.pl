#!/usr/bin/perl

open(IN, "test") or die("Cannot open:$!");

while($line=<IN>){
	print("file:$line\n");
}
close(IN) or die(Cannot close file:$!);
