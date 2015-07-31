=pod

=encoding utf-8

=head1 PURPOSE

Test that RDF::NS::Curated compiles.

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2015 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More;
use Test::Exception;

use_ok('RDF::NS::Curated');

my $ns = RDF::NS::Curated->new;
isa_ok($ns, 'RDF::NS::Curated');

is($ns->uri('foaf'), 'http://xmlns.com/foaf/0.1/', 'FOAF spec URI is OK');
is($ns->uri('omfgthisisnotaprefix'), undef, 'Non-existent prefix OK');
is($ns->prefix('http://schema.org/'), 'schema', 'Schema.org prefix OK');
is($ns->prefix('http://clearly.invalid/'), undef, 'Non-existent URI OK');
is($ns->prefix('http://creativecommons.org/ns#'), 'cc', 'CC prefix OK, test the cache');

TODO: {
  local $TODO = 'Create a working definedby method';
  is($ns->definedby(prefix => 'rif'), 'http://www.w3.org/TR/2010/NOTE-rif-overview-20100622/', 'RIF spec link from prefix OK');
  is($ns->definedby(uri => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'), 'http://www.w3.org/TR/2004/REC-rdf-mt-20040210/', 'RDF spec from URI ok');
  is($ns->definedby(prefix => 'omfgthisisnotaprefix'), undef, 'spec link from non-existent prefix OK');
  is($ns->definedby(uri => 'http://clearly.invalid/'), undef, 'spec link from non-existent URI ok');
  dies_ok { $ns->definedby('huhwtf' => 'http://schema.org/') } 'Dies if unknown type';
}

done_testing;

