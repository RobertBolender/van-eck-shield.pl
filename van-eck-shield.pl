#!/usr/bin/perl
use strict;
use warnings;

use File::Spec;
use File::Basename;
use Image::Magick;

my $sourceDir = File::Spec->catdir(dirname(__FILE__), 'sources');
my @lines = `find $sourceDir -type f | xargs cat`;

my $random = int(rand(scalar @lines));
my $randomEnd = $random + 1000;

my $text = join('', @lines[$random..$randomEnd]);
$text =~ s/\n//g;
$text =~ s/  +/ /g;
$text =~ s/(.{500})/$1\n/g;

my $image = Image::Magick->new;
$image->Set(size=>'1980x1080');
$image->ReadImage('canvas:black');
$image->Colorize('#333');
$image->Annotate(
  font=>'/home/bob/.fonts/fira/FiraMono-Regular.ttf',
  pointsize=>16,
  fill=>'white',
  gravity=>'NorthWest',
  text=>$text
);

my $filename = '/tmp/screen.png';
open(IMAGE, ">$filename");
$image->Write(file=>\*IMAGE, filename=>"$filename");
close(IMAGE);
system("feh --bg-tile $filename");

