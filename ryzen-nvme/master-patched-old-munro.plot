set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'ryzen-nvme/master-patched-old-munro.png'

set title "master vs. patched-old-munro"

set xlabel "master"
set ylabel "patched-old-munro"
set view equal xy

set xrange[0:28892.29]
set yrange[0:28892.29]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'ryzen-nvme/master-patched-old-munro.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:28892.29] x with lines
