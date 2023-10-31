# heudiconv_dcm2nii
# Usage: This script is written to convert DICOM files to nifti serially
# 
# -Version History:
#  2022.11.10 Created by Jess CC HSING
#  2022.11.14 Added code to change permissions by Jess CC Hsing
#  2023.10.23 Changed path so that rawdata fits BIDS format by Jess CC Hsing
#  2023.10.24 Added note to keep track of what was being done before running this script.
#====================================================================================
# Before running HeuDiConv, you should do a dry run once to get the skeleton and heuristic.py file
# 
# export MIFC_base=/bml/Data/Bank1/MIFC/Data
# heudiconv -s 001 -d $MIFC_base/rawsourcedata/{subject}/*/*.IMA -o $MIFC_base/rawdata -f convertall -c none --overwrite
#
# After the above code is run, there will be a .heudiconv directory under $MIFC_base/rawdata
# Copy $MIFC_base/rawdata/.heudiconv/001/info/heuristic.py and make modifications to specify how 
# you want your files renamed as.
#====================================================================================

MIFC_base=/bml/Data/Bank1/MIFC/Data #set up environment

#recursively run heudiconv across subjects such that preprocessing is done linearly(one-by-one)
for i in $(seq -f "%03g" 2 264)
do
	heudiconv -s $i -d $MIFC_base/rawsourcedata/{subject}/*/*.IMA -o $MIFC_base/rawdata -f $MIFC_base/heuristic.py -c dcm2niix -b --overwrite
done

#make the whole nifti folder inherit group ownership
chmod g+s $MIFC_base/rawdata

#change nifti from read-only to executable
chmod -R 771 $MIFC_base/rawdatabe
