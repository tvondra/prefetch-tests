set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-2-munro-3ded1b78-master.png'

set title "patched-geoghegan-2-munro-3ded1b78 vs. master"

set xlabel "patched-geoghegan-2-munro-3ded1b78"
set ylabel "master"
set view equal xy

set xrange[0:29824.87]
set yrange[0:29824.87]

unset colorbox
set nokey

plot 'ryzen/patched-geoghegan-2-munro-3ded1b78-master.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:29824.87] x with lines
