set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-geoghegan-2-3ded1b78-patched-728899ba.png'

set title "patched-geoghegan-2-3ded1b78 vs. patched-728899ba"

set xlabel "patched-geoghegan-2-3ded1b78"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:15339.83]
set yrange[0:15339.83]

plot 'xeon/patched-geoghegan-2-3ded1b78-patched-728899ba.data' using 1:2 w points, \
	[0:15339.83] x with lines
