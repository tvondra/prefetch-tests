set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/master-patched-728899ba.png'

set title "master vs. patched-728899ba"

set xlabel "master"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:20206.39]
set yrange[0:20206.39]

plot 'ryzen/master-patched-728899ba.data' using 1:2 w points, \
	[0:20206.39] x with lines
