#!/usr/bin/perl

use Image::Magick;

$filename = '/tmp/screen.png';

$randomFile = `find -type f | shuf -n 1`;
open(FILE, $randomFile);
$/ = undef;
$text = <FILE>;
print $text;
close(FILE);

$image = Image::Magick->new;
$image->Set(size=>'900x500');
$image->ReadImage('canvas:black');
$image->Annotate(
  font=>'/home/bob/.fonts/fira/FiraMono-Bold.ttf',
  pointsize=>30,
  fill=>'white',
  gravity=>'NorthWest',
  text=>$text
);

open(IMAGE, ">$filename");
$image->Write(file=>\*IMAGE, filename=>"$filename");
close(IMAGE);
system("feh --bg-max /tmp/screen.png");

