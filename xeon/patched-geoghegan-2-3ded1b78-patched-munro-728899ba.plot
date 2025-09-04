set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-geoghegan-2-3ded1b78-patched-munro-728899ba.png'

set title "patched-geoghegan-2-3ded1b78 vs. patched-munro-728899ba"

set xlabel "patched-geoghegan-2-3ded1b78"
set ylabel "patched-munro-728899ba"
set view equal xy

set xrange[0:14023.53]
set yrange[0:14023.53]

unset colorbox
set nokey

plot 'xeon/patched-geoghegan-2-3ded1b78-patched-munro-728899ba.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:14023.53] x with lines
