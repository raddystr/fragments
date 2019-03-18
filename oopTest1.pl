use strict;
use lib '/usr/home/raddy/projects/OOP/';
use Quote;

my $phrase = "Baz";
my $author = "Foo";

my $quote1=Quote->new();
my $quote2=Quote->new();

$quote1->set_phrase($phrase);
$quote1->set_author($author);
$quote2->set_phrase($phrase);
$quote2->set_author($author);

$quote2->set_phrase("Some other phrase");
$quote1->set_author("Some other phrase");

print STDOUT $quote1->get_author(), " wrote ", $quote1->get_phrase(),"\n";
print STDOUT $quote2->get_author(), " wrote ", $quote2->get_phrase(),"\n";

exit 0;




