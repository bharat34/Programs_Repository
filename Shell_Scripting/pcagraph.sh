#!/bin/bash
###################################################
#                                                 #
# pcagraph - creates a graph that shows the       #
#            projection of snapshots onto two     #
#            principal components of the          #
#            covariance matrix. Run without       #
#            arguments to see help message.       #
#                                                 #
#     Bharat Lakhani                              #
#     Wesleyan University                         #
#                                                 #
#     **** June 2014 ****                         #
#                                                 #
###################################################
#                                                 #
# Adjust this parameter if needed.                #
#                                                 #
# Snapshots taken at the following time interval  #
#  in nanoseconds.                                #
#snaptime=0.0020                                    
#                                                 #
# No need to change anything else below this line #
#                                                 #
###################################################
#
# Make sure "xmgrace" is in user's PATH
#
if [ "$(uname -s)" == "Linux" ] ; then
  export PATH=/home/blakhani/apps/grace/5.1.22/grace/bin:${PATH}
  export LD_LIBRARY_PATH=/home/blakhani/apps/lib:${LD_LIBRARY_PATH}
  fi
#
###################################################
#                                                 #
# Help message                                    #
#                                                 #
###################################################
if [ $# -lt 3 ] || [ $# -gt 5 ] ; then
  echo ""
  echo "pcagraph - creates a graph that shows the projection of"
  echo "           snapshots onto two principal components, i and j,"
  echo "           of the covariance matrix."
  echo ""
  echo " Usage:"
  echo "   pcagraph.sh datfile PC-i PC-j [ height half-width ]"
  echo ""
  echo "   datfile - data file with projection of snapshots onto PC"
  echo "   mode-i  - principal component i (just the number, i)"
  echo "   mode-j  - principal component j (just the number, j)"
  echo ""
  echo "   Optional graph parameters:"
  echo "     height - height of the histograms (default is to auto set)"
  echo "     half-width - 1/2 the width of X axes in histograms, so"
  echo "                  X axis span from -(half-width) to +(half-width)."
  echo "                  Default value is 200."
  echo ""
  exit 0
fi
###################################################
#
# Argument 1: Projection data file
#
datfile=${1}
#
# Arguments 2 and 3: modes
#
modei=${2}
modej=${3}
columni="`expr ${2} + 1`"
columnj="`expr ${3} + 1`"
#
# Axis limits (extra "hidden" feature)
#
# Histogram height axis (Argument 4, maximum value,
#  otherwise, use 0.04 first then autoset maximum value)
#
pmin=0
if [ "${4}" == "" ] ; then
  pmax=0.04
  doautop="y"
else
  pmax=${4}
  doautop="n"
  fi
#
# Tick labels every 1/2 of the maximum value
#
ptick=$(printf "%.5f" $(echo "${pmax} / 2" | bc -l))
#
# Span of snapshot projection (Argument 5, -span to +span,
#  otherwise default to 200)
#
if [ "${5}" == "" ] ; then
  projspan=200
else
  projspan=${5}
  fi
#
# Make axes X = Y and centered at 0 with +/- span of projections
#
xstart="-${projspan}"
xend="${projspan}"
ystart="${xstart}"
yend="${xend}"
tickmarks=$(printf "%.0f" $(echo "${projspan} / 4" | bc -l))
#
# Comment out the first two lines of the projections file
#
sed -iorig 's/^Projection/#Projection/' ${datfile}
sed -iorig 's/^  Snapshot/#  Snapshot/' ${datfile}
rm ${datfile}orig
#
# Count the number of snapshots (number of uncommented
#  lines in projection file)
#
Nsnaps=$(grep -v "#" ${datfile} | wc -l)
#
# Snapshot blocks for PCA plot coloring (8-color spectrum)
#  (and time blocks)
#
snapblock=$(printf "%.0f" `echo "${Nsnaps} / 8 + 0.25" | bc -l`)
#
# Conversion to time in ns
#
if [ "${snaptime}" != "" ] ; then
  Stime=$(echo "${Nsnaps} * ${snaptime}" | bc -l)
  legendt1="$(printf "%.2f-%.2f ns" "0.00" "$(echo "$((${snapblock} * 1)) * ${snaptime}" | bc -l)")"
  legendt2="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 1 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 2)) * ${snaptime}" | bc -l)")"
  legendt3="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 2 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 3)) * ${snaptime}" | bc -l)")"
  legendt4="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 3 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 4)) * ${snaptime}" | bc -l)")"
  legendt5="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 4 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 5)) * ${snaptime}" | bc -l)")"
  legendt6="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 5 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 6)) * ${snaptime}" | bc -l)")"
  legendt7="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 6 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 7)) * ${snaptime}" | bc -l)")"
  legendt8="$(printf "%.2f-%.2f ns" "$(echo "$((${snapblock} * 7 + 1)) * ${snaptime}" | bc -l)" "$(echo "$((${snapblock} * 8)) * ${snaptime}" | bc -l)")"
