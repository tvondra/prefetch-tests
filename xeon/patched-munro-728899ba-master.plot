set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-munro-728899ba-master.png'

set title "patched-munro-728899ba vs. master"

set xlabel "patched-munro-728899ba"
set ylabel "master"
set view equal xy

set xrange[0:42925.84]
set yrange[0:42925.84]

unset colorbox
set nokey

plot 'xeon/patched-munro-728899ba-master.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:42925.84] x with lines
