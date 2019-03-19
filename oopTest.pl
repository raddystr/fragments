use strict;
use lib '/usr/home/raddy/projects/OOP/'; 
use OopTest1;

my $phrase = "Baz";
my $author = "Foo";
my $approved = 0;

my $quote = Quote->new();
$quote->set_phrase($phrase);
$quote->set_author($author);
$quote->is_approved($approved);

print STDOUT $quote->get_phrase(), "\n";
print STDOUT $quote->get_author(), "\n";
print STDOUT ($quote->is_approved() ? "Is approved": "Is not approved"), "\n";

exit 0;
