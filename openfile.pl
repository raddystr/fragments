#!/usr/local/perl

$number = <STDIN>;
foreach(1 .. $number){
	if($number>$_){
	$factorial+=$_;
	print"$factorial";
}
}
