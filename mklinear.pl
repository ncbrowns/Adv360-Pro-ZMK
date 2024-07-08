#!/usr/bin/env perl
#
# mklinear.pl:  Perl script to convert a copy-pasted Advantage360 ZMK keymap
# to a line-per-key entry with comments describing the original key layout.
#
use strict;
use warnings;

my @labels360 = (
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
    "LBRKT",
    "RBRKT",
    "RFN",
);

my @labelsg80 = (
    "// Row 1 Left",
    "F1",
    "F2",
    "F3",
    "F4",
    "F5",
    "// Row 1 Right",
    "F6",
    "F7",
    "F8",
    "F9",
    "F10",
    "// Row 2 Left",
    "EQUAL",
    "1",
    "2",
    "3",
    "4",
    "5",
    "// Row 2 Right",
    "6",
    "7",
    "8",
    "9",
    "0",
    "MINUS",
    "// Row 3 Left",
    "TAB",
    "Q",
    "W",
    "E",
    "R",
    "T",
    "// Row 3 Right",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "BSLSH",
    "// Row 4 Left",
    "ESC",
    "A",
    "S",
    "D",
    "F",
    "G",
    "// Row 4 Right",
    "H",
    "J",
    "K",
    "L",
    "SEMI",
    "SQUOT",
    "// Row 5 Left",
    "BQUOT",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "// Row 5 Thumb",
    "LSHFT",
    "LCTRL",
    "LOWER",
    "LGUI",
    "RCTRL",
    "RSHFT",
    "// Row 5 Right",
    "N",
    "M",
    "COMMA",
    "DOT",
    "FSLSH",
    "PGUP",
    "// Row 6 Left",
    "MAGIC",
    "HOME",
    "END",
    "LEFT",
    "RIGHT",
    "// Row 6 Thumb",
    "BKSP",
    "DEL",
    "LALT",
    "RALT",
    "ENTER",
    "SPACE",
    "// Row 6 Right",
    "UP",
    "DOWN",
    "LBRKT",
    "RBRKT",
    "PGDN",
);

my $labelref = \@labels360;

if (@ARGV >= 1 && $ARGV[0] =~ m/^(adv(antage)360|glove80)$/i) {
    $labelref = \@labelsg80 if $ARGV[0] =~ m/^glove80$/i;
    shift @ARGV;
}
if (@ARGV > 1) {
    print "syntax:  perl mklinear.pl [adv360|advantage360|glove80] <keymap>\n";
    print "(adv360 is the default)\n";
    exit 1;
}

while (<>) {
    if (m/^(\s*)bindings\s*=\s*<\s*$/) {
        my @allbindings;
        my $indent = $1 . "  ";
        print;
        while (<>) {
            if (m/^\s*>\s*;$/) {
                my $token = shift(@allbindings);
                for (@{$labelref}) {
                    if (m/^\/\//) {
                        print "$indent$_\n";
                        next;
                    }
                    printf("%s/* %-5s */ %s", $indent, $_, $token);
                    $token = shift(@allbindings);
                    if (!defined($token)) {
                        print "\n";
                        last;
                    }
                    while ($token !~ m/^&/) {
                        print " $token";
                        $token = shift(@allbindings);
                        last if !defined($token);
                    }
                    print "\n";
                }

                print;
                last;
            }
            s/\/\/.*$//;
            s/\/\*.*\*\///g;
            push @allbindings, split;    
        }
        next;
    }
    print;
}
