#!/usr/bin/perl

use DateTime::Format::Strptime qw( );
my $format = DateTime::Format::Strptime->new(
   pattern   => '%Y%m%d',
   time_zone => 'local',
   on_error  => 'croak',
);
my $dt = $format->parse_datetime('20111121');
