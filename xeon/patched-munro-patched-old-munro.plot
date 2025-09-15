set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output 'xeon/patched-munro-patched-old-munro.png'

set title "patched-munro vs. patched-old-munro"

set xlabel "patched-munro"
set ylabel "patched-old-munro"
set view equal xy

set xrange[0:19231.48]
set yrange[0:19231.48]


set palette color
set view map
#set palette rgbformulae 7,5,15
set palette model HSV rgbformulae 3,2,2

# set logscale xy

unset colorbox
set nokey

plot 'xeon/patched-munro-patched-old-munro.data' using 1:2:3 w points pt 7 ps 0.75 palette, \
	[0:19231.48] x with lines
