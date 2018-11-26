#!/usr/bin/env perl

# converts vim documentation to simple html
# Sirtaj Singh Kang (taj@kde.org)

# Sun Feb 24 14:49:17 CET 2002
#
# Modified by Fritz Mehner and Wolfgang Mehner 19.11.2017

use strict;
use vars qw/%url $date/;

%url = ();
$date = `date`;
chop $date;

sub maplink
{
	my $tag = shift;
	if( exists $url{ $tag } ){
		return $url{ $tag };
	} else {
		#warn "Unknown hyperlink target: $tag\n";
		$tag =~ s/\.txt//;
		$tag =~ s/</&lt;/g;
		$tag =~ s/>/&gt;/g;
		return "<code class=\"badlink\">$tag</code>";
	}
}

sub readTagFile
{
	my($tagfile) = @_;
	my( $tag, $file, $name );

	open(TAGS,"$tagfile") || die "can't read tags\n";

	while( <TAGS> ) {
		next unless /^(\S+)\s+(\S+)\s+/;

		$tag = $1;
		my $label = $tag;
		($file= $2) =~ s/.txt$/.html/g;
		$label =~ s/\.txt//;

		$url{ $tag } = "<a href=\"$file#".escurl($tag)."\">".esctext($label)."</a>";
	}
	close( TAGS );
}

sub esctext
{
	my $text = shift;
	$text =~ s/&/&amp;/g;
	$text =~ s/</&lt;/g;
	$text =~ s/>/&gt;/g;
	$text =~ s/§/&sect;/g;
	return $text;
}

sub escurl
{
	my $url = shift;
	$url =~ s/"/%22/g;
	$url =~ s/~/%7E/g;
	$url =~ s/</%3C/g;
	$url =~ s/>/%3E/g;
	$url =~ s/=/%20/g;
	$url =~ s/#/%23/g;
	$url =~ s/\//%2F/g;

	return $url;
}

sub vim2html
{
	my( $infile ) = @_;
	my( $outfile );

	open(IN, "$infile" ) || die "Couldn't read from $infile: $!.\n";

	($outfile = $infile) =~ s:.*/::g;
	$outfile =~ s/\.txt$//g;

	open( OUT, ">$outfile.html" )
			|| die "Couldn't write to $outfile.html: $!.\n";
	my $head = uc( $outfile );

	print OUT<<EOF;
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>VIM: $outfile</title>
<link rel="stylesheet" href="vim-stylesheet.css" type="text/css">
</head>
<body>
<h2>$head</h2>
<pre>
EOF

	my $inexample = 0;
	while( <IN> ) {
		chop;
#		if ( /^\s*[-=]+\s*$/ ) {
#			print OUT "</pre><hr><pre>";
		if ( /^[-=]+\s*$/ ) {                   # :CHANGE:17.10.2017 18:46:WM: lines which start with "-" or "=": print the separator as it is and use highlighting
			print OUT "<code class='section'>".$_."<\/code>\n";
			next;
		}

		# examples
		elsif( /^>$/ || /\s>$/ ) {
			$inexample = 1;
			chop;
		}
		elsif ( $inexample && /^([<\S])/ ) {
			$inexample = 0;
			$_ = $' if $1 eq "<";
		}

		s/\s+$//g;

		# Various vim highlights. note that < and > have already been escaped
		# so that HTML doesn't get screwed up.

		my @out = ();
		#		print "Text: $_\n";
		LOOP:
		foreach my $token ( split /((?:\|[^\|]+\|)|(?:\*[^\*]+\*))/ ) {
			if ( $token =~ /^\|([^\|]+)\|/ ) {
				# link
#				push( @out, "|".maplink( $1 )."|" );
				push( @out, maplink( $1 ) );   # :CHANGE:17.10.2017 18:48:WM: do not output the bars, to emulate Vim's conceal feature
				next LOOP;
			}
#			elsif ( $token =~ /^\*([^\*]+)\*/ ) {
			elsif ( $token =~ /^\*([^ \*][^\*]*)\*/ ) { # :WORKAROUND:20.03.2009 17:12:28:fgm: for C comments
				# target
				push( @out,
#					"<b class=\"vimtag\">\*<a name=\"".escurl($1)."\">".esctext($1)."<\/a>\*<\/b>");
					"<b class=\"vimtag\"><a name=\"".escurl($1)."\">".esctext($1)."<\/a><\/b>"); # :CHANGE:15.11.2014 18:32:43:WM: do not output the stars, makes "filter-vimtags.pl" obsolete
				next LOOP;
			}

			$_ = esctext($token);
			s/CTRL-(\w+)/<code class="keystroke">CTRL-$1<\/code>/g;
			# parameter <...>
			s/&lt;(.*?)&gt;/<code class="special">&lt;$1&gt;<\/code>/g;

			# parameter {...}
			s/\{([^}]*)\}/<code class="special">{$1}<\/code>/g;

			# parameter [...]
			s/\[(range|line|count|offset|cmd|[-+]?num)\]/<code class="special">\[$1\]<\/code>/g;
			# note
			s/(Note:?)/<code class="note">$1<\/code>/gi;

			# local heading
			s/^(.*)\~$/<code class="section">$1<\/code>/g;
			push( @out, $_ );
		}

		$_ = join( "", @out );

		if( $inexample == 2 ) {
			print OUT "<code class=\"example\">$_</code>\n";
		} else {
			print OUT $_,"\n";
		}

		$inexample = 2 if $inexample == 1;
	}
	print OUT<<EOF;
</pre>
<p><i>Generated by vim2html (modified) on $date</i></p>
</body>
</html>
EOF

	# :CHANGE:15.11.2014 18:34:34:WM: added "(modified)" to the output
}

sub usage
{
die<<EOF;
vim2html.pl: converts vim documentation to HTML.
usage:

	vim2html.pl <tag file> <text files>
EOF
}


sub writeCSS
{
	open( CSS, ">vim-stylesheet.css"  ) || die "Couldn't write stylesheet: $!\n";
	print CSS<<EOF;
body { background-color: white; color: black;}
:link { color: rgb(0,137,139); }
:visited { color: rgb(0,100,100);
           background-color: white; /* should be inherit */ }
:active { color: rgb(0,200,200);
          background-color: white; /* should be inherit */ }

B.vimtag { color : rgb(250,0,250); }

h1, h2 { color: rgb(82,80,82); text-align: center; }
h3, h4, h5, h6 { color: rgb(82,80,82); }
.headline { color: rgb(0,137,139); }
.header { color: rgb(164, 32, 246); }
.section { color: rgb(164, 32, 246); }
.keystroke { color: rgb(106, 89, 205); }
.vim { }
.example { color: rgb(0, 0, 255); }
.option { }
.notvi { }
.special { color: rgb(106, 89, 205); }
.note { color: blue; background-color: yellow; }
.sub {}
.badlink { color: rgb(0,37,39); }
EOF

}

# main
usage() if $#ARGV < 2;

print "Processing tags...\n";
readTagFile( $ARGV[ 0 ] );

foreach my $file ( 1..$#ARGV ) {
	print "Processing ".$ARGV[ $file ]."...\n";
	vim2html( $ARGV[ $file ] );
}
print "Writing stylesheet...\n";
writeCSS();
print "done.\n"
