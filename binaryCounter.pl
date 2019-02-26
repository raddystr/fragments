
chomp($decimal = <STDIN>);
chomp($bit = <STDIN>);
$match;
$ans;
$i = 1;


while($decimal>0){
	$remainder = $decimal%2;
	$ans = $ans+$remainder*$i;
	$i=$i*10;
	$decimal>>=1;
	
	if($remainder==$bit){
	$match++;
}
}
print"$match\n";


