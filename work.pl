
#indice de dificuldade de leitura de um texto
#O script deve receber como entrada um arquivo texto e retornar o índice de dificuldade de leitura do texto nele contido de acordo com a idade 
#escolar de uma pessoa. Ex: Indice de 10 indica que o texto é compreensível por alguém com 10 anos de vida escolar.
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
use utf8;
use Encode;

my $filename;
my $fh;
if(defined $ARGV[0]){
	my $name = $ARGV[0];
	print "$name\n\n";
	if ($name =~ /\w+\.txt$/) {
		$filename=$name;	
	}
	else{
		print "Não foi possivel localizar o arquivo.\n\n";
		exit 1;
	}
}
else{
	$filename = 'text.txt';
}

open($fh, '<:encoding(UTF-8)', $filename) 
or die "Não foi possível abrir o arquivo '$filename' $!";

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
my $nWrd_Phr = 0;
my @tam_Phr;
my $aux = 0;
my $nWrd_DF = 0;

foreach my $char (split /\s/, $textToStudy) {
	#nWrd_Phr  conta a quantidade de palavras por frase
	$nWrd_Phr ++;
	#contar o numero de silabas.
	if($char =~ /(?i)([bcçdfghjklmnpqrstvwxyz]{0,3}([iu]{0,1}[aeo]{1}[iu]{0,1}|[a-uã-ũ]{1,3}))(([bcçdfghjklmnpqrstvwxyz]{1,3}([iu]{0,1}[aeo]{1}[iu]{0,1}|[a-uã-ũ]{1,3}))|[áéíóúâêîôû]{1})(([bcçdfghjklmnpqrstvwxyz]{1,3}([iu]{0,1}[aeo]{1}[iu]{0,1}|[a-uã-ũ]{1,3}))|[áéíóúâêîôû]{1})/){
		$nWrd_DF++;
		print "$char - "
	}
	if(($char =~ /\w+\.\s?/) || ($char =~ /\w+\,\s?/)){
		#numero de frases e seus tamanhos
		$tam_Phr[$aux] = $nWrd_Phr ;
		$nWrd_Phr  = 0;
		$aux++;
	}
}
my $MP;
for (my $var = 0; $var < scalar @tam_Phr; $var++) {
	$MP += $tam_Phr[$var];
}
#3. Encontre o número médio de palavras por frase.
#MP=NUM_PALAVRAS/NUM_FRASES
$MP = $MP/$aux;
print "Numero medio de palavras: $MP\n";
print "Numero de palavras difíceis: $nWrd_DF\n";
#4. Contabilize o número de palavras "difíceis"(palavras com mais de 3 sílabas) no trecho. Divida esta quantidade pelo total de palavras.
#PROP_P_DIF=NUM_P_DIF/NUM_PALAVRAS
my $prob_DF;
$prob_DF=($nWrd_DF/$countWrd);
print "Probabiblidade de palavras dificeis: $prob_DF %\n";
#5. O índice é o valor arredondado da soma das duas quantidades acima, multiplicadas por 0.4
#INDICE=int(0.4*(MP+PROP_P_DIF))
my $idc;
$idc=int(0.4*($MP+$prob_DF));
print "indice de dificuldade de leitura de um texto: $idc anos\n\n";

exit 0;
