#!/usr/bin/env perl
# Split a stream into multiple files. A new file is created each time the 
# supplied regular expression is matched in the stream.
#
# @author Bryan Davis <bpd@keynetics.com>
# @version SNV: $Id: resplit.pl 90 2007-10-26 21:20:35Z bpd $
#
use strict;
use warnings;

use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = 1;

use vars qw($USAGE);

$USAGE = "$0 [-q] [-p <prefix>] [-s <suffix>] -r <regex>\n";

{ # main block
  my $opt = {};
  getopts('r:p:s:qh', $opt);
  $opt->{h} && die $USAGE, "\n";

  # split expression
  $opt->{'r'} || die "-r /regex/ argument required";
  my $match = $opt->{'r'};

  # filename prefix
  $opt->{'p'} ||= '';
  $opt->{'s'} ||= '';

  my $chunk = 0;

  # use -q to keep from making an initial file
  unless ($opt->{'q'}) {
    open(OUT, ">" . $opt->{'p'} . $chunk . $opt->{'s'});
    # make OUT default handle
    select(OUT);
  }

  while (<>) {
    if (/$match/o) {
      $chunk++;
      select(STDOUT);
      close(OUT);
      open(OUT, ">" . $opt->{'p'} . $chunk . $opt->{'s'});
      # make OUT default handle
      select(OUT);
    }
    print $_;
  }
  select(STDOUT);
  close(OUT);
}
