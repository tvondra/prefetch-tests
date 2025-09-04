set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-munro-43ff7415-patched-728899ba.png'

set title "patched-geoghegan-munro-43ff7415 vs. patched-728899ba"

set xlabel "patched-geoghegan-munro-43ff7415"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:20126.67]
set yrange[0:20126.67]

plot 'ryzen/patched-geoghegan-munro-43ff7415-patched-728899ba.data' using 1:2 w points, \
	[0:20126.67] x with lines
