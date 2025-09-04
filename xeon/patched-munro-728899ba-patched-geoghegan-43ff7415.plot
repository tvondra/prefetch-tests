set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-munro-728899ba-patched-geoghegan-43ff7415.png'

set title "patched-munro-728899ba vs. patched-geoghegan-43ff7415"

set xlabel "patched-munro-728899ba"
set ylabel "patched-geoghegan-43ff7415"
set view equal xy

set xrange[0:14045.09]
set yrange[0:14045.09]

plot 'xeon/patched-munro-728899ba-patched-geoghegan-43ff7415.data' using 1:2 w points, \
	[0:14045.09] x with lines
