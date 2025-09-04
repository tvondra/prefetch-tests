set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-2-3ded1b78-master.png'

set title "patched-geoghegan-2-3ded1b78 vs. master"

set xlabel "patched-geoghegan-2-3ded1b78"
set ylabel "master"
set view equal xy

set xrange[0:20206.39]
set yrange[0:20206.39]

plot 'ryzen/patched-geoghegan-2-3ded1b78-master.data' using 1:2 w points, \
	[0:20206.39] x with lines
