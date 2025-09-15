set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-old-patched.png'

set title "patched-old vs. patched"

set xlabel "patched-old"
set ylabel "patched"
set view equal xy

set xrange[0:42808.56]
set yrange[0:42808.56]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'xeon/patched-old-patched.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:42808.56] x with lines
