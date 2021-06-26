# NAME

RDF::NS::Curated - A curated set of RDF prefixes

# SYNOPSIS

    my $ns = RDF::NS::Curated->new;
    print $ns->uri('foaf'); # prints http://xmlns.com/foaf/0.1/
    print $ns->prefix('http://schema.org/'); # prints schema

# DESCRIPTION

This contains a list of 62 prefix and URI pairs that are commonly used
in RDF. The intention is that prefixes in this list can be safely used
in code that has a long lifetime. The list has been derived mostly
from W3C standards documents, but also some popularity lists. See the
source code of this package for the full list.

It is intended to be used with e.g. [URI::NamespaceMap](https://metacpan.org/pod/URI::NamespaceMap).

## Methods

- `new`

    Constructor. Takes no arguments.

- `uri($prefix)`

    This will return the URI (as a plain string) of the supplied prefix or `undef` if it is not registered.

- `prefix($uri)`

    This will return the prefix corresponding to the supplied URI string or `undef` if it is not registered.

- `qname($uri)`

    This will return the qualified name corresponding to the supplied URI
    string or `undef` if it is not registered. In scalar context, it will
    return the prefix and local name with a colon, and list context, a
    two-element array containing prefix and local name.

    For example `http://purl.org/dc/terms/name` will return `dc:name` in
    scalar context and `('dc', 'name')` in list context.

- `all`

    This will return a hashref with all prefix and URI pairs.

# BUGS

Please report any bugs to
[https://github.com/perlrdf/p5-rdf-ns-curated/issues](https://github.com/perlrdf/p5-rdf-ns-curated/issues).

# SEE ALSO

[RDF::NS](https://metacpan.org/pod/RDF::NS), [XML::CommonNS](https://metacpan.org/pod/XML::CommonNS), [RDF::Prefixes](https://metacpan.org/pod/RDF::Prefixes).

# AUTHOR

Kjetil Kjernsmo <kjetilk@cpan.org>.

# CONTRIBUTORS

Harald Jörg

# COPYRIGHT AND LICENCE

This software is copyright (c) 2015, 2017, 2018 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

# DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
