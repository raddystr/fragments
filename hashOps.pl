

%hash=('name'=>'WarCraft');

$hash{game}=delete $hash{name};

$hash{game}= 'StarCraft';

foreach(sort keys %hash){
	print "$_ = $hash{$_}\n"; 
}