else
  legendt1="1 - $((${snapblock} * 1))"
  legendt2="$((${snapblock} * 1 + 1)) - $((${snapblock} * 2))"
  legendt3="$((${snapblock} * 2 + 1)) - $((${snapblock} * 3))"
  legendt4="$((${snapblock} * 3 + 1)) - $((${snapblock} * 4))"
  legendt5="$((${snapblock} * 4 + 1)) - $((${snapblock} * 5))"
  legendt6="$((${snapblock} * 5 + 1)) - $((${snapblock} * 6))"
  legendt7="$((${snapblock} * 6 + 1)) - $((${snapblock} * 7))"
  legendt8="$((${snapblock} * 7 + 1)) - $((${snapblock} * 8))"
  fi
#
# delete any temporary files (if they exist)
#
rm -f .tmp.${datfile%.dat}.agr .tmp.${datfile%.dat}-2.agr .tmp.${datfile%.dat}.par \
      .tmp.${datfile%.dat}.png ${datfile%.dat}.temp.*.dat ${datfile%.dat}_PC_${modei}-${modej}.agr \
      .tmp.pmax ${datfile%.dat}_PC_${modei}-${modej}.png
#
# Split the projection data file into 8 temporary files
#  for "coloring by time" purposes
#
printf "\n Generating temporary block data files... \n"
awk '
BEGIN {
 block=1
 snap=0
}
{
 #
 # Skip comment lines
 #
 while ($0 ~ /^#/) {
   getline
   }
 #
 # Name the temporary file
 #
 outfile=(datfile ".temp." block ".dat")
 snap++
 print $0 > outfile
 #
 # If reached the end of one block, start over
 #
 if (snap == snapblock) {
   block++
   snap=0
   close(outfile)
   }
}' snapblock=${snapblock} datfile=${datfile%.dat} ${datfile}
#
# create Grace parameter file first 
#
cat - <<EOF > .tmp.${datfile%.dat}.par
# Grace project file
#
version 50116
page size 792, 612
device "PNG" dpi 72
device "PNG" font antialiasing off
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
map color 2 to (255, 0, 0), "red"
map color 3 to (0, 255, 0), "green"
map color 4 to (0, 0, 255), "blue"
map color 5 to (255, 255, 0), "yellow"
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
timestamp def "$(date)"
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
    view 0.450000, 0.400000, 0.994118, 0.900000
    title ""
    title font 0
    title size 1.500000
    title color 1
    subtitle ""
    subtitle font 0
    subtitle size 1.000000
    subtitle color 1
    xaxes scale Normal
    yaxes scale Normal
    xaxes invert off
    yaxes invert off
    xaxis  on
    xaxis  type zero false
    xaxis  offset 0.000000 , 0.000000
    xaxis  bar off
    xaxis  bar color 1
    xaxis  bar linestyle 1
    xaxis  bar linewidth 1.0
    xaxis  label ""
    xaxis  label layout para
    xaxis  label place auto
    xaxis  label char size 1.000000
    xaxis  label font 0
    xaxis  label color 1
    xaxis  label place normal
    xaxis  tick off
    xaxis  tick major ${tickmarks}
    xaxis  tick minor ticks 1
    xaxis  tick default 6
    xaxis  tick place rounded true
    xaxis  tick in
    xaxis  tick major size 1.000000
    xaxis  tick major color 1
    xaxis  tick major linewidth 1.0
    xaxis  tick major linestyle 1
    xaxis  tick major grid off
    xaxis  tick minor color 1
    xaxis  tick minor linewidth 1.0
    xaxis  tick minor linestyle 1
    xaxis  tick minor grid off
    xaxis  tick minor size 0.500000
    xaxis  ticklabel off
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
    xaxis  ticklabel char size 1.000000
    xaxis  ticklabel font 0
    xaxis  ticklabel color 1
    xaxis  tick place both
    xaxis  tick spec type none
    yaxis  on
    yaxis  type zero false
    yaxis  offset 0.000000 , 0.000000
    yaxis  bar off
    yaxis  bar color 1
    yaxis  bar linestyle 1
    yaxis  bar linewidth 1.0
    yaxis  label ""
    yaxis  label layout para
    yaxis  label place auto
    yaxis  label char size 1.000000
    yaxis  label font 0
    yaxis  label color 1
    yaxis  label place normal
    yaxis  tick off
    yaxis  tick major ${tickmarks}
    yaxis  tick minor ticks 1
    yaxis  tick default 6
    yaxis  tick place rounded true
    yaxis  tick in
    yaxis  tick major size 1.000000
    yaxis  tick major color 1
    yaxis  tick major linewidth 1.0
    yaxis  tick major linestyle 1
    yaxis  tick major grid off
    yaxis  tick minor color 1
    yaxis  tick minor linewidth 1.0
    yaxis  tick minor linestyle 1
    yaxis  tick minor grid off
    yaxis  tick minor size 0.500000
    yaxis  ticklabel off
    yaxis  ticklabel format general
    yaxis  ticklabel prec 5
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
    yaxis  ticklabel char size 1.000000
    yaxis  ticklabel font 0
    yaxis  ticklabel color 1
    yaxis  tick place both
    yaxis  tick spec type none
    altxaxis  off
    altyaxis  off
    legend on
    legend loctype view
    legend 0.994, 0.76
    legend box color 1
    legend box pattern 1
    legend box linewidth 1.0
    legend box linestyle 1
    legend box fill color 0
    legend box fill pattern 1
    legend font 4
    legend char size 0.650000
    legend color 1
    legend length 0
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
    s0 symbol 1
    s0 symbol size 0.250000
    s0 symbol color 1
    s0 symbol pattern 1
    s0 symbol fill color 1
    s0 symbol fill pattern 1
    s0 symbol linewidth 1.0
    s0 symbol linestyle 1
    s0 symbol char 65
    s0 symbol char font 0
    s0 symbol skip 0
    s0 line type 1
    s0 line linestyle 0
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
    s0 comment "mode ${modei} : mode ${modej}"
    s0 legend  ""
    s1 hidden false
    s1 type xy
    s1 symbol 1
    s1 symbol size 0.100000
    s1 symbol color 2
    s1 symbol pattern 1
    s1 symbol fill color 2
    s1 symbol fill pattern 1
    s1 symbol linewidth 1.0
    s1 symbol linestyle 1
    s1 symbol char 65
    s1 symbol char font 0
    s1 symbol skip 0
    s1 line type 0
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
    s1 errorbar color 2
    s1 errorbar pattern 1
    s1 errorbar size 1.000000
    s1 errorbar linewidth 1.0
    s1 errorbar linestyle 1
    s1 errorbar riser linewidth 1.0
    s1 errorbar riser linestyle 1
    s1 errorbar riser clip off
    s1 errorbar riser clip length 0.100000
    s1 comment "mode ${modei} : mode ${modej}"
    s1 legend  "${legendt1}"
    s2 hidden false
    s2 type xy
    s2 symbol 1
    s2 symbol size 0.100000
    s2 symbol color 11
    s2 symbol pattern 1
    s2 symbol fill color 11
    s2 symbol fill pattern 1
    s2 symbol linewidth 1.0
    s2 symbol linestyle 1
    s2 symbol char 65
    s2 symbol char font 0
    s2 symbol skip 0
    s2 line type 0
    s2 line linestyle 1
    s2 line linewidth 1.0
    s2 line color 3
    s2 line pattern 1
    s2 baseline type 0
    s2 baseline off
    s2 dropline off
    s2 fill type 0
    s2 fill rule 0
    s2 fill color 1
    s2 fill pattern 1
    s2 avalue off
    s2 avalue type 2
    s2 avalue char size 1.000000
    s2 avalue font 0
    s2 avalue color 1
    s2 avalue rot 0
    s2 avalue format general
    s2 avalue prec 3
    s2 avalue prepend ""
    s2 avalue append ""
    s2 avalue offset 0.000000 , 0.000000
    s2 errorbar on
    s2 errorbar place both
    s2 errorbar color 11
    s2 errorbar pattern 1
    s2 errorbar size 1.000000
    s2 errorbar linewidth 1.0
    s2 errorbar linestyle 1
    s2 errorbar riser linewidth 1.0
    s2 errorbar riser linestyle 1
    s2 errorbar riser clip off
    s2 errorbar riser clip length 0.100000
    s2 comment "mode ${modei} : mode ${modej}"
    s2 legend  "${legendt2}"
    s3 hidden false
    s3 type xy
    s3 symbol 1
    s3 symbol size 0.100000
    s3 symbol color 5
    s3 symbol pattern 1
    s3 symbol fill color 5
    s3 symbol fill pattern 1
    s3 symbol linewidth 1.0
    s3 symbol linestyle 1
    s3 symbol char 65
    s3 symbol char font 0
    s3 symbol skip 0
    s3 line type 0
    s3 line linestyle 1
    s3 line linewidth 1.0
    s3 line color 4
    s3 line pattern 1
    s3 baseline type 0
    s3 baseline off
    s3 dropline off
    s3 fill type 0
    s3 fill rule 0
    s3 fill color 1
    s3 fill pattern 1
    s3 avalue off
    s3 avalue type 2
    s3 avalue char size 1.000000
    s3 avalue font 0
    s3 avalue color 1
    s3 avalue rot 0
    s3 avalue format general
    s3 avalue prec 3
    s3 avalue prepend ""
    s3 avalue append ""
    s3 avalue offset 0.000000 , 0.000000
    s3 errorbar on
    s3 errorbar place both
    s3 errorbar color 5
    s3 errorbar pattern 1
    s3 errorbar size 1.000000
    s3 errorbar linewidth 1.0
    s3 errorbar linestyle 1
    s3 errorbar riser linewidth 1.0
    s3 errorbar riser linestyle 1
    s3 errorbar riser clip off
    s3 errorbar riser clip length 0.100000
    s3 comment "mode ${modei} : mode ${modej}"
    s3 legend  "${legendt3}"
    s4 hidden false
    s4 type xy
    s4 symbol 1
    s4 symbol size 0.100000
    s4 symbol color 3
    s4 symbol pattern 1
    s4 symbol fill color 3
    s4 symbol fill pattern 1
    s4 symbol linewidth 1.0
    s4 symbol linestyle 1
    s4 symbol char 65
    s4 symbol char font 0
    s4 symbol skip 0
    s4 line type 0
    s4 line linestyle 1
    s4 line linewidth 1.0
    s4 line color 5
    s4 line pattern 1
    s4 baseline type 0
    s4 baseline off
    s4 dropline off
    s4 fill type 0
    s4 fill rule 0
    s4 fill color 1
    s4 fill pattern 1
    s4 avalue off
    s4 avalue type 2
    s4 avalue char size 1.000000
    s4 avalue font 0
    s4 avalue color 1
    s4 avalue rot 0
    s4 avalue format general
    s4 avalue prec 3
    s4 avalue prepend ""
    s4 avalue append ""
    s4 avalue offset 0.000000 , 0.000000
    s4 errorbar on
    s4 errorbar place both
    s4 errorbar color 3
    s4 errorbar pattern 1
    s4 errorbar size 1.000000
    s4 errorbar linewidth 1.0
    s4 errorbar linestyle 1
    s4 errorbar riser linewidth 1.0
    s4 errorbar riser linestyle 1
    s4 errorbar riser clip off
    s4 errorbar riser clip length 0.100000
    s4 comment "mode ${modei} : mode ${modej}"
    s4 legend  "${legendt4}"
    s5 hidden false
    s5 type xy
    s5 symbol 1
    s5 symbol size 0.100000
    s5 symbol color 15
    s5 symbol pattern 1
    s5 symbol fill color 15
    s5 symbol fill pattern 1
    s5 symbol linewidth 1.0
    s5 symbol linestyle 1
    s5 symbol char 65
    s5 symbol char font 0
    s5 symbol skip 0
    s5 line type 0
    s5 line linestyle 1
    s5 line linewidth 1.0
    s5 line color 6
    s5 line pattern 1
    s5 baseline type 0
    s5 baseline off
    s5 dropline off
    s5 fill type 0
    s5 fill rule 0
    s5 fill color 1
    s5 fill pattern 1
    s5 avalue off
    s5 avalue type 2
    s5 avalue char size 1.000000
    s5 avalue font 0
    s5 avalue color 1
    s5 avalue rot 0
    s5 avalue format general
    s5 avalue prec 3
    s5 avalue prepend ""
    s5 avalue append ""
    s5 avalue offset 0.000000 , 0.000000
    s5 errorbar on
    s5 errorbar place both
    s5 errorbar color 15
    s5 errorbar pattern 1
    s5 errorbar size 1.000000
    s5 errorbar linewidth 1.0
    s5 errorbar linestyle 1
    s5 errorbar riser linewidth 1.0
    s5 errorbar riser linestyle 1
    s5 errorbar riser clip off
    s5 errorbar riser clip length 0.100000
    s5 comment "mode ${modei} : mode ${modej}"
    s5 legend  "${legendt5}"
    s6 hidden false
    s6 type xy
    s6 symbol 1
    s6 symbol size 0.100000
    s6 symbol color 9
    s6 symbol pattern 1
    s6 symbol fill color 9
    s6 symbol fill pattern 1
    s6 symbol linewidth 1.0
    s6 symbol linestyle 1
    s6 symbol char 65
    s6 symbol char font 0
    s6 symbol skip 0
    s6 line type 0
    s6 line linestyle 1
    s6 line linewidth 1.0
    s6 line color 7
    s6 line pattern 1
    s6 baseline type 0
    s6 baseline off
    s6 dropline off
    s6 fill type 0
    s6 fill rule 0
    s6 fill color 1
    s6 fill pattern 1
    s6 avalue off
    s6 avalue type 2
    s6 avalue char size 1.000000
    s6 avalue font 0
    s6 avalue color 1
    s6 avalue rot 0
    s6 avalue format general
    s6 avalue prec 3
    s6 avalue prepend ""
    s6 avalue append ""
    s6 avalue offset 0.000000 , 0.000000
    s6 errorbar on
    s6 errorbar place both
    s6 errorbar color 9
    s6 errorbar pattern 1
    s6 errorbar size 1.000000
    s6 errorbar linewidth 1.0
    s6 errorbar linestyle 1
    s6 errorbar riser linewidth 1.0
    s6 errorbar riser linestyle 1
    s6 errorbar riser clip off
    s6 errorbar riser clip length 0.100000
    s6 comment "mode ${modei} : mode ${modej}"
    s6 legend  "${legendt6}"
    s7 hidden false
    s7 type xy
    s7 symbol 1
    s7 symbol size 0.100000
    s7 symbol color 4
    s7 symbol pattern 1
    s7 symbol fill color 4
    s7 symbol fill pattern 1
    s7 symbol linewidth 1.0
    s7 symbol linestyle 1
    s7 symbol char 65
    s7 symbol char font 0
    s7 symbol skip 0
    s7 line type 0
    s7 line linestyle 1
    s7 line linewidth 1.0
    s7 line color 8
    s7 line pattern 1
    s7 baseline type 0
    s7 baseline off
    s7 dropline off
    s7 fill type 0
    s7 fill rule 0
    s7 fill color 1
    s7 fill pattern 1
    s7 avalue off
    s7 avalue type 2
    s7 avalue char size 1.000000
    s7 avalue font 0
    s7 avalue color 1
    s7 avalue rot 0
    s7 avalue format general
    s7 avalue prec 3
    s7 avalue prepend ""
    s7 avalue append ""
    s7 avalue offset 0.000000 , 0.000000
    s7 errorbar on
    s7 errorbar place both
    s7 errorbar color 4
    s7 errorbar pattern 1
    s7 errorbar size 1.000000
    s7 errorbar linewidth 1.0
    s7 errorbar linestyle 1
    s7 errorbar riser linewidth 1.0
    s7 errorbar riser linestyle 1
    s7 errorbar riser clip off
    s7 errorbar riser clip length 0.100000
    s7 comment "mode ${modei} : mode ${modej}"
    s7 legend  "${legendt7}"
    s8 hidden false
    s8 type xy
    s8 symbol 1
    s8 symbol size 0.100000
    s8 symbol color 8
    s8 symbol pattern 1
    s8 symbol fill color 8
    s8 symbol fill pattern 1
    s8 symbol linewidth 1.0
    s8 symbol linestyle 1
    s8 symbol char 65
    s8 symbol char font 0
    s8 symbol skip 0
    s8 line type 0
    s8 line linestyle 1
    s8 line linewidth 1.0
    s8 line color 9
    s8 line pattern 1
    s8 baseline type 0
    s8 baseline off
    s8 dropline off
    s8 fill type 0
    s8 fill rule 0
    s8 fill color 1
    s8 fill pattern 1
    s8 avalue off
    s8 avalue type 2
    s8 avalue char size 1.000000
    s8 avalue font 0
    s8 avalue color 1
    s8 avalue rot 0
    s8 avalue format general
    s8 avalue prec 3
    s8 avalue prepend ""
    s8 avalue append ""
    s8 avalue offset 0.000000 , 0.000000
    s8 errorbar on
    s8 errorbar place both
    s8 errorbar color 8
    s8 errorbar pattern 1
    s8 errorbar size 1.000000
    s8 errorbar linewidth 1.0
    s8 errorbar linestyle 1
    s8 errorbar riser linewidth 1.0
    s8 errorbar riser linestyle 1
    s8 errorbar riser clip off
    s8 errorbar riser clip length 0.100000
    s8 comment "mode ${modei} : mode ${modej}"
    s8 legend  "${legendt8}"
