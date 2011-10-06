#!/usr/bin/perl -w

# (c) by Erik Rodner
# checks for hyphen inconsistencies

use strict;
my %words;

my @forbidden_words = qw(asymmetric area areas into indirect overall);
my %forbidden_words;
for my $w (@forbidden_words) { $forbidden_words{$w} = 1; };

my $ANSINORMAL = "\033[0m";
my $ANSIBLUE = "\033[94m";

for my $fn (@ARGV)
{
	open ( FILE, "<$fn" ) or die ("$fn: $!\n");
	while (<FILE>) {
		chomp;
		my @w = split /\s+/, lc $_;
		my $oldword;
		for my $w (@w)
		{
			$w =~ s/\s+//g;
			my $wh = $w;
			next if ( $w !~ /^[a-zA-Z][a-zA-Z\-]+$/ );
			$wh =~ s/-//g;
			push @{ $words{$wh}->{$w} }, "$fn: $.";
			if ( defined($oldword) ) {
				push @{ $words{"$oldword$w"}->{"$oldword $w"} }, "$fn: $.";
			}
			$oldword = $w;
		}
	}
	close ( FILE );
}

for my $wh ( keys %words ) {
	my @fails;
	my @k = keys %{ $words{$wh} };

	next if ( @k <= 1 );
	next if ( exists($forbidden_words{$wh}) );
	
	my @para;
	for my $i (0..$#k) 
	{
		$para[$i] = "\"$k[$i]\"";
	}

	my $pfword;
	open ( PAPERFIGHT, "paperFight.pl @para |" ) or die ("paperFight.pl: !\n");
	my $tmp;
	while ( $tmp = <PAPERFIGHT> ) { $pfword = $tmp; };
	chomp $pfword;
	close ( PAPERFIGHT );

	print "$wh: ";
	
	for my $i (0..scalar(@k)-1) 
	{
		my $kk = $k[$i];

		if ( $i != 0 ) {
			print ",";
		}

		my $num = scalar @{ $words{$wh}->{$kk} };

		if ( $pfword eq $kk ) {
			print "$ANSIBLUE$kk$ANSINORMAL ($num)";
		} else {
			print "$kk ($num)";
			push @fails, @{ $words{$wh}->{$kk} };
		}
	}
		
	print "\n";
	print join("\n", @fails);
	print "\n";
}
