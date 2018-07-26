#!/usr/bin/env perl6
use v6;

my $bowsers-fireball = q:to/END_OF_CHARMAP/;
..........------..-.....
.....----------------...
...-----==--====--====--
-------------=====####--
.....----=============#-
...-------------===----.
....---------.------....
.....--..---.--..-......
END_OF_CHARMAP

my $pixel-width  = 2;
my $base-level   = .75;
my $level-height = .5;
sub height($level) { $base-level + $level * $level-height }
my %heights =
    '-' => height(0),
    '=' => height(1),
    '#' => height(2),
    ;

sub pixels() {
    gather for $bowsers-fireball.comb -> $c {
        state $x = 0;
        state $y = 0;

        given $c {
            when "\n" { $x = 0; $y++; next }
            when "." { #`(ignore) }
            default { take ($x, $y, %heights{$_}) }
        }

        $x++;
    }

}

sub MAIN() {
    say qq:to/END_OF_PRELUDE/;
    pixel_width  = $pixel-width;

    module pixel(x, y, h) \{
        translate([x*pixel_width,y*pixel_width,0])
        cube([pixel_width, pixel_width, h]);
    }

    END_OF_PRELUDE

    say Q"union() {";
    for pixels() -> ($x, $y, $h) {
        say "pixel($x, $y, $h);".indent(4);
    }
    say Q"}";
}
