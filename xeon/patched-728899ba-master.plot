set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-728899ba-master.png'

set title "patched-728899ba vs. master"

set xlabel "patched-728899ba"
set ylabel "master"
set view equal xy

set xrange[0:15339.83]
set yrange[0:15339.83]

plot 'xeon/patched-728899ba-master.data' using 1:2 w points, \
	[0:15339.83] x with lines
