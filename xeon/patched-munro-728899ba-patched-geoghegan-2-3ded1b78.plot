set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-munro-728899ba-patched-geoghegan-2-3ded1b78.png'

set title "patched-munro-728899ba vs. patched-geoghegan-2-3ded1b78"

set xlabel "patched-munro-728899ba"
set ylabel "patched-geoghegan-2-3ded1b78"
set view equal xy

set xrange[0:14023.53]
set yrange[0:14023.53]

plot 'xeon/patched-munro-728899ba-patched-geoghegan-2-3ded1b78.data' using 1:2 w points, \
	[0:14023.53] x with lines
