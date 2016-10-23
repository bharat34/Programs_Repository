#!/bin/bash
###############################
#                             #
# AUTOMATION OF MD TRAJECTORY #
#    ANALYSIS USING PTRAJ     #
#                             #
#     Bharat Lakhani          #
#     Wesleyan University     #
#                             #
#     **** Jan 2014 ****      #
#                             #
###############################
#
# Use AmberTools compiled in my home directory
#
AMBERHOME=/home/blakhani/apps/ambertools_current
PATH=${AMBERHOME}/bin:${AMBERHOME}/src/netcdf/bin:${PATH}
#
# Directory containing graphing utilities
#
GRTOOLDIR=/home/blakhani/mdanalysis/gr_mdanalysis
#
##########################
#
#  Help message
#
if [ $# -ne 3 ] && [ $# -ne 4 ] ; then
  echo ""
  echo "  ###############################"
  echo "  #                             #"
  echo "  # AUTOMATION OF MD TRAJECTORY #"
  echo "  #    ANALYSIS USING PTRAJ     #"
  echo "  #                             #"
  echo "  #     Bharat Lakhani          #"
  echo "  #     Wesleyan University     #"
  echo "  #                             #"
  echo "  #     **** Jan 2014 ****      #"
  echo "  #                             #"
  echo "  ###############################"
  echo ""
  echo " mdanalysis - creates a script for submission to a queue"
  echo "              in petaltail that makes use ptraj to perform"
  echo "              several types of analyses on MD trajectories."
  echo ""
  echo " Usage: mdanalysis trajectory-file prmtop-file queue-name [defaults]"
  echo ""
  echo "        Type \"defaults\" as the fourth argument to run the script"
  echo "          with all the default options. Default options are the"
  echo "          following:"
  echo "          a) Use complete trajectory, e.g. include every snapshot"
  echo "             from first to last."
  echo "          b) Use all backbone atoms, peptide (@N,CA,C) and nucleic"
  echo "             acid (@P,O5',C5',C4',C3',O3')". 
  echo "          c) Do all available analyses:"
  echo "             c.1) 1D RMS w.r.t. first and average snapshots."
  echo "             c.2) B-factors."
  echo "             c.3) 2D RMS, Distance, Correlation and Covariance matrices."
  echo "             c.4) PCA of Covariance matrix, displacements and projections."
  echo "          d) Default job name uses trajectory name, first and last"
  echo "             snapshot numbers and interval between snapshots."
  echo ""
  echo "        Do not type \"defaults\" if you would like to modify any of"
  echo "          settings above."
  echo ""
exit
fi
#
##########################
#
# Arguments passed to this script
#  1) trajectory file
#  2) prmtop file
#  3) queue name
#  4) Use defaults?
#
TRAJFILE=${1}
FILEALL=$(echo ${TRAJFILE} | awk 'BEGIN { FS="/" } { print $NF }' -)
BASEFILE=${FILEALL%.*}
if [[ ${TRAJFILE} = *.mdcrd.gz ]] ; then
  BASEFILE=${FILEALL%.mdcrd.gz}
  fi
PRMTOP=${2}
QUEUENAME=${3}
if [ "${4}" != "defaults" ] ; then
  USEDEFAULTS="n"
  fi
##########################
#
# Test for files and queue
#
#  - prmtop file
#
if test ! -f ${PRMTOP} ; then
  echo ""
  echo "${PRMTOP} file not found"
  echo ""
  exit
fi
#
#  - trajectory file
#
if test ! -f ${TRAJFILE} ; then
  echo ""
  echo "${TRAJFILE} file not found"
  echo ""
  exit
fi
#
#  - queue
#
if [ ${QUEUENAME} != "imw" ] && [ ${QUEUENAME} != "ehw" ] && \
   [ ${QUEUENAME} != "emw" ] && [ ${QUEUENAME} != "elw" ] && \
   [ ${QUEUENAME} != "ehwfd" ] && [ ${QUEUENAME} != "hp12" ]; then
  echo ""
  echo "${QUEUENAME} queue not found"
  echo ""
  exit
fi
#
###########################
#
# Get number of atoms from prmtop file and
#  numer of snapshots from trajectory file
#
NATOMS=$(awk '/%FLAG POINTERS/ { getline; getline; print $1 }' ${PRMTOP})
NCLINES=$((3*NATOMS/10))
EXTRAL=$((3*NATOMS-NCLINES*10))
test "${EXTRAL}" -gt "0" && let "NCLINES++"
if [[ ${TRAJFILE} = *.mdcrd ]] ; then
  NTLINES=$(($(cat ${TRAJFILE} | wc -l) - 1))
  NSNAPS=$((${NTLINES} / ${NCLINES}))
elif [[ ${TRAJFILE} = *.mdcrd.gz ]] ; then
  NTLINES=$(($(gunzip -c ${TRAJFILE} | wc -l) - 1))
  NSNAPS=$((${NTLINES} / ${NCLINES}))
elif [[ ${TRAJFILE} = *.netcdf ]] ; then
  NSNAPS="$(ncdump -h ${TRAJFILE} \
          | grep "currently" \
          | awk '{ sub(/\(/,"",$6) ; print $6 }' -)"
else
  printf "\n Trajectory file name does not end in .mdcrd[.gz] or .netcdf.\n\n"
  exit
  fi
#
##########################
#
# Prompt for portion to the trajectory
#  to analyze. Defaults to analyze the
#  whole trajectory, i.e. starts at first
#  ends at last and takes snapshots every 1.
#
# Checks that values are positive integers and
#  that final snapshot is a larger number than
#  initial snapshot.
#
if [ "${USEDEFAULTS}" == "n" ] ; then
  printf "\n *** Trajectory segment selection ***\n\n"
  read -p " Start at snapshot [1]:" SNPST
  read -p " End at snapshot [${NSNAPS}]:" SNPEND
  read -p " Read one snapshot every [1]:" SNPSTEP
  fi
if [ -z "${SNPST}" ] ; then 
  SNPST="1"
  fi
if [ -z "${SNPEND}" ] ; then
  SNPEND="${NSNAPS}"
  fi
if [ -z "${SNPSTEP}" ] ; then
  SNPSTEP="1"
  fi
if [ -n "$(echo ${SNPST} | sed "s/[[:digit:]]//g")" ] ; then
  printf "\n Start value is not a positive integer. Exit.\n\n"
  exit
  fi
if [ -n "$(echo ${SNPEND} | sed "s/[[:digit:]]//g")" ] ; then
  printf "\n Final value is not a positive integer. Exit.\n\n"
  exit
  fi
test "${SNPEND}" -lt "${SNPST}" && \
  printf "\n Final value is lower than initial. Exit.\n\n" && exit
if [ -n "$(echo ${SNPSTEP} | sed "s/[[:digit:]]//g")" ] ; then
  printf "\n Interval value is not a positive integer. Exit.\n\n"
  exit
  fi
#
##########################
#
# Prompt for atom mask to use in
#  all ptraj runs
#
if [ "${USEDEFAULTS}" == "n" ] ; then
  printf "\n *** Atom selection ***\n"
  printf "\n Mask to be used in all ptraj runs\n"
  printf " [Defaults to peptide and nucleic acid backbones,\n"
  read -p " i.e. @C,CA,N,P,O5',C5',C4',C3',O3']: " MASK
  fi
if [ "${MASK}" == "" ] ; then
  MASK="@C,CA,N,P,O5',C5',C4',C3',O3'"
  fi
#
##########################
#
# Prompt for types of analysis 
#  to run
#
if [ "${USEDEFAULTS}" == "n" ] ; then
  printf "\n\n *** Analysis type selection ***\n"
  printf "\n Available actions:\n"
  printf "  1) 1D RMS with respect to first snapshot\n"
  printf "  2) 1D RMS with respect to average structure\n"
  printf "  3) 2D RMS matrix\n"
  printf "  4) Distance matrix\n"
  printf "  5) B-factors\n"
  printf "  6) Correlation matrix\n"
  printf "  7) Eigenvalues and Eigenvectors of Covariance matrix (PCA),\n"
  printf "     Displacements along PCs, and Projection of snapshots\n"
  printf "     along PCs\n\n"
  printf " Would you like to run all of the above (y) or\n"
  read -p " select individual actions (n)? [y]: " DOALL
  fi
if [ "${DOALL}" == "" ] || [ "${DOALL}" == "y" ] || [ "${DOALL}" == "Y" ] ; then
  DO2DRMS="y"
  DODIST="y"
  DOBFAC="y"
  DOCORR="y"
  DOPCA="y"
  DO1DRMS="y"
  DOAVG="y"
else 
  printf "\n"
  read -p " Do 2D RMS matrix? [y]: " DO2DRMS
  if [ "${DO2DRMS}" == "" ] || [ "${DO2DRMS}" == "y" ] || [ "${DO2DRMS}" == "Y" ] ; then
    DO2DRMS="y"
  else 
    DO2DRMS="n"
    fi
  read -p " Do Distance matrix? [y]: " DODIST
  if [ "${DODIST}" == "" ] || [ "${DODIST}" == "y" ] || [ "${DODIST}" == "Y" ] ; then
    DODIST="y"
  else
    DODIST="n"
    fi
  read -p " Do B-factors? [y]: " DOBFAC
  if [ "${DOBFAC}" == "" ] || [ "${DOBFAC}" == "y" ] || [ "${DOBFAC}" == "Y" ] ; then
    DOBFAC="y"
    DO1DRMS="y"
    DOAVG="y"
  else
    DOBFAC="n"
    fi
  read -p " Do Correlation matrix? [y]: " DOCORR
  if [ "${DOCORR}" == "" ] || [ "${DOCORR}" == "y" ] || [ "${DOCORR}" == "Y" ] ; then
    DOCORR="y"
    DO1DRMS="y"
    DOAVG="y"
  else
    DOCORR="n"
    fi
  read -p " Do PCA of Covariance matrix? [y]: " DOPCA
  if [ "${DOPCA}" == "" ] || [ "${DOPCA}" == "y" ] || [ "${DOPCA}" == "Y" ] ; then
    DOPCA="y"
    DO1DRMS="y"
    DOAVG="y"
  else
    DOPCA="n"
    fi
  if [ "${DOAVG}" != "y" ] ; then
    read -p " Do 1D RMS with respect to average? [y]: " DOAVG
    if [ "${DOAVG}" == "" ] || [ "${DOAVG}" == "y" ] || [ "${DOAVG}" == "Y" ] ; then
      DOAVG="y"
      DO1DRMS="y"
    else
      DOAVG="n"
      read -p " Do 1D RMS with respect to first snapshot? [y]: " DO1DRMS
      if [ "${DO1DRMS}" == "" ] || [ "${DO1DRMS}" == "y" ] || [ "${DO1DRMS}" == "Y" ] ; then
        DO1DRMS="y"
      else
        DO1DRMS="n"
        fi
      fi
    fi
  fi
#
# Quit if no analysis has been requested
#
if [ "${DOALL}" == "n" ] && [ "${DO1DRMS}" == "n" ] && \
   [ "${DO2DRMS}" == "n" ] && [ "${DODIST}" == "n" ] ; then
  printf "\n No actions selected, quit now.\n\n"
  exit
  fi
#
##########################
#
# Get job name or generate one.
#
# This script does not overwrite the queue submission script (if already exists)
#
if [ "${USEDEFAULTS}" == "n" ] ; then
  printf "\n *** Job name ***\n\n"
  printf " Default job name: %s_%05i-%05i-%i\n\n" ${BASEFILE} ${SNPST} ${SNPEND} ${SNPSTEP}
  printf " Would you like to give a custom job name?\n"
  read -p " \"n\" or type custom job name [n]: " JOBNAME
  fi
if [ "${JOBNAME}" == "" ] || [ "${JOBNAME}" == "n" ] || [ "${JOBNAME}" == "N" ] ; then
  JOBNAME=$(printf "%s_%05i-%05i-%i" ${BASEFILE} ${SNPST} ${SNPEND} ${SNPSTEP})
  fi
if test -f ${JOBNAME}-ptrajrun.cmd ; then
  printf "\n ${JOBNAME}-ptrajrun.cmd exists.\n"
  printf " Please delete or review and submit.\n\n"
  exit
fi
#
##########################
#   
# Whether to leave xmgrace .agr files or just PNG images.
# 
printf "\n"
read -p " Leave xmgrace .agr files for later editing? [n]: " KEEPAGR
if [ "${KEEPAGR}" == "y" ] || [ "${KEEPAGR}" == "Y" ] ; then
  KEEPAGR="y"
else
  KEEPAGR="n"
  fi  
#       
##########################
#
# All checks passed, then create submission script
# 
exec 3>${JOBNAME}-ptrajrun.cmd
#
# Headers
#
printf "#!/bin/bash\n" >&3
printf "#BSUB -q ${QUEUENAME}\n" >&3
printf "#BSUB -J ${JOBNAME}-ptrajrun\n" >&3
printf "#BSUB -o ${JOBNAME}-ptrajrun.qout\n" >&3
printf "#BSUB -e ${JOBNAME}-ptrajrun.qerr\n" >&3
printf "#BSUB -R "rusage[tmslow=1]\n>" >&3
printf "#\n# Go to submission directory\n#\ncd $(pwd)\n" >&3
printf "#\n# Create a directory to save all the analysis results\n" >&3
printf "#\n# Check that directory does not exists (do not overwrite)\n#\n" >&3
printf "if test -e ${JOBNAME} ; then\n echo \"${JOBNAME} directory" >&3
printf " exists.\"\n echo \"Please, delete or rename before running analyses" >&3 
printf " using this job name.\"\n exit\n fi\nmkdir ${JOBNAME}\ncd ${JOBNAME}\n" >&3
printf "#\n# Use ptraj from current AmberTools compiled in my home directory\n#\n" >&3
printf "#  and set the location to the graphing utilities.\n#\n" >&3
printf "export AMBERHOME=%s\n" "${AMBERHOME}" >&3
printf "export GRTOOLDIR=%s\n" "${GRTOOLDIR}" >&3
printf "export PATH=\${AMBERHOME}/bin:\${GRTOOLDIR}:\${PATH}\n" >&3
printf "echo \"Using \$(which ptraj)\"\n" >&3
printf "#\n##########################\n#\n# ptraj runs\n#\n" >&3
printf "##########################\n#\n" >&3
#
# First ptraj run
#
printf "# First ptraj run\n#\n" >&3
printf "ptraj ../${PRMTOP} <<EOF1 > ${JOBNAME}-run1.out\n" >&3
printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
if [ "${DO1DRMS}" == "y" ] ; then
  printf "#\n# 1D RMS with respect to first snapshot\n" >&3
  printf "rms first out ${JOBNAME}-1DRMS-1st.dat ${MASK} mass\n" >&3
  fi
if [ "${DOAVG}" == "y" ] ; then
  printf "#\n# Average structure after RMS fit to first snapshot\n" >&3
  printf "average ${JOBNAME}-avg1st.pdb pdb\n" >&3
  fi
if [ "${DODIST}" == "y" ] ; then
  printf "#\n# Distance matrix\n" >&3
  printf "matrix dist out ${JOBNAME}-distancemat.dat ${MASK} byres mass\n" >&3
  fi
printf "EOF1\n#\n##########################\n" >&3
#
# 2nd ptraj run: 2D RMS matrix
#
if [ "${DO2DRMS}" == "y" ] ; then
  printf "# Second ptraj run\n#\n" >&3
  printf "ptraj ../${PRMTOP} <<EOF2 > ${JOBNAME}-run2.out\n" >&3
  printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
  printf "#\n# 2D RMS matrix\n" >&3
  printf "2drms out ${JOBNAME}-2DRMS.dat raw ${MASK} mass\n" >&3
  printf "EOF2\n#\n##########################\n" >&3
else
  printf "# Skipping second ptraj run, no 2D RMS requested \n#\n" >&3
  fi
# 
# Do 3rd, 4th and 5th ptraj runs if computing average structure, 
#  B-factors, correlation matrix or PCA
#
if [ "${DOAVG}" == "y" ] ; then
  printf "#\n# Third ptraj run\n#\n" >&3
  printf "ptraj ../${PRMTOP} <<EOF3 > ${JOBNAME}-run3.out\n" >&3
  printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
  printf "reference ${JOBNAME}-avg1st.pdb\n" >&3
  printf "#\n# 1D RMS with respect to first average\n" >&3
  printf "rms reference out ${JOBNAME}-1DRMS-2nd.dat ${MASK} mass\n" >&3
  printf "#\n# Average structure after RMS fit to first average\n" >&3
  printf "average ${JOBNAME}-avg2nd.pdb pdb\n" >&3
  printf "EOF3\n#\n##########################\n" >&3
  printf "#\n# Fourth ptraj run\n#\n" >&3
  printf "ptraj ../${PRMTOP} <<EOF4 > ${JOBNAME}-run4.out\n" >&3
  printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
  printf "reference ${JOBNAME}-avg2nd.pdb\n" >&3
  printf "#\n# 1D RMS with respect to second average\n" >&3
  printf "rms reference out ${JOBNAME}-1DRMS-3rd.dat ${MASK} mass\n" >&3
  printf "#\n# Average structure\n" >&3
  printf "average ${JOBNAME}-avg.pdb pdb\n" >&3
  printf "EOF4\n#\n##########################\n" >&3
  printf "#\n# Fifth ptraj run\n#\n" >&3
  printf "ptraj ../${PRMTOP} <<EOF5 > ${JOBNAME}-run5.out\n" >&3
  printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
  printf "reference ${JOBNAME}-avg.pdb\n" >&3
  printf "#\n# 1D RMS with respect to average\n" >&3
  printf "rms reference out ${JOBNAME}-1DRMS-avg.dat ${MASK} mass\n" >&3
  if [ "${DOBFAC}" == "y" ] ; then
    printf "#\n# Compute B-factors\n" >&3
    printf "atomicfluct out ${JOBNAME}-Bfact.dat ${MASK} byres bfactor\n" >&3
    fi
  if [ "${DOCORR}" == "y" ] ; then
    printf "#\n# Correlation matrix\n" >&3
    printf "matrix correl ${MASK} out ${JOBNAME}-correlmat.dat byres mass\n" >&3
    fi
#
# If doing PCA, then run a 6th ptraj run for
#  projection of snapshots onto PCs computed in run 5
#
  if [ "${DOPCA}" == "y" ] ; then
    printf "#\n# Covariance matrix\n" >&3
    printf "matrix covar name ${BASEFILE}-covar ${MASK} out ${JOBNAME}-covarmat.dat\n" >&3
    printf "#\n# Eigenvectors of Covariance matrix (PCA)\n" >&3
    printf "analyze matrix ${BASEFILE}-covar name ${BASEFILE}-pca out ${JOBNAME}-pca100vec.dat vecs 100\n" >&3
    for ((MODE=1; MODE<=10; MODE++)) ; do
      printf "analyze modes displ stack ${BASEFILE}-pca beg ${MODE} end ${MODE} factor 10000 out " >&3
      printf "${JOBNAME}-pcadispl_%02i.dat\n" ${MODE} >&3
      done
    fi
  printf "EOF5\n#\n##########################\n" >&3
  fi
if [ "${DOPCA}" == "y" ] ; then
  printf "#\n# Sixth ptraj run\n#\n" >&3
  printf "ptraj ../${PRMTOP} <<EOF6 > ${JOBNAME}-run6.out\n" >&3
  printf "trajin ../${TRAJFILE} ${SNPST} ${SNPEND} ${SNPSTEP}\n" >&3
  printf "reference ${JOBNAME}-avg.pdb\n" >&3
  printf "#\n# RMS fit to average\n" >&3
  printf "rms reference ${MASK} mass\n" >&3
  printf "#\n# Projection of snapshots onto PCs (Eigenvectors of Covariance matrix)\n" >&3
  printf "projection modes ${JOBNAME}-pca100vec.dat out " >&3
  printf "${JOBNAME}-pcaproj_1-10.dat beg 1 end 10 ${MASK}\n" >&3
  printf "EOF6\n#\n##########################\n" >&3
  fi
#
# create graphs
#
if [ "${DO1DRMS}" == "y" ] ; then
  printf "#\n# 1D RMS graphs\n" >&3
  printf "1drms_mdanalysis.sh ${JOBNAME}-1DRMS-1st.dat" >&3
  if [ "${DOAVG}" == "y" ] ; then
    printf " ${JOBNAME}-1DRMS-avg.dat" >&3
    fi
  printf "\n" >&3
  fi
if [ "${DO2DRMS}" == "y" ] ; then
  printf "#\n# 2D RMS graph, 0.30 Ang. resolution\n" >&3
  printf "2drms_mdanalysis.sh ${JOBNAME}-2DRMS.dat " >&3
  printf "\"Snapshot number\" 0.30\n" >&3
  fi
if [ "${DODIST}" == "y" ] ; then
  printf "#\n# Distance matrix graph\n" >&3
  printf "dist_mdanalysis.sh ${JOBNAME}-distancemat.dat " >&3
  printf "\"Residue i\" \"Residue j\"\n" >&3
  fi
if [ "${DOCORR}" == "y" ] ; then
  printf "#\n# Correlation matrix graph\n" >&3
  printf "correl_mdanalysis.sh ${JOBNAME}-correlmat.dat " >&3
  printf "\"Residue i\" \"Residue j\"\n" >&3
  fi
if [ "${DOBFAC}" == "y" ] ; then
  printf "#\n# B-factors graph\n" >&3
  printf "Bfactor_mdanalysis.sh ${JOBNAME}-Bfact.dat\n" >&3
  fi
#
# Compress .dat and .agr files
#
  printf "#\n# Compress .dat files\n" >&3
  printf "bzip2 *.dat\n" >&3
#
# Whether to delete xmgrace .agr files after PNGs are generated
#
if [ "${KEEPAGR}" == "n" ] ; then
  printf "#\n# Delete xmgrace .agr files to save disk space\n" >&3
  printf "rm -f ${JOBNAME}-*.agr\n" >&3
else
  printf "#\n# Keep xmgrace .agr files but compress to save disk space\n" >&3
  printf "bzip2 ${JOBNAME}-*.agr\n" >&3
  fi
#
##########################
#
# Ask whether to submit script to queue
# 
if [ "${USEDEFAULTS}" == "n" ] ; then
  printf "\n Done creating submission script.\n\n"
  read -p " Would you like to submit job to queue? [n]: " DOSUB
  fi
if [ "${DOSUB}" == "y" ] || [ "${DOSUB}" == "Y" ] ; then
  bsub < ${JOBNAME}-ptrajrun.cmd
  fi
printf "\n"
#
# Done
#
##########################
