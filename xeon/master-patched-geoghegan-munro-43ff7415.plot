set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/master-patched-geoghegan-munro-43ff7415.png'

set title "master vs. patched-geoghegan-munro-43ff7415"

set xlabel "master"
set ylabel "patched-geoghegan-munro-43ff7415"
set view equal xy

set xrange[0:14105.91]
set yrange[0:14105.91]

unset colorbox
set nokey

plot 'xeon/master-patched-geoghegan-munro-43ff7415.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:14105.91] x with lines