g1 on
g1 hidden false
g1 type XY
g1 stacked false
g1 bar hgap 0.000000
g1 fixedpoint off
g1 fixedpoint type 0
g1 fixedpoint xy 0.000000, 0.000000
g1 fixedpoint format general general
g1 fixedpoint prec 6, 6
with g1
    world ${pmin}, ${ystart}, ${pmax}, ${yend}
    stack world 0, 0, 0, 0
    znorm 1
    view 0.150000, 0.400000, 0.450118, 0.900000
    title ""
    title font 0
    title size 1.500000
    title color 1
    subtitle ""
    subtitle font 0
    subtitle size 1.000000
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
    xaxis  label "P\s${modej}\N(q\s${modej}\N)"
    xaxis  label layout para
    xaxis  label place auto
    xaxis  label char size 1.000000
    xaxis  label font 4
    xaxis  label color 1
    xaxis  label place opposite
    xaxis  tick on
    xaxis  tick major ${ptick}
    xaxis  tick minor ticks 1
    xaxis  tick default 6
    xaxis  tick place rounded true
    xaxis  tick in
    xaxis  tick major size 1.000000
    xaxis  tick major color 1
    xaxis  tick major linewidth 1.0
    xaxis  tick major linestyle 1
    xaxis  tick major grid off
    xaxis  tick minor color 1
    xaxis  tick minor linewidth 1.0
    xaxis  tick minor linestyle 1
    xaxis  tick minor grid off
    xaxis  tick minor size 0.500000
    xaxis  ticklabel on
    xaxis  ticklabel format decimal
    xaxis  ticklabel prec 4
    xaxis  ticklabel formula ""
    xaxis  ticklabel append ""
    xaxis  ticklabel prepend ""
    xaxis  ticklabel angle 0
    xaxis  ticklabel skip 0
    xaxis  ticklabel stagger 0
    xaxis  ticklabel place opposite
    xaxis  ticklabel offset auto
    xaxis  ticklabel offset 0.000000 , 0.010000
    xaxis  ticklabel start type auto
    xaxis  ticklabel start 0.000000
    xaxis  ticklabel stop type auto
    xaxis  ticklabel stop 0.000000
    xaxis  ticklabel char size 0.800000
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
    yaxis  label "q\s${modej}"
    yaxis  label layout perp
    yaxis  label place auto
    yaxis  label char size 1.000000
    yaxis  label font 4
    yaxis  label color 1
    yaxis  label place normal
    yaxis  tick on
    yaxis  tick major ${tickmarks}
    yaxis  tick minor ticks 1
    yaxis  tick default 6
    yaxis  tick place rounded true
    yaxis  tick in
    yaxis  tick major size 1.000000
    yaxis  tick major color 1
    yaxis  tick major linewidth 1.0
    yaxis  tick major linestyle 1
    yaxis  tick major grid off
    yaxis  tick minor color 1
    yaxis  tick minor linewidth 1.0
    yaxis  tick minor linestyle 1
    yaxis  tick minor grid off
    yaxis  tick minor size 0.500000
    yaxis  ticklabel on
    yaxis  ticklabel format general
    yaxis  ticklabel prec 5
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
    yaxis  ticklabel char size 0.800000
    yaxis  ticklabel font 4
    yaxis  ticklabel color 1
    yaxis  tick place both
    yaxis  tick spec type none
    altxaxis  off
    altyaxis  off
    legend on
    legend loctype view
    legend 0.5, 0.8
    legend box color 1
    legend box pattern 1
    legend box linewidth 1.0
    legend box linestyle 1
    legend box fill color 0
    legend box fill pattern 1
    legend font 0
    legend char size 1.000000
    legend color 1
    legend length 4
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
    s0 hidden true
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
    s0 comment "mode ${modej} : snapshot"
    s0 comment "Cols 3:1"
    s0 legend  ""
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
    s1 line type 2
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
    s1 avalue prec 5
    s1 avalue prepend ""
    s1 avalue append ""
    s1 avalue offset 0.000000 , 0.000000
    s1 errorbar on
    s1 errorbar place both
    s1 errorbar color 2
    s1 errorbar pattern 1
    s1 errorbar size 1.000000
    s1 errorbar linewidth 1.0
    s1 errorbar linestyle 1
    s1 errorbar riser linewidth 1.0
    s1 errorbar riser linestyle 1
    s1 errorbar riser clip off
    s1 errorbar riser clip length 0.100000
    s1 comment "Histogram from G1.S0"
    s1 legend  ""
