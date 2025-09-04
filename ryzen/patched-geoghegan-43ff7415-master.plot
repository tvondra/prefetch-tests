set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-43ff7415-master.png'

set title "patched-geoghegan-43ff7415 vs. master"

set xlabel "patched-geoghegan-43ff7415"
set ylabel "master"
set view equal xy

set xrange[0:20248.17]
set yrange[0:20248.17]

unset colorbox
set nokey

plot 'ryzen/patched-geoghegan-43ff7415-master.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:20248.17] x with lines
