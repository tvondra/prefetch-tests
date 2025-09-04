set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-43ff7415-patched-munro-728899ba.png'

set title "patched-geoghegan-43ff7415 vs. patched-munro-728899ba"

set xlabel "patched-geoghegan-43ff7415"
set ylabel "patched-munro-728899ba"
set view equal xy

set xrange[0:20248.17]
set yrange[0:20248.17]

plot 'ryzen/patched-geoghegan-43ff7415-patched-munro-728899ba.data' using 1:2 w points, \
	[0:20248.17] x with lines
