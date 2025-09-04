set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-geoghegan-43ff7415-master.png'

set title "patched-geoghegan-43ff7415 vs. master"

set xlabel "patched-geoghegan-43ff7415"
set ylabel "master"
set view equal xy

set xrange[0:14105.91]
set yrange[0:14105.91]

unset colorbox
set nokey

plot 'xeon/patched-geoghegan-43ff7415-master.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:14105.91] x with lines
