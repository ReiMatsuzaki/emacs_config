set term postscript eps enhanced color
set output ""

set size 0.5,0.5
set grid

  plot "basis1.dat" u 1:2 w l ti "{/Symbol z}_1" lt 1 lc 1
replot "basis2.dat" u 1:2 w l ti "{/Symbol z}_2" lt 1 lc 2
replot "basis3.dat" u 1:2 w l ti "{/Symbol z}_3" lt 1 lc 3
replot "basis4.dat" u 1:2 w l ti "{/Symbol z}_4" lt 1 lc 4
replot "basis5.dat" u 1:2 w l ti "{/Symbol z}_5" lt 1 lc 5
replot "psi0.1.dat" u 1:(-$2) w l ti "CBF"       lc rgb "black" 

set term postscript eps enhanced color
set output ""
replot