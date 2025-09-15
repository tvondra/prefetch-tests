set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen-sata/master-patched-old.png'

set title "master vs. patched-old"

set xlabel "master"
set ylabel "patched-old"
set view equal xy

set xrange[0:53721.71]
set yrange[0:53721.71]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'ryzen-sata/master-patched-old.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:53721.71] x with lines
