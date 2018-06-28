#!/usr/bin/env perl

=head1 NOTES

Reads query log XML format from 3rd-party profiling tool.

=cut

use Modern::Perl;
use XML::Simple qw(XMLin);
use Data::Dumper;

go();
exit 0;

sub go {
    my @xml_text_lines = <>;
    my $xml_text = join("\n", @xml_text_lines);
    
    # I believe the encoding was changed when Nick did a copy/paste.
    $xml_text =~ s/encoding="utf-16"/encoding="utf-8"/;
    
    my $log = XMLin($xml_text);
    my $events = $log->{event};
    
    #say "XML length(): " . length $xml_text;
    #say "Number of events: " . scalar @$events;
    
    for my $event (@$events) {
        my $content = without_blank_lines($event->{content});
        say $content;
        say "=" x 80;
    }
    
    return;
}

sub without_blank_lines {
    my ($ary) = @_;
    
    my @lines = split("\n", $ary);
    @lines = grep { $_ !~ /^\S*$/ } @lines;
    
    return join("\n", @lines);
}

