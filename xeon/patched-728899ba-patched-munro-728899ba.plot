set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-728899ba-patched-munro-728899ba.png'

set title "patched-728899ba vs. patched-munro-728899ba"

set xlabel "patched-728899ba"
set ylabel "patched-munro-728899ba"
set view equal xy

set xrange[0:15339.83]
set yrange[0:15339.83]

plot 'xeon/patched-728899ba-patched-munro-728899ba.data' using 1:2 w points, \
	[0:15339.83] x with lines
