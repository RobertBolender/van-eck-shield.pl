# Van Eck Shield

This project was inspired by Randy Waterhouse, as described in Neal Stephenson's novel Cryptonomicon.

I haven't worked on a real Perl project in over a year, but I wanted to write this in Perl because Randy wrote his in Perl.

Dependencies: feh

Note on usage: when run with cron, feh will give errors about not having access to X.
I was able to get it to work with this in my cron:

```
DISPLAY=:0.0 XAUTHORITY=/home/bob/.Xauthority /home/bob/van-eck-shield.pl
```

