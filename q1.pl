use strict;
use warnings;

my $filename = 'music.txt';
my $text;
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Não foi possível abrir o arquivo '$filename' $!";

for my $line (<$fh>) {
print $line if $line =~ /\w(\s*Jelly\s?[rR]oll*)/;
}