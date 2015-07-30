use 5.010001;
use strict;
use warnings;

package RDF::NS::Curated;

our $AUTHORITY = 'cpan:KJETILK';
our $VERSION   = '0.001';

use Text::CSV;
use File::ShareDir qw(module_file);
use List::MoreUtils qw(zip);
use Data::Dumper;

sub new {
  my $class = shift;
  my $pfile = '/home/kjetil/dev/p5-rdf-ns-curated/share/prefixes.csv';
#  my $pfile = module_file('RDF::NS::Curated', 'prefixes.csv') || die 'Could not find the CSV file containing prefixes';
  my $csv = Text::CSV->new or die "Cannot use CSV module to parse prefix file: ".Text::CSV->error_diag ();
  open my $fh, "<:encoding(utf8)", $pfile or die "Could not open prefix file: $!";
  my %prefix_ns;
  my @definedby;
  while ( my $row = $csv->getline( $fh ) ) {
	 next if ($row->[0] eq 'prefix');
	 $prefix_ns{$row->[0]} = $row->[1];
	 push(@definedby, $row->[2]);
  }
  my $self = {
				  prefix_namespace => \%prefix_ns,
				  definedby => \@definedby,
				 };
  return bless($self, $class);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

RDF::NS::Curated - A cureted set of RDF prefixes

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

Please report any bugs to
L<https://github.com/kjetilk/p5-rdf-ns-curated/issues>.

=head1 SEE ALSO

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2015 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

