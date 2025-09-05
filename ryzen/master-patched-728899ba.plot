set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/master-patched-728899ba.png'

set title "master vs. patched-728899ba"

set xlabel "master"
set ylabel "patched-728899ba"
set view equal xy

set xrange[0:29824.87]
set yrange[0:29824.87]

unset colorbox
set nokey

plot 'ryzen/master-patched-728899ba.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:29824.87] x with lines
