set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-geoghegan-2-3ded1b78-patched-geoghegan-2-munro-3ded1b78.png'

set title "patched-geoghegan-2-3ded1b78 vs. patched-geoghegan-2-munro-3ded1b78"

set xlabel "patched-geoghegan-2-3ded1b78"
set ylabel "patched-geoghegan-2-munro-3ded1b78"
set view equal xy

set xrange[0:22690.36]
set yrange[0:22690.36]

unset colorbox
set nokey

plot 'xeon/patched-geoghegan-2-3ded1b78-patched-geoghegan-2-munro-3ded1b78.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:22690.36] x with lines
