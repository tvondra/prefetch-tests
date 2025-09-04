set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen/patched-geoghegan-2-3ded1b78-patched-geoghegan-2-munro-3ded1b78.png'

set title "patched-geoghegan-2-3ded1b78 vs. patched-geoghegan-2-munro-3ded1b78"

set xlabel "patched-geoghegan-2-3ded1b78"
set ylabel "patched-geoghegan-2-munro-3ded1b78"
set view equal xy

set xrange[0:9656.08]
set yrange[0:9656.08]

plot 'ryzen/patched-geoghegan-2-3ded1b78-patched-geoghegan-2-munro-3ded1b78.data' using 1:2 w points, \
	[0:9656.08] x with lines
