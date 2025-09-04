set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-munro-43ff7415-master.png'

set title "patched-geoghegan-munro-43ff7415 vs. master"

set xlabel "patched-geoghegan-munro-43ff7415"
set ylabel "master"
set view equal xy

set xrange[0:20206.39]
set yrange[0:20206.39]

plot 'ryzen/patched-geoghegan-munro-43ff7415-master.data' using 1:2 w points, \
	[0:20206.39] x with lines
