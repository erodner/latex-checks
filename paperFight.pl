#!/usr/bin/perl -w
#

# check word occurences
# written by Erik Rodner 2011
#
# The following directory should contain some *.txt documents
# which can be used for statistics. My suggestion is to
# convert all files of your paper pdf directory to txt files with pdftotext.
my $literaturedir = "/home/rodner/doc/literature/paper/object_recognition/";


####### countHits () // code date : 29.06.11 ######
sub countHits
{
	my $word = shift @_;
	my $count = 0;

	open ( GREP, "grep -c \'$word\' $literaturedir/*.txt |" ) or die ("grep \"$word\" $literaturedir/*.txt: $!\n");
	while (<GREP>)
	{
		chomp;
		my ($scount) = /:(\d+) *$/;
		if ( $scount > 0 )
		{
			$count++;
		}
	}
	close ( GREP );

	return $count;
}

if ( @ARGV == 0 )
{
	die ("usage: $0 <words>\n");
}

if ( ! -d $literaturedir ) {
	die ("$0: directory $literaturedir not found!\n");
}

my $maxc = 0;
my $maxword = "";
for my $w ( @ARGV )
{
	my $c = countHits ( $w );
	if ( $c > $maxc ) {
		$maxc = $c;
		$maxword = $w;
	}
	print "$w: $c\n";
}

print "$maxword\n";
