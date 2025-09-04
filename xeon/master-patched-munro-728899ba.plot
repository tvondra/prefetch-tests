set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/master-patched-munro-728899ba.png'

set title "master vs. patched-munro-728899ba"

set xlabel "master"
set ylabel "patched-munro-728899ba"
set view equal xy

set xrange[0:14105.91]
set yrange[0:14105.91]

plot 'xeon/master-patched-munro-728899ba.data' using 1:2 w points, \
	[0:14105.91] x with lines
