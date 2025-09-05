set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-728899ba-patched-geoghegan-43ff7415.png'

set title "patched-728899ba vs. patched-geoghegan-43ff7415"

set xlabel "patched-728899ba"
set ylabel "patched-geoghegan-43ff7415"
set view equal xy

set xrange[0:23311.48]
set yrange[0:23311.48]

unset colorbox
set nokey

plot 'xeon/patched-728899ba-patched-geoghegan-43ff7415.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:23311.48] x with lines
