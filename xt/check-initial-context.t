=pod

=encoding utf-8

=head1 PURPOSE

Download and check if we have all namespaces in RDFa Initial Context

=head1 SEE ALSO

L<https://www.w3.org/2011/rdfa-context/rdfa-1.1>

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2018 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More skip_all => "Can't get SSL working now";

BEGIN {
  use_ok('RDF::NS::Curated');
  use_ok('RDF::Trine::Parser') or BAIL_OUT "RDF::Trine::Parser must be installed for these tests";
}

# These are prefixes we want to ignore
my @blacklist = qw(dcterms duv);


use Test::Exception;
use RDF::Trine qw(iri variable statement);
use List::Util qw(any);

my $cur = RDF::NS::Curated->new;

my $page = 'https://www.w3.org/2011/rdfa-context/rdfa-1.1.ttl';
note "Get and check the document";


my $model = RDF::Trine::Model->temporary_model;

my $parser     = RDF::Trine::Parser->new( 'turtle' );

lives_ok { $parser->parse_url_into_model($page, $model) } 'Parsing the RDF';

cmp_ok($model->size, '>', 5, 'Got some RDF from the document');

my $bind = $model->get_pattern(RDF::Trine::Pattern->new(statement(variable('id'),
																						iri($cur->uri('rdf').'type'),
																						iri($cur->uri('rdfa').'PrefixMapping')),
																		  statement(variable('id'),
																		  				iri($cur->uri('rdfa').'prefix'),
																		  				variable('prefix')),
																		  statement(variable('id'),
																		  				iri($cur->uri('rdfa').'uri'),
																		  				variable('uri')),
																		  statement(variable('id'),
																						iri($cur->uri('dc').'description'),
																						variable('desc'))
																		 ));
isa_ok($bind, 'RDF::Trine::Iterator::Bindings');

ok($bind->peek, 'There are results');

note 'Checking all mappings';

while (my $row = $bind->next) {
  subtest "Testing for $row->{'desc'}" => sub {
	 plan skip_all => $row->{'desc'} . ' prefix ' . $row->{'prefix'}->literal_value . ' is blacklisted, skipping' if (any {$_ eq $row->{'prefix'}->literal_value} @blacklist);
	 my $prefix = $cur->prefix($row->{'uri'}->value);
	 ok(defined($prefix), 'Found namespace URI ' . $row->{'uri'}->as_string);
	 is($prefix, $row->{'prefix'}->literal_value, 'Found prefix ' . $row->{'prefix'}->literal_value);
  };
}

done_testing;

