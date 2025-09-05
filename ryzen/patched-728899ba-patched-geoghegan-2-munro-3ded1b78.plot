set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-728899ba-patched-geoghegan-2-munro-3ded1b78.png'

set title "patched-728899ba vs. patched-geoghegan-2-munro-3ded1b78"

set xlabel "patched-728899ba"
set ylabel "patched-geoghegan-2-munro-3ded1b78"
set view equal xy

set xrange[0:11283.19]
set yrange[0:11283.19]

unset colorbox
set nokey

plot 'ryzen/patched-728899ba-patched-geoghegan-2-munro-3ded1b78.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:11283.19] x with lines