g2 on
g2 hidden true
g2 type XY
g2 stacked false
g2 bar hgap 0.000000
g2 fixedpoint off
g2 fixedpoint type 0
g2 fixedpoint xy 0.000000, 0.000000
g2 fixedpoint format general general
g2 fixedpoint prec 6, 6
with g2
    world 0, 0, 1, 1
    stack world 0, 0, 0, 0
    znorm 1
    view 0.500000, 0.350000, 0.792781, 0.622727
    title ""
    title font 0
    title size 1.500000
    title color 1
    subtitle ""
    subtitle font 0
    subtitle size 1.000000
    subtitle color 1
    xaxes scale Normal
    yaxes scale Normal
    xaxes invert off
    yaxes invert off
    xaxis  off
    yaxis  off
    altxaxis  off
    altyaxis  off
    legend on
    legend loctype view
    legend 0.5, 0.8
    legend box color 1
    legend box pattern 1
    legend box linewidth 1.0
    legend box linestyle 1
    legend box fill color 0
    legend box fill pattern 1
    legend font 0
    legend char size 1.000000
    legend color 1
    legend length 4
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
g3 on
g3 hidden false
g3 type XY
g3 stacked false
g3 bar hgap 0.000000
g3 fixedpoint off
g3 fixedpoint type 0
g3 fixedpoint xy 0.000000, 0.000000
g3 fixedpoint format general general
g3 fixedpoint prec 6, 6
with g3
    world ${xstart}, ${pmin}, ${xend}, ${pmax}
    stack world 0, 0, 0, 0
    znorm 1
    view 0.450000, 0.120000, 0.994118, 0.400000
    title ""
    title font 0
    title size 1.500000
    title color 1
    subtitle ""
    subtitle font 0
    subtitle size 1.000000
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
    xaxis  label "q\s${modei}"
    xaxis  label layout para
    xaxis  label place auto
    xaxis  label char size 1.000000
    xaxis  label font 4
    xaxis  label color 1
    xaxis  label place normal
    xaxis  tick on
    xaxis  tick major ${tickmarks}
    xaxis  tick minor ticks 1
    xaxis  tick default 6
    xaxis  tick place rounded true
    xaxis  tick in
    xaxis  tick major size 1.000000
    xaxis  tick major color 1
    xaxis  tick major linewidth 1.0
    xaxis  tick major linestyle 1
    xaxis  tick major grid off
    xaxis  tick minor color 1
    xaxis  tick minor linewidth 1.0
    xaxis  tick minor linestyle 1
    xaxis  tick minor grid off
    xaxis  tick minor size 0.500000
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
    xaxis  ticklabel char size 0.800000
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
    yaxis  label "P\s${modei}\N(q\s${modei}\N)"
    yaxis  label layout perp
    yaxis  label place auto
    yaxis  label char size 1.000000
    yaxis  label font 4
    yaxis  label color 1
    yaxis  label place opposite
    yaxis  tick on
    yaxis  tick major ${ptick}
    yaxis  tick minor ticks 1
    yaxis  tick default 6
    yaxis  tick place rounded true
    yaxis  tick in
    yaxis  tick major size 1.000000
    yaxis  tick major color 1
    yaxis  tick major linewidth 1.0
    yaxis  tick major linestyle 1
    yaxis  tick major grid off
    yaxis  tick minor color 1
    yaxis  tick minor linewidth 1.0
    yaxis  tick minor linestyle 1
    yaxis  tick minor grid off
    yaxis  tick minor size 0.500000
    yaxis  ticklabel on
    yaxis  ticklabel format decimal
    yaxis  ticklabel prec 4
    yaxis  ticklabel formula ""
    yaxis  ticklabel append ""
    yaxis  ticklabel prepend ""
    yaxis  ticklabel angle 0
    yaxis  ticklabel skip 0
    yaxis  ticklabel stagger 0
    yaxis  ticklabel place opposite
    yaxis  ticklabel offset auto
    yaxis  ticklabel offset 0.000000 , 0.010000
    yaxis  ticklabel start type auto
    yaxis  ticklabel start 0.000000
    yaxis  ticklabel stop type auto
    yaxis  ticklabel stop 0.000000
    yaxis  ticklabel char size 0.800000
    yaxis  ticklabel font 4
    yaxis  ticklabel color 1
    yaxis  tick place both
    yaxis  tick spec type none
    altxaxis  off
    altyaxis  off
    legend on
    legend loctype view
    legend 0.5, 0.8
    legend box color 1
    legend box pattern 1
    legend box linewidth 1.0
    legend box linestyle 1
    legend box fill color 0
    legend box fill pattern 1
    legend font 0
    legend char size 1.000000
    legend color 1
    legend length 4
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
    s0 hidden true
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
    s0 comment "mode ${modei} : snapshot"
    s0 legend  ""
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
    s1 line type 2
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
    s1 errorbar color 2
    s1 errorbar pattern 1
    s1 errorbar size 1.000000
    s1 errorbar linewidth 1.0
    s1 errorbar linestyle 1
    s1 errorbar riser linewidth 1.0
    s1 errorbar riser linestyle 1
    s1 errorbar riser clip off
    s1 errorbar riser clip length 0.100000
    s1 comment "Histogram from G3.S0"
    s1 legend  ""
