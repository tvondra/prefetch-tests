set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/master-patched-geoghegan-43ff7415.png'

set title "master vs. patched-geoghegan-43ff7415"

set xlabel "master"
set ylabel "patched-geoghegan-43ff7415"
set view equal xy

set xrange[0:20248.17]
set yrange[0:20248.17]

unset colorbox
set nokey

plot 'ryzen/master-patched-geoghegan-43ff7415.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:20248.17] x with lines
