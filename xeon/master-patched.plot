set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/master-patched.png'

set title "master vs. patched"

set xlabel "master"
set ylabel "patched"
set view equal xy

set xrange[0:44038.75]
set yrange[0:44038.75]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'xeon/master-patched.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:44038.75] x with lines
