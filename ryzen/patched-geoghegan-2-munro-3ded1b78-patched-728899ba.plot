set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-2-munro-3ded1b78-patched-728899ba.png'

set title "patched-geoghegan-2-munro-3ded1b78 vs. patched-728899ba"

set xlabel "patched-geoghegan-2-munro-3ded1b78"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:11283.19]
set yrange[0:11283.19]

unset colorbox
set nokey

plot 'ryzen/patched-geoghegan-2-munro-3ded1b78-patched-728899ba.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:11283.19] x with lines
