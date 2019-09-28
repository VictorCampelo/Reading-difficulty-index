use strict;
use warnings;

print "Digite o nome da múcisa: ";
my $music = <>;
$music =~ /(\w+) (\w+) (\w+)/;

my $filename = 'music.txt';
my $text;
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Não foi possível abrir o arquivo '$filename' $!";

for my $line (<$fh>) {
	print $line if $line =~ /\w*(\s*$1\s[(Willie)|($2)]('s\s$3)*)\w*/;
}