#!/usr/local/bin/perli


foreach(1..6000){
random();
}

sub random{
$ran = int(rand(6));
if($ran>0){
print  $ran . "\n";
	}
}
