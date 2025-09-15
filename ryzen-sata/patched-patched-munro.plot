set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen-sata/patched-patched-munro.png'

set title "patched vs. patched-munro"

set xlabel "patched"
set ylabel "patched-munro"
set view equal xy

set xrange[0:49338.56]
set yrange[0:49338.56]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'ryzen-sata/patched-patched-munro.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:49338.56] x with lines
