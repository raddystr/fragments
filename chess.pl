#!/usr/local/bin/perl
use warnings;
use strict;
use diagnostics;
###########################################CREATION OF THE BOARD AND STARTING POSITIONS ###########################################################
my @chessboard;
my @back= qw(R N B Q K B N R);
   
for(0 .. 7){
	$chessboard[0]->[$_] = "W" . $back[$_];
        $chessboard[1]->[$_] = "WP";
        $chessboard[6]->[$_] = "BP";
        $chessboard[7]->[$_] = "B"  . $back[$_];
}
  
while(1){
          for my $i (reverse (0 .. 7)){
                  for my $j(0 .. 7){
                          if(defined $chessboard[$i]->[$j]){
                                  print $chessboard[$i]->[$j];
                          }elsif(($i %2)==($j %2) ){
			  	print"..";
			  }else{
			  	print"  ";
			  }
			  print " ";
                  }
		  print "\n";
          }
	  ###############################################GAME START AND INPUTS##################################################################	
	  ######################################################################################################################################
	  print "\nStarting square[x, y]: ";
	  my $move=<>;
	  last unless($move=~ /^\s*([1-8]),([1-8])/);
	  my $startx = $1-1;
	  my $starty = $2-1;

	  unless (defined $chessboard[$starty]->[$startx]){
	  	print "There is nothing on that square!\n";
		next;
	  }
	  print "\nEnding square[x,y]: ";
	  $move = <>;
	  last unless($move =~ /([1-8]),([1-8])/ );
	  my $endx = $1-1;
	  my $endy = $2-1;
##############PAWN MOVE FIRST MOVE#################################################################################################
	  ##################################################################
	if(($chessboard[$starty]->[$startx]=~/BP/) || ($chessboard[$starty]->[$startx]=~/WP/)) {
		my $color = 1;
		print"$color Pawn's move\n";

		if(defined $chessboard[$endy]->[$endx]){
			if($chessboard[$endy]->[$endx]=~/$color\w/){
				print"Don't take from your own.\n";
			}
		}
		if( ( (abs($endx-$startx)==0) && (abs($endy-$starty)<=2) && $endy>=$starty && ( $chessboard[$starty]->[$startx]=~ m/WP/)) ||  
			( (abs($endx-$startx)==0) && (abs($endy-$starty)<=2) && $endy<=$starty && ( $chessboard[$starty]->[$startx]=~ m/BP/)) ){
			print"Good first move Pawn!\n";
		}else{
			print"Pawn move for one or two squares as a first move and only straight forward!\n";
			next; 
		}
	} 
#######################################PAWN REGULAR MOVE##################################################################
	####################################################################
	if($chessboard[$starty]->[$startx]=~/BP/ && $starty!=6 || ($chessboard[$starty]->[$startx]=~/WP/ && $starty!=1) ){
		my $color = 1;
		print"$color Pawn's move\n";

		if(defined $chessboard[$endy]->[$endx]){
			if($chessboard[$endy]->[$endx]=~/$color\w/){
				print"Don't take of your own.\n";			}
		}
		if( ( (abs($endx-$startx)==0) && (abs($endy-$starty)<=1) && $endy>=$starty && ( $chessboard[$starty]->[$startx]=~ m/WP/)) ||  
			( (abs($endx-$startx)==0) && (abs($endy-$starty)<=1) && $endy<=$starty && ( $chessboard[$starty]->[$startx]=~ m/BP/)) ){
			print"Good move Pawn!\n";	
		}else{
			print"Pawn move for one square as and only straight forward!\n";
			next; 
		}
	} 
##########################################ROOK MOVE#################################################################
	####################################################################
	if($chessboard[$starty]->[$startx]=~ /([WB])R/){
		my $color = $1;
		print "$color Rook's move\n";

		if(defined $chessboard[$endy]->[$endx]){
			if($chessboard[$endy]->[$endx]=~ /$color\w/){
				print"Don't take one of your own.\n";
			}
		}
		if( ( (abs($endy - $starty)==0 && (abs($endx - $startx)<=8)) || ( (abs($endx - $startx)==0) && (abs($endy - $starty)<=8 ) ) ) ){
			print"Good move ROOK\n\n";		
		}else{
			print"Rook moves in straight line!\n"; 
			next;
			}
		}
		
#####################################KNIGHT MOVE###########################################################################################
		#####################################################
	  if($chessboard[$starty]->[$startx]=~ /([WB])N/){
	  	my $color = $1;
		print "$color Knight's move\n";

		if(defined $chessboard[$endy]->[$endx]){
			if($chessboard[$endy]->[$endx]=~ /$color\w/){
				print"Don't take one of your own.\n";
			}
		}
		if(((abs($endy - $starty)==2) && (abs($endx - $startx)==1)) || ((abs($endx - $startx)==2) &&($endy - $starty)==1 )){
			print"Good move KNIGHT\n\n";
		}else{
			print"Knight moves in a L-shape\n\n";
			next; 
		}
	  }
	  ###########END#########################
	  $chessboard[$endy]->[$endx] = $chessboard[$starty]->[$startx];
	  undef $chessboard[$starty]->[$startx]; 
  }