EOF
#
# create preliminary plot:
#  - graph 0: projection of snapshots on to modes 1-2
#  - graph 1: mode 2 histogram (not in this first pass, X & Y needs to be swapped)
#  - graph 3: mode 1 histogram
#
printf " Creating preliminary plot... \n"
#
gracebat \
  -graph 0 -block ${datfile} -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.1.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.2.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.3.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.4.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.5.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.6.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.7.dat -bxy ${columni}:${columnj} \
           -block ${datfile%.dat}.temp.8.dat -bxy ${columni}:${columnj} \
  -graph 1 -block ${datfile} -bxy 1:${columnj} -pexec "histogram(s0,mesh(-${projspan},${projspan},${projspan}),off,on)" \
  -graph 3 -block ${datfile} -bxy 1:${columni} -pexec "histogram(s0,mesh(-${projspan},${projspan},${projspan}),off,on)" \
  -param .tmp.${datfile%.dat}.par -hdevice PNG -print .tmp.${datfile%.dat}.png \
  -saveall .tmp.${datfile%.dat}.agr
#
# swap X & Y values on histogram of mode j
#  and get the maximum values for the vertical
#  and horizontal histograms, in order to set,
#  a consistent value for the maximum in the 
#  histogram axes (pmax).
#
printf " Swapping X-Y values in j histogram... \n"
#
awk '
{
 while ($0 !~ /@target G1.S1/) {
  print $0 >> outfile
  getline
  }
 print $0 >> outfile
 getline
 print $0 >> outfile
 getline
 NHVval=0
 while ($1 != "&") {
   print $2, $1 >> outfile
   NHVval++
   if (NHVval == 1) { HVmax=$2 }
   else if ($2 >= HVmax) { HVmax=$2 }
   getline
   }
 while ($0 !~ /@target G3.S1/) {
  print $0 >> outfile
  getline
  }
 print $0 >> outfile
 getline
 print $0 >> outfile
 getline
 NHHval=0
 while ($1 != "&") {
   print $0 >> outfile
   NHHval++
   if (NHHval == 1) { HHmax=$2 }
   else if ($2 >= HHmax) { HHmax=$2 }
   getline
   }
 if (HVmax >= HHmax) {
   printf("%.5f\n",HVmax*5/4) > Pmaxfile
   }
 else {
   printf("%.5f\n",HHmax*5/4) > Pmaxfile
   }
 print $0 >> outfile
 while (getline > 0) {
  print $0 >> outfile
  }
}' Pmaxfile=.tmp.pmax \
   outfile=.tmp.${datfile%.dat}-2.agr \
   .tmp.${datfile%.dat}.agr 
