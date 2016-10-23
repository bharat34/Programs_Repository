#!/bin/bash
#
# Make sure "xmgrace" is in user's PATH
#
export PATH=/usr/local/grace/5.1.22/grace/bin:${PATH}
export LD_LIBRARY_PATH=/home/blakhani/apps/lib:${LD_LIBRARY_PATH}
#
#  initial snapshot (1)
#
tzerosnp=1
#
# Arguments 1 and 2:
#  names of the ".dat" files containing RMSD data
#
datafirst=${1}
grfilename=${1%-1st.dat}
dataavg=${2}
#
#  maxrms - maximum RMS, i.e. Y axis scale
#
maxrms=$(awk '
BEGIN { Nval=0 ; sum=0 }
{
 while ($1 ~ /^#/) { getline }
 Nval++
 val=$2
 sum=sum+val
 if (Nval == 1) { max=val }
 else if (val >= max) { max=val }
}
END {
 mean=sum/Nval
 if ( 2*mean >= max+2 ) {
   printf("%.6f\n",2*mean)
   }
 else {
   printf("%.6f\n",max+2)
   }
}' ${datafirst})
#
# Read number of snapshots (from first data file)
#
nosnp=$(cat ${datafirst} | wc -l)
#
# Set axis limits for the graph
#
xstart=${tzerosnp}
xend=${nosnp}
ystart=0
yend=${maxrms}
xrange=`printf "%10.3f" $(echo "${xend} - ${xstart}" | bc -l)`
yrange=`printf "%10.3f" $(echo "${yend} - ${ystart}" | bc -l)`
#
# Set major tick interval
#
xmajtk=`printf "%8.0f\n" $(echo "${xrange} / 10" | bc -l) | bc -l`
ymajtk="0.5"
if [[ range -gt 5 ]] 
  then ymajtk="1.0"
fi
#
#
# Run Grace
#
cat - <<EOF> ${grfilename}.par
# Grace project file
#
version 50116
page size 792, 612
device "EPS" op "bbox:page"
device "PNG" page size 3300, 2550
device "PNG" dpi 300
device "PNG" font antialiasing on
device "PNG" op "compression:2"
device "PNG" op "transparent:off"
device "PNG" op "interlaced:off"
page scroll 5%
page inout 5%
link page off
map font 0 to "Times-Roman", "Times-Roman"
map font 1 to "Times-Italic", "Times-Italic"
map font 2 to "Times-Bold", "Times-Bold"
map font 3 to "Times-BoldItalic", "Times-BoldItalic"
map font 4 to "Helvetica", "Helvetica"
map font 5 to "Helvetica-Oblique", "Helvetica-Oblique"
map font 6 to "Helvetica-Bold", "Helvetica-Bold"
map font 7 to "Helvetica-BoldOblique", "Helvetica-BoldOblique"
map font 8 to "Courier", "Courier"
map font 9 to "Courier-Oblique", "Courier-Oblique"
map font 10 to "Courier-Bold", "Courier-Bold"
map font 11 to "Courier-BoldOblique", "Courier-BoldOblique"
map font 12 to "Symbol", "Symbol"
map font 13 to "ZapfDingbats", "ZapfDingbats"
map color 0 to (255, 255, 255), "white"
map color 1 to (0, 0, 0), "black"
map color 2 to (129, 7, 169), "purple"
map color 3 to (0, 139, 0), "green4"
map color 4 to (204, 0, 102), "red-pink"
map color 5 to (2, 102, 123), "blue-green"
#map color 2 to (255, 0, 0), "red"
#map color 3 to (0, 255, 0), "green"
#map color 4 to (0, 0, 255), "blue"
#map color 5 to (255, 255, 0), "yellow"
map color 6 to (188, 143, 143), "brown"
map color 7 to (220, 220, 220), "grey"
map color 8 to (148, 0, 211), "violet"
map color 9 to (0, 255, 255), "cyan"
map color 10 to (255, 0, 255), "magenta"
map color 11 to (255, 165, 0), "orange"
map color 12 to (114, 33, 188), "indigo"
map color 13 to (103, 7, 72), "maroon"
map color 14 to (64, 224, 208), "turquoise"
map color 15 to (0, 139, 0), "green4"
reference date 0
date wrap off
date wrap year 1950
default linewidth 1.0
default linestyle 1
default color 1
default pattern 1
default font 0
default char size 1.000000
default symbol size 1.000000
default sformat "%.8g"
background color 0
page background fill on
timestamp off
timestamp 0.03, 0.03
timestamp color 1
timestamp rot 0
timestamp font 0
timestamp char size 1.000000
timestamp def "Sat Feb 14 02:09:54 2009"
r0 off
link r0 to g0
r0 type above
r0 linestyle 1
r0 linewidth 1.0
r0 color 1
r0 line 0, 0, 0, 0
r1 off
link r1 to g0
r1 type above
r1 linestyle 1
r1 linewidth 1.0
r1 color 1
r1 line 0, 0, 0, 0
r2 off
link r2 to g0
r2 type above
r2 linestyle 1
r2 linewidth 1.0
r2 color 1
r2 line 0, 0, 0, 0
r3 off
link r3 to g0
r3 type above
r3 linestyle 1
r3 linewidth 1.0
r3 color 1
r3 line 0, 0, 0, 0
r4 off
link r4 to g0
r4 type above
r4 linestyle 1
r4 linewidth 1.0
r4 color 1
r4 line 0, 0, 0, 0
g0 on
g0 hidden false
g0 type XY
g0 stacked false
g0 bar hgap 0.000000
g0 fixedpoint off
g0 fixedpoint type 0
g0 fixedpoint xy 0.000000, 0.000000
g0 fixedpoint format general general
g0 fixedpoint prec 6, 6
with g0
    world ${xstart}, ${ystart}, ${xend}, ${yend}
    stack world 0, 0, 0, 0
    znorm 1
    view 0.150000, 0.150000, 1.150000, 0.850000
    title ""
    title font 4
    title size 0.750000
    title color 1
    subtitle "1D-RMSD"
    subtitle font 4
    subtitle size 0.850000
    subtitle color 1
    xaxes scale Normal
    yaxes scale Normal
    xaxes invert off
    yaxes invert off
    xaxis  on
    xaxis  type zero false
    xaxis  offset 0.000000 , 0.000000
    xaxis  bar on
    xaxis  bar color 1
    xaxis  bar linestyle 1
    xaxis  bar linewidth 1.0
    xaxis  label "Snaphsot number"
    xaxis  label layout para
    xaxis  label place spec
    xaxis  label place 0.000000, 0.070000
    xaxis  label char size 0.750000
    xaxis  label font 4
    xaxis  label color 1
    xaxis  label place normal
    xaxis  tick on
    xaxis  tick major ${xmajtk}
    xaxis  tick minor ticks 9
    xaxis  tick default 6
    xaxis  tick place rounded true
    xaxis  tick in
    xaxis  tick major size 0.500000
    xaxis  tick major color 1
    xaxis  tick major linewidth 1.0
    xaxis  tick major linestyle 1
    xaxis  tick major grid off
    xaxis  tick minor color 1
    xaxis  tick minor linewidth 1.0
    xaxis  tick minor linestyle 1
    xaxis  tick minor grid off
    xaxis  tick minor size 0.250000
    xaxis  ticklabel on
    xaxis  ticklabel format general
    xaxis  ticklabel prec 5
    xaxis  ticklabel formula ""
    xaxis  ticklabel append ""
    xaxis  ticklabel prepend ""
    xaxis  ticklabel angle 0
    xaxis  ticklabel skip 0
    xaxis  ticklabel stagger 0
    xaxis  ticklabel place normal
    xaxis  ticklabel offset auto
    xaxis  ticklabel offset 0.000000 , 0.010000
    xaxis  ticklabel start type auto
    xaxis  ticklabel start 0.000000
    xaxis  ticklabel stop type auto
    xaxis  ticklabel stop 0.000000
    xaxis  ticklabel char size 0.750000
    xaxis  ticklabel font 4
    xaxis  ticklabel color 1
    xaxis  tick place both
    xaxis  tick spec type none
    yaxis  on
    yaxis  type zero false
    yaxis  offset 0.000000 , 0.000000
    yaxis  bar on
    yaxis  bar color 1
    yaxis  bar linestyle 1
    yaxis  bar linewidth 1.0
    yaxis  label "RMSD (�) "
    yaxis  label layout para
    yaxis  label place spec
    yaxis  label place 0.000000, 0.085000
    yaxis  label char size 0.750000
    yaxis  label font 4
    yaxis  label color 1
    yaxis  label place normal
    yaxis  tick on
    yaxis  tick major ${ymajtk}
    yaxis  tick minor ticks 4
    yaxis  tick default 6
    yaxis  tick place rounded true
    yaxis  tick in
    yaxis  tick major size 0.500000
    yaxis  tick major color 1
    yaxis  tick major linewidth 1.0
    yaxis  tick major linestyle 1
    yaxis  tick major grid off
    yaxis  tick minor color 1
    yaxis  tick minor linewidth 1.0
    yaxis  tick minor linestyle 1
    yaxis  tick minor grid off
    yaxis  tick minor size 0.250000
    yaxis  ticklabel on
    yaxis  ticklabel format decimal
    yaxis  ticklabel prec 1
    yaxis  ticklabel formula ""
    yaxis  ticklabel append ""
    yaxis  ticklabel prepend ""
    yaxis  ticklabel angle 0
    yaxis  ticklabel skip 0
    yaxis  ticklabel stagger 0
    yaxis  ticklabel place normal
    yaxis  ticklabel offset auto
    yaxis  ticklabel offset 0.000000 , 0.010000
    yaxis  ticklabel start type auto
    yaxis  ticklabel start 0.000000
    yaxis  ticklabel stop type auto
    yaxis  ticklabel stop 0.000000
    yaxis  ticklabel char size 0.750000
    yaxis  ticklabel font 4
    yaxis  ticklabel color 1
    yaxis  tick place both
    yaxis  tick spec type none
    altxaxis  off
    altyaxis  off
    legend on
    legend loctype view
    legend 0.89, 0.83
    legend box color 1
    legend box pattern 1
    legend box linewidth 1.0
    legend box linestyle 0
    legend box fill color 0
    legend box fill pattern 1
    legend font 4
    legend char size 0.650000
    legend color 1
    legend length 3
    legend vgap 1
    legend hgap 1
    legend invert false
    frame type 0
    frame linestyle 1
    frame linewidth 1.0
    frame color 1
    frame pattern 1
    frame background color 0
    frame background pattern 0
    s0 hidden false
    s0 type xy
    s0 symbol 0
    s0 symbol size 1.000000
    s0 symbol color 1
    s0 symbol pattern 1
    s0 symbol fill color 1
    s0 symbol fill pattern 0
    s0 symbol linewidth 1.0
    s0 symbol linestyle 1
    s0 symbol char 65
    s0 symbol char font 0
    s0 symbol skip 0
    s0 line type 1
    s0 line linestyle 1
    s0 line linewidth 1.0
    s0 line color 1
    s0 line pattern 1
    s0 baseline type 0
    s0 baseline off
    s0 dropline off
    s0 fill type 0
    s0 fill rule 0
    s0 fill color 1
    s0 fill pattern 1
    s0 avalue off
    s0 avalue type 2
    s0 avalue char size 1.000000
    s0 avalue font 0
    s0 avalue color 1
    s0 avalue rot 0
    s0 avalue format general
    s0 avalue prec 3
    s0 avalue prepend ""
    s0 avalue append ""
    s0 avalue offset 0.000000 , 0.000000
    s0 errorbar on
    s0 errorbar place both
    s0 errorbar color 1
    s0 errorbar pattern 1
    s0 errorbar size 1.000000
    s0 errorbar linewidth 1.0
    s0 errorbar linestyle 1
    s0 errorbar riser linewidth 1.0
    s0 errorbar riser linestyle 1
    s0 errorbar riser clip off
    s0 errorbar riser clip length 0.100000
    s0 comment "${datafirst}"
    s0 legend  "RMSD w.r.t. first"
    s1 hidden false
    s1 type xy
    s1 symbol 0
    s1 symbol size 1.000000
    s1 symbol color 2
    s1 symbol pattern 1
    s1 symbol fill color 2
    s1 symbol fill pattern 0
    s1 symbol linewidth 1.0
    s1 symbol linestyle 1
    s1 symbol char 65
    s1 symbol char font 0
    s1 symbol skip 0
    s1 line type 1
    s1 line linestyle 1
    s1 line linewidth 1.0
    s1 line color 2
    s1 line pattern 1
    s1 baseline type 0
    s1 baseline off
    s1 dropline off
    s1 fill type 0
    s1 fill rule 0
    s1 fill color 1
    s1 fill pattern 1
    s1 avalue off
    s1 avalue type 2
    s1 avalue char size 1.000000
    s1 avalue font 0
    s1 avalue color 1
    s1 avalue rot 0
    s1 avalue format general
    s1 avalue prec 3
    s1 avalue prepend ""
    s1 avalue append ""
    s1 avalue offset 0.000000 , 0.000000
    s1 errorbar on
    s1 errorbar place both
    s1 errorbar color 1
    s1 errorbar pattern 1
    s1 errorbar size 1.000000
    s1 errorbar linewidth 1.0
    s1 errorbar linestyle 1
    s1 errorbar riser linewidth 1.0
    s1 errorbar riser linestyle 1
    s1 errorbar riser clip off
    s1 errorbar riser clip length 0.100000
    s1 comment "${dataavg}"
    s1 legend  "RMSD w.r.t. average"
EOF
#
# Run Grace
#
gracebat \
  -graph 0 ${datafirst} \
  -graph 0 ${dataavg} \
  -hdevice PNG -print ${grfilename}.png -param ${grfilename}.par \
  -hardcopy -saveall ${grfilename}.agr 

rm ${grfilename}.par 
