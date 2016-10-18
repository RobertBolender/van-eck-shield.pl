#!/usr/bin/perl
use strict;
use warnings;

use Image::Magick;

my $filename = '/tmp/screen.png';
my $sourceFile = '/home/bob/projects/personal/shakespeare/shakespeare.txt';

my $random = int(rand(120000));
my $randomEnd = $random + 1000;

open(FILE, $sourceFile);
my @lines = <FILE>;
close(FILE);

my $text = join('', @lines[$random..$randomEnd]);
$text =~ s/\n//g;
$text =~ s/  +/ /g;
$text =~ s/(.{500})/$1\n/g;

my $image = Image::Magick->new;
$image->Set(size=>'960x1080');
$image->ReadImage('canvas:black');
$image->Colorize('#333');
$image->Annotate(
  font=>'/home/bob/.fonts/fira/FiraMono-Regular.ttf',
  pointsize=>16,
  fill=>'white',
  gravity=>'NorthWest',
  text=>$text
);

open(IMAGE, ">$filename");
$image->Write(file=>\*IMAGE, filename=>"$filename");
close(IMAGE);
system("feh --bg-tile $filename");