#
# If user provided maximum histogram height axis
#  value, the current graph is the final graph,
#  otherwise, autoset maximum histogram height
#  axis value.
#
if [ "${doautop}" == "n" ] ; then 
  mv .tmp.${datfile%.dat}-2.agr ${datfile%.dat}_PC_${modei}-${modej}.agr
else
  #
  # Maximum value for histograms
  # Tick labels every 1/2 of the maximum value
  #
  pmax=$(cat .tmp.pmax)
  ptick=$(printf "%.5f" $(echo "${pmax} / 2" | bc -l))
  #
  # Autoset histogram axes
  #
  printf " Autoset maximum in histogram axes... \n"
  #
  awk '
   {
    while ($0 !~ /^@with g1/) {
     print $0 >> outfile
     getline
     }
    print $0 >> outfile 
    getline
    printf("@    world %s %s %.5f, %s\n",$3,$4,pmax,$6) >> outfile
    getline
    while ($0 !~ /^@    xaxis  tick major/) {
     print $0 >> outfile
     getline
     }
    printf("@    xaxis  tick major %.5f\n",ptick) >> outfile
    getline
    while ($0 !~ /^@with g3/) {
     print $0 >> outfile
     getline
     }
    print $0 >> outfile
    getline
    printf("@    world %s %s %s %.5f\n",$3,$4,$5,pmax) >> outfile
    getline
    while ($0 !~ /^@    yaxis  tick major/) {
     print $0 >> outfile
     getline
     }
    printf("@    yaxis  tick major %.5f\n",ptick) >> outfile
    while (getline > 0) {
     print $0 >> outfile
     }
   }' pmax=${pmax} ptick=${ptick} \
      outfile=${datfile%.dat}_PC_${modei}-${modej}.agr \
      .tmp.${datfile%.dat}-2.agr
  fi
#
# Create PNG of graph
#
printf " Generating final plot... \n"
#
gracebat -hdevice "PNG" -print ${datfile%.dat}_PC_${modei}-${modej}.png -hardcopy ${datfile%.dat}_PC_${modei}-${modej}.agr -batch - << EOP
device "PNG" page size 3300, 2550
device "PNG" dpi 300
device "PNG" font antialiasing on
device "PNG" op "compression:2"
device "PNG" op "transparent:off"
device "PNG" op "interlaced:off"
EOP
#
# delete temporary files
#
rm -f .tmp.${datfile%.dat}.agr .tmp.${datfile%.dat}-2.agr .tmp.${datfile%.dat}.par \
      .tmp.${datfile%.dat}.png ${datfile%.dat}.temp.*.dat ${datfile%.dat}_PC_${modei}-${modej}.agr \
      .tmp.pmax 
#
printf " Done.\n\n"
#
