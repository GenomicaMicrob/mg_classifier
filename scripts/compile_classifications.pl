#!/usr/bin/perl
# AUTHOR: Sobrique (Modified by Bruno Gomez-Gil) 
# Script to compile files of classifications based on the first column.
# Last revisited: 29 Nov 2016
# USAGE: perl compile.pl *.txt

use strict;
use warnings;
use Data::Dumper;

my @header; 
my %all_rows;
my %seen_cols;


# read STDIN or files specified as args. 
while ( <> ) {
   # detect a header row by keyword. 
   # can probably do this after 'open' but this way
   # means we can use <> and an arbitrary file list. 
   if ( m/^AAAAAAAAAA_Accession/ ) { 
      @header = split;       
      shift @header; # drop "AAAAAAAAAA_Accession" off the list so it's just S01,02,03 etc. 
      $seen_cols{$_}++ for @header; # keep track of uniques. 
   }
   else {
      # not a header row - split the row on whitespace.
      # can do /\t/ if that's not good enough, but it looks like it should be. 
      my ( $ID, @fields ) = split; 
      # use has slice to populate row.

      my %this_row;
      @this_row{@header} = @fields;

      # debugging
      # print Dumper \%this_row; 

      # push each field onto the all rows hash. 
      foreach my $column ( @header ) {
         # append current to field, in case there's duplicates (no overwriting)
         $all_rows{$ID}{$column} .= $this_row{$column}; 
      }
   }
}

#print for debugging
#print Dumper \%all_rows;
#print Dumper \%seen_cols;

#grab list of column headings we've seen, and order them. 
my @cols_to_print = sort keys %seen_cols;

#print header row. 
print join "\t", "AAAAAAAAAA_Accession", @cols_to_print,"\n";
#iterate keys, and splice.
foreach my $key ( sort keys %all_rows ) { 
    #print one row at a time.
    #map iterates all the columns, and gives the value or an empty string
    #if it's undefined. (prevents errors)
    print join "\t", $key, (map { $all_rows{$key}{$_} // '' } @cols_to_print),"\n"
}
# This is the end.
