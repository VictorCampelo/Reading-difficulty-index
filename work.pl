

#indice de dificuldade de leitura de um texto

#O script deve receber como entrada um arquivo texto e retornar o índice de dificuldade de leitura do texto nele contido de acordo com a idade escolar de uma pessoa. Ex: Indice de 10 indica que o texto é compreensível por alguém com 10 anos de vida escolar.

#O cálculo deste indice deve seguir o seguinte algoritmo:

#1. Escolha um trecho do texto com pelo menos 100 palavras.
#2. Contabilize o número de frases. Frases neste contexto são terminadas em virgula ou ponto.
#3. Encontre o número médio de palavras por frase.
#MP=NUM_PALAVRAS/NUM_FRASES
#4. Contabilize o número de palavras "difíceis"(palavras com mais de 3 sílabas) no trecho. Divida esta quantidade pelo total de palavras.
#PROP_P_DIF=NUM_P_DIF/NUM_PALAVRAS
#5. O índice é o valor arredondado da soma das duas quantidades acima, multiplicadas por 0.4
#INDICE=int(0.4*(MP+PROP_P_DIF))

#A parte crucial do algoritmo é como contabilizar o número de sílabas da palavra. Deve ser considerada a divisão silábica da lingua portuguesa.
#Dica: A divisão silábica está diretamente relacionada ao número de vogais na palavra. Salvo os casos de ditongos e tritongos.

use strict;
use warnings;
use 5.010;
use Data::Dumper qw(Dumper);

my $filename = 'text.txt';
my $text;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Não foi possível abrir o arquivo '$filename' $!";

#my $line = " Esta é uma linha de texto ";
#my @wc = split(/\s/, $fh);
#say Dumper \@wc;
#say $fh;
my $countWrd = 0;
my $flag = 0;
my $textToStudy = "";
#escolher trecho aleatorio do texto.
for my $line (<$fh>) {
	my @wc = split(/\s/, $line);
	for (my $var = 0; $var < scalar @wc; $var++) {
		$countWrd++;
		$textToStudy .= $wc[$var]." ";
		if($countWrd >= 100){
			if($wc[$var] =~ /\w+\.\s?/){
				#print "$wc[$var] \n";
				$flag = 1;
				last;
			}
		}
	}
	if($flag == 1){
		last;
	}
}

#calcular o numero medio de palavras.
#print $textToStudy;
my $count = 0;
my @tamPhr;
my $aux = 0;
my $qtdWrd = 0;
foreach my $char (split /\s/, $textToStudy) {
	#print "$char\n";
	$count++;
	#contar o numero de silabas.
	if($char =~ /([aáâãàeéêãiíîĩìoóôòõuùúûũ]|[bcdfghjklmnpqrstvwxyz]{1,3}[aáâãàeéêãiíîĩìoóôòõuùúûũ]{1,3})([bcdfghjklmnpqrstvwxyz]{1,3}[aáâãàeéêãiíîĩìoóôòõuùúûũ]{1,3})([bcçdfghjklmnpqrstvwxyz]{1,3}[aáâãàeéêãiíîĩìoóôòõuùúûũ]{1,3})/){
		$qtdWrd++;
	}
	if(($char =~ /\w+\.\s?/) || ($char =~ /\w+\,\s?/)){
		#print "$char\n";
		$tamPhr[$aux] = $count;
		$count = 0;
		$aux++;
	}
}
my $MP;
for (my $var = 0; $var < scalar @tamPhr; $var++) {
	$MP += $tamPhr[$var];
}
$MP = $MP/$aux;
print "$MP\n";
print "$qtdWrd\n\n";