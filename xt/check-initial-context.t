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
use Test::More;

BEGIN {
  use_ok('RDF::NS::Curated');
  use_ok('RDF::TrineX::Parser::RDFa') or BAIL_OUT "RDF::RDFa::Parser must be installed for these tests";
}

use Test::WWW::Mechanize;
use Test::Exception;

my $mech = Test::WWW::Mechanize->new;

my $page = 'https://www.w3.org/2011/rdfa-context/rdfa-1.1';
note "Get and check the document";
$mech->get_ok($page);
$mech->title_like(qr/Initial Context/);
#print $mech->content;
$mech->content_like(qr/HTML\+RDFa 1.1/);

note "Parsing the RDFa content";
my $parser = RDF::TrineX::Parser::RDFa->new(
														  flavour        => 'html5',
														  version        => '1.1',
														  role_attr      => 1,
														  longdesc_attr  => 1,
														  cite_attr      => 1,
														 );

my $model = RDF::Trine::Model->temporary_model;

lives_ok { $parser->parse_into_model($page, $mech->content, $model) } 'Parsing the RDFa';

done_testing;

