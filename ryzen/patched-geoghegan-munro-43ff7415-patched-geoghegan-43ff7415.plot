set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-munro-43ff7415-patched-geoghegan-43ff7415.png'

set title "patched-geoghegan-munro-43ff7415 vs. patched-geoghegan-43ff7415"

set xlabel "patched-geoghegan-munro-43ff7415"
set ylabel "patched-geoghegan-43ff7415"
set view equal xy

set xrange[0:20248.17]
set yrange[0:20248.17]

plot 'ryzen/patched-geoghegan-munro-43ff7415-patched-geoghegan-43ff7415.data' using 1:2 w points, \
	[0:20248.17] x with lines
