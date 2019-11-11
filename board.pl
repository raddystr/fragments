#!/usr/bin/perl
use Term::ANSIColor;

print color('red'); 
print"y\n\n"; 
print color('reset'); 

for($i=1;$i<=8;$i++){
	if($i%2==0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 8';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2!=0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 7';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2==0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 6';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2!=0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 5';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2==0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 4';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2!=0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 3';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2==0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 2';
}
print"\n";

for($i=1;$i<=8;$i++){
	if($i%2!=0){
		print color('yellow');
	}else{
		print color('reset');
	}
	print ' 1';
}
print"\n";

print "\n";
print color('green'); 
for($x=1; $x<=8;$x++){
	print" $x"; 
}
print color('reset'); 

print"\n"; 
print color('red'); 
print ' ' x 19, "x\n";
