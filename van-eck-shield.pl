#!/usr/bin/perl

use Image::Magick;

$filename = '/tmp/screen.png';
$fileTree = '/home/bob/Downloads/Programs/i3';

$randomFile = `find $fileTree -type f | shuf -n 1`;

open(FILE, $randomFile);
$/ = undef;
$text = <FILE>;
close(FILE);

$image = Image::Magick->new;
$image->Set(size=>'1920x1080');
$image->ReadImage('canvas:black');
$image->Annotate(
  font=>'/home/bob/.fonts/fira/FiraMono-Regular.ttf',
  pointsize=>24,
  fill=>'white',
  gravity=>'NorthWest',
  text=>$text
);

open(IMAGE, ">$filename");
$x = $image->Write(file=>\*IMAGE, filename=>"$filename");
close(IMAGE);
die $x if $x;
$x = exec("feh --bg-max $filename");
die $x if $x;

