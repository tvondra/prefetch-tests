set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/master-patched-geoghegan-2-3ded1b78.png'

set title "master vs. patched-geoghegan-2-3ded1b78"

set xlabel "master"
set ylabel "patched-geoghegan-2-3ded1b78"
set view equal xy

set xrange[0:14105.91]
set yrange[0:14105.91]

plot 'xeon/master-patched-geoghegan-2-3ded1b78.data' using 1:2 w points, \
	[0:14105.91] x with lines
