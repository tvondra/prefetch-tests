set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen-sata/patched-munro-patched-old.png'

set title "patched-munro vs. patched-old"

set xlabel "patched-munro"
set ylabel "patched-old"
set view equal xy

set xrange[0:44670.68]
set yrange[0:44670.68]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'ryzen-sata/patched-munro-patched-old.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:44670.68] x with lines
