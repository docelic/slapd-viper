#!/usr/bin/env perl
use warnings;
use strict;

# Script reads an LDIF file and briefly prints contained DNs.
# Offline script, used for detecting any syntactical errors
# in specified LDIFs.
#
# ./read-ldif.pl <ldif-file>
#
# Optionally, entry dump can be displayed:
#
# ./read-ldif.pl -v <ldif-file>
#
# Davor Ocelic <docelic@crystallabs.io>
# Crystal Labs, https://crystallabs.io/
# Released under GPL v3.

use Data::Dumper qw/Dumper/;
use Net::LDAP::LDIF qw//;

my $ldif = Net::LDAP::LDIF->new(
	$ARGV[0], "r",
	onerror => 'undef' # warn, die
);

my $verbose = 0;
if($ARGV[0] eq '-v') {
  shift;
  $verbose = 1
}

while(!$ldif->eof) {
	my $entry = $ldif->read_entry;

	if($ldif->error) {
		print "Error msg: ", $ldif->error, "\n";
		print "Error lines:\n", $ldif->error_lines, "\n"
	} else {
		print $entry. ' | '. $entry->dn. "\n";
		print Dumper \$entry if $verbose
	}
}
$ldif->done
