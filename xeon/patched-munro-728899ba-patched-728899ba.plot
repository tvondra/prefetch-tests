set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-munro-728899ba-patched-728899ba.png'

set title "patched-munro-728899ba vs. patched-728899ba"

set xlabel "patched-munro-728899ba"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:15339.83]
set yrange[0:15339.83]

unset colorbox
set nokey

plot 'xeon/patched-munro-728899ba-patched-728899ba.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:15339.83] x with lines
