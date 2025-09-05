set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/master-patched-geoghegan-2-3ded1b78.png'

set title "master vs. patched-geoghegan-2-3ded1b78"

set xlabel "master"
set ylabel "patched-geoghegan-2-3ded1b78"
set view equal xy

set xrange[0:42925.84]
set yrange[0:42925.84]

unset colorbox
set nokey

plot 'xeon/master-patched-geoghegan-2-3ded1b78.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:42925.84] x with lines
