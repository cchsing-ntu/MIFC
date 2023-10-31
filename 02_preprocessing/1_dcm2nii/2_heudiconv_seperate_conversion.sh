## heudiconv_seperate_conversion.sh
# -Background: 
#   This script is to deal with the problem that for some subjects heudiconv cannot complete conversion due to conflicting study ids
#   This error might be caused by subjects leaving the scanner mid-scan
#   The solution that I did was to manually seperate the different scans in derivatives/rawsourcedata into different subject files
#     i.e. 001 -> 001_REST, 001_T1, 001_T2
#   We then rerun heudiconv seperately, and combine them back together
# - The subject id that require this procedure are: 0*0*7,1*2*6,1*7*7,2*5*1
#
# -Usage:
#  To change the subject, use the find and replace function.
#  - Current subject no: 177
#
# -Version History:
#  2022.11.22 Created by Jess CC Hsing
#  2023.10.24 Changed directory and added note on subjects that require this procedure by Jess CC Hsing

# Set environment variables
MIFC_base=/bml/Data/Bank1/MIFC/Data

# Copy and remove the files
#cp -r $MIFC_base/rawsourcedata/177 $MIFC_base/rawsourcedata/177_T1
#cp -r $MIFC_base/rawsourcedata/177 $MIFC_base/rawsourcedata/177_T2
#cp -r $MIFC_base/rawsourcedata/177 $MIFC_base/rawsourcedata/177_REST

#rm -r $MIFC_base/rawsourcedata/177_T1/REST
#rm -r $MIFC_base/rawsourcedata/177_T1/T2
#rm -r $MIFC_base/rawsourcedata/177_T2/REST
#rm -r $MIFC_base/rawsourcedata/177_T2/T1
#rm -r $MIFC_base/rawsourcedata/177_REST/T1
#rm -r $MIFC_base/rawsourcedata/177_REST/T2

# Complete HeuDiConv transformation
heudiconv -s 177_T1 -d $MIFC_base/rawsourcedata/{subject}/*/*.IMA -o $MIFC_base/rawdata -f $MIFC_base/heuristic.py -c dcm2niix -b --overwrite
heudiconv -s 177_T2 -d $MIFC_base/rawsourcedata/{subject}/*/*.IMA -o $MIFC_base/rawdata -f $MIFC_base/heuristic.py -c dcm2niix -b --overwrite
heudiconv -s 177_REST -d $MIFC_base/rawsourcedata/{subject}/*/*.IMA -o $MIFC_base/rawdata -f $MIFC_base/heuristic.py -c dcm2niix -b --overwrite

# Merge the directories back together and delete temporary directories
mkdir $MIFC_base/rawdata/sub-177REST/anat/
mv $MIFC_base/rawdata/sub-177T1/anat/* $MIFC_base/rawdata/sub-177REST/anat/
mv $MIFC_base/rawdata/sub-177T2/anat/* $MIFC_base/rawdata/sub-177REST/anat/
mv $MIFC_base/rawdata/sub-177T1/sub-177T1_scans.tsv $MIFC_base/rawdata/sub-177REST/
mv $MIFC_base/rawdata/sub-177T2/sub-177T2_scans.tsv $MIFC_base/rawdata/sub-177REST/
mv $MIFC_base/rawdata/sub-177REST $MIFC_base/rawdata/sub-177
rm -r $MIFC_base/rawdata/sub-177T1
rm -r $MIFC_base/rawdata/sub-177T2

# change the permissions for the files
chmod -R 771 $MIFC_base/rawdata

# change the name of the nifti and json files
mv $MIFC_base/rawdata/sub-177/anat/sub-177T1_T1w.json $MIFC_base/rawdata/sub-177/anat/sub-177_T1w.json
mv $MIFC_base/rawdata/sub-177/anat/sub-177T2_T2w.json $MIFC_base/rawdata/sub-177/anat/sub-177_T2w.json
mv $MIFC_base/rawdata/sub-177/anat/sub-177T1_T1w.nii.gz $MIFC_base/rawdata/sub-177/anat/sub-177_T1w.nii.gz
mv $MIFC_base/rawdata/sub-177/anat/sub-177T2_T2w.nii.gz $MIFC_base/rawdata/sub-177/anat/sub-177_T2w.nii.gz
mv $MIFC_base/rawdata/sub-177/func/sub-177REST_task-rest_bold.json $MIFC_base/rawdata/sub-177/func/sub-177_task-rest_bold.json
mv $MIFC_base/rawdata/sub-177/func/sub-177REST_task-rest_bold.nii.gz $MIFC_base/rawdata/sub-177/func/sub-177_task-rest_bold.nii.gz
mv $MIFC_base/rawdata/sub-177/func/sub-177REST_task-rest_events.tsv $MIFC_base/rawdata/sub-177/func/sub-177_task-rest_events.tsv

# unzip files
gunzip $MIFC_base/rawdata/sub-177/anat/*.nii.gz
gunzip $MIFC_base/rawdata/sub-177/func/*.nii.gz




