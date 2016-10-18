#!/usr/bin/perl

use Image::Magick;

$filename = '/tmp/screen.png';
$sourceFile = '/home/bob/projects/personal/shakespeare/shakespeare.txt';

$random = int(rand(120000));
$randomEnd = $random + 100;

open(FILE, $sourceFile);
@lines = <FILE>;
close(FILE);

$text = join('', @lines[$random..$randomEnd]);

$image = Image::Magick->new;
$image->Set(size=>'960x1080');
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
$x = exec("feh --bg-tile $filename");
die $x if $x;

