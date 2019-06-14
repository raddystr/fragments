#!/usr/local/bin/perl 
use strict;
use warnings;
use CGI;
use DBI;
use HTML::Template::Pro;

my $template = HTML::Template::Pro->new(filename=>'index.tmpl');
my $cgi = CGI->new();

print"Contenr-type:text/html\n\n";

print $template->output();
