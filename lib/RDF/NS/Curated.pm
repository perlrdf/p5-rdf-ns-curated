use 5.006000;
use strict;
use warnings;

package RDF::NS::Curated;

our $AUTHORITY = 'cpan:KJETILK';
our $VERSION   = '0.002';

sub new {
  my $class = shift;
  my %prefix_ns = (
						 rdfs => 'http://www.w3.org/2000/01/rdf-schema#',
						 vcard => 'http://www.w3.org/2006/vcard/ns#',
						 ical => 'http://www.w3.org/2002/12/cal/icaltzd#',
						 rdfa => 'http://www.w3.org/ns/rdfa#',
						 grddl => 'http://www.w3.org/2003/g/data-view#',
						 qb => 'http://purl.org/linked-data/cube#',
						 wdrs => 'http://www.w3.org/2007/05/powder-s#',
						 cc => 'http://creativecommons.org/ns#',
						 dc11 => 'http://purl.org/dc/elements/1.1/ => ',
						 rdf => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
						 xml => 'http://www.w3.org/XML/1998/namespace',
						 gr => 'http://purl.org/goodrelations/v1#',
						 og => 'http://ogp.me/ns#',
						 rr => 'http://www.w3.org/ns/r2rml#',
						 ma => 'http://www.w3.org/ns/ma-ont#',
						 v => 'http://rdf.data-vocabulary.org/#',
						 owl => 'http://www.w3.org/2002/07/owl#',
						 foaf => 'http://xmlns.com/foaf/0.1/',
						 rif => 'http://www.w3.org/2007/rif#',
						 sd => 'http://www.w3.org/ns/sparql-service-description#',
						 schema => 'http://schema.org/',
						 org => 'http://www.w3.org/ns/org#',
						 skosxl => 'http://www.w3.org/2008/05/skos-xl#',
						 xsd => 'http://www.w3.org/2001/XMLSchema#',
						 dc => 'http://purl.org/dc/terms/',
						 sioc => 'http://rdfs.org/sioc/ns#',
						 prov => 'http://www.w3.org/ns/prov#',
						 skos => 'http://www.w3.org/2004/02/skos/core#',
						 dcat => 'http://www.w3.org/ns/dcat#',
						 rev => 'http://purl.org/stuff/rev#',
						 wdr => 'http://www.w3.org/2007/05/powder#',
						 void => 'http://rdfs.org/ns/void#',
						 ctag => 'http://commontag.org/ns#',
						 xhv => 'http://www.w3.org/1999/xhtml/vocab#',
						 yago => 'http://yago-knowledge.org/resource/',
						 dbo => 'http://dbpedia.org/ontology/',
						 dbp => 'http://dbpedia.org/property/',
						 vann => 'http://purl.org/vocab/vann/',
						 pos => 'http://www.w3.org/2003/01/geo/wgs84_pos#',
						 time => 'http://www.w3.org/2006/time#',
						 bibo => 'http://purl.org/ontology/bibo/',
						 vs => 'http://www.w3.org/2003/06/sw-vocab-status/ns#',
						 doap => 'http://usefulinc.com/ns/doap#',
						 dctype => 'http://purl.org/dc/dcmitype/',
						 gn => 'http://www.geonames.org/ontology#',
						 frbr => 'http://purl.org/vocab/frbr/core#',
						 adms => 'http://www.w3.org/ns/adms#',
						 event => 'http://purl.org/NET/c4dm/event.owl#',
						 rel => 'http://purl.org/vocab/relationship/'
						);

  my $self = {
				  prefix_namespace => \%prefix_ns
				 };
  return bless($self, $class);
}

sub uri {
  my $self = shift;
  my $prefix = shift;
  return $self->{prefix_namespace}->{$prefix};
}

sub prefix {
  my $self = shift;
  my $namespace = shift;
  my $ns_prefix = $self->{namespace_prefix};
  unless ($ns_prefix) {
	 $ns_prefix = {reverse %{$self->{prefix_namespace}}};
	 $self->{namespace_prefix} = $ns_prefix;
  }
  return $ns_prefix->{$namespace};
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

RDF::NS::Curated - A curated set of RDF prefixes

=head1 SYNOPSIS

  my $ns = RDF::NS::Curated->new;
  print $ns->uri('foaf'); # prints http://xmlns.com/foaf/0.1/
  print $ns->prefix('http://schema.org/'); # prints schema

=head1 DESCRIPTION

This contains a list of 49 prefix and URI pairs that are commonly used
in RDF. The intention is that prefixes in this list can be safely used
in code that has a long lifetime. The list has been derived mostly
from W3C standards documents, but also some popularity lists. See the
source code of this package for the full list.

It is intended to be used with e.g. L<URI::NamespaceMap>.

Apart from the constructor, which takes no arguments, it has only two methods:

=over

=item C<< uri($prefix) >>

This will return the URI (as a plain string) of the supplied prefix or C<undef> if it is not registered.

=item C<< prefix($uri) >>

This will return the prefix corresponding to the supplied URI string or C<undef> if it is not registered.

=back

=head1 BUGS

Please report any bugs to
L<https://github.com/kjetilk/p5-rdf-ns-curated/issues>.

=head1 SEE ALSO

L<RDF::NS>, L<XML::CommonNS>, L<RDF::Prefixes>.

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

