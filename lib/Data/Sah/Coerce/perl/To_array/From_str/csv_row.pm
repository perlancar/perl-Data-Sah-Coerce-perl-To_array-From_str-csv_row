package Data::Sah::Coerce::perl::To_array::From_str::csv_row;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        summary => 'Coerce a single CSV row to array of scalars',
        prio => 50,
    };
}

our $csv;
sub coerce {
    $csv //= do {
        require Text::CSV;
        Text::CSV->new ({ binary => 1, auto_diag => 1 });
    };

    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";
    $res->{expr_coerce} = join(
        "",
        'do { ',
        '$' . __PACKAGE__ . "::csv->parse($dt); ",
        '[$' . __PACKAGE__ . "::csv->fields]; ",
        ' }',
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|coerce)$

=head1 SEE ALSO

L<Data::Sah::Coerce::perl::To_array::From_str::comma_sep> accomplishes roughly
the same thing without handling escapes or quotes.

L<Data::Sah::Coerce::perl::To_array::From_str::tsv_row>

L<Data::Sah::Coerce::perl::To_array::From_str::csv>
