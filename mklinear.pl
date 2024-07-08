#!/usr/bin/env perl
#
# mklinear.pl:  Perl script to convert a copy-pasted Advantage360 ZMK keymap
# to a line-per-key entry with comments describing the original key layout.
#
use strict;
use warnings;
my @allwords;

my @labels = (
    "// Row 1 Left",
    "EQUAL",
    "1",
    "2",
    "3",
    "4",
    "5",
    "KPAD",

    "// Row 1 Right",
    "MOD",
    "6",
    "7",
    "8",
    "9",
    "0",
    "MINUS",

    "// Row 2 Left",
    "TAB",
    "Q",
    "W",
    "E",
    "R",
    "T",
    "M1",

    "// Row 2 Right",
    "M3",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "BSLSH",

    "// Row 3 Left",
    "ESC",
    "A",
    "S",
    "D",
    "F",
    "G",
    "M2",

    "// Row 3 Center",
    "LCTRL",
    "LALT",
    "LWIN",
    "RCTRL",

    "// Row 3 Right",
    "M4",
    "H",
    "J",
    "K",
    "L",
    "SEMIC",
    "SQUOT",

    "// Row 4 Left",
    "LSHFT",
    "Z",
    "X",
    "C",
    "V",
    "B",

    "// Row 4 Center",
    "HOME",
    "PGUP",

    "// Row 4 Right",
    "N",
    "M",
    "COMMA",
    "DOT",
    "FSLSH",
    "RSHFT",

    "// Row 5 Left",
    "LFN",
    "BQUOT",
    "CAPS",
    "LEFT",
    "RIGHT",

    "// Row 5 Center",
    "BKSP",
    "DEL",
    "END",
    "PGDN",
    "ENTER",
    "SPACE",

    "// Row 5 Right",
    "UP",
    "DOWN",
    "LBRCE",
    "RBRCE",
    "RFN",
);

for (<STDIN>) {
    s/\/\/.*$//;
    push @allwords, split;    
}
my $token = shift(@allwords);

for (@labels) {
    if (m/^\/\//) {
        print "        $_\n";
        next;
    }
    printf("        /* %-5s */ %s", $_, $token);
    $token = shift(@allwords);
    last if !defined($token);
    while ($token !~ m/^&/) {
        print " $token";
        $token = shift(@allwords);
        last if !defined($token);
    }
    print "\n";
}
