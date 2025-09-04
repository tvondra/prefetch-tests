set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-geoghegan-munro-43ff7415-patched-geoghegan-2-3ded1b78.png'

set title "patched-geoghegan-munro-43ff7415 vs. patched-geoghegan-2-3ded1b78"

set xlabel "patched-geoghegan-munro-43ff7415"
set ylabel "patched-geoghegan-2-3ded1b78"
set view equal xy

set xrange[0:14103.97]
set yrange[0:14103.97]

plot 'xeon/patched-geoghegan-munro-43ff7415-patched-geoghegan-2-3ded1b78.data' using 1:2 w points, \
	[0:14103.97] x with lines
