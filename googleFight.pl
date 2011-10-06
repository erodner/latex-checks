#!/usr/bin/perl
# google.pl - command line tool to search google
#
# Since I wrote goosh.org I get asked all the time if it could be used on the command line.
# Goosh.org is written in Javascript, so the answer is no. But google search in the shell
# is really simple, so I wrote this as an example. Nothing fancy, just a starting point.
#
# 2009 by Stefan Grothkopp, this code is public domain use it as you wish!

use LWP::Simple;
use Term::ANSIColor;

# change this to false for b/w output
$use_color = true;
#result size: large=8, small=4
$result_size = "large";

# unescape unicode characters in" content"
sub unescape {
        my($str) = splice(@_);
        $str =~ s/\\u(.{4})/chr(hex($1))/eg;
        return $str;
}


####### queryGoogle () // code date : 29.06.11 ######
sub queryGoogle
{

	my $q = shift @_;
	# url encode query string
	$q =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;

	# get json encoded search result from google ajax api
	my @results;
	my $content = get("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&start=0&q=$q"); #Get web page in content
	#my $content = get("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&start=0&rsz=$result_size&q=$q"); #Get web page in content
	die "get failed" if (!defined $content);

	# ugly result parsing (did not want to depend on a parser lib for this quick hack)
	my $count;
	while($content =~ /"estimatedResultCount":"([^"]*)"/g){

		$count = $1;
	}

	return $count;
}

# number of command line args
$numArgs = $#ARGV + 1;

if($numArgs != 2){
        # print usage info if no argument is given
        print "Usage:\n";
        print "$0 <searchterm1> <searchterm2>\n";
} else {
		my $r1 = queryGoogle( $ARGV[0] );
		my $r2 = queryGoogle( $ARGV[1] );

		print "$ARGV[0]: $r1\n";
		print "$ARGV[1]: $r2\n";

		if ( $r1 > $r2 ) {
			print $ARGV[0];
		} else {
			print $ARGV[1];
		}
		print "\n";
}
