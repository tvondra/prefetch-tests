set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-728899ba-patched-munro-728899ba.png'

set title "patched-728899ba vs. patched-munro-728899ba"

set xlabel "patched-728899ba"
set ylabel "patched-munro-728899ba"
set view equal xy

set xrange[0:9637.58]
set yrange[0:9637.58]

unset colorbox
set nokey

plot 'ryzen/patched-728899ba-patched-munro-728899ba.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:9637.58] x with lines
