# unzip all nifti
# Usage: This script is written to unzip all nifti files
# 
# -Version History:
#  2022.11.14 Created by Jess CC HSING
#  2023.10.24 Changed direcroty by Jess CC Hsing

MIFC_base=/bml/Data/Bank1/MIFC/Data

#recursively gunzip so that all files are unzipped
for i in $(seq -f "%03g" 1 264)
do
	gunzip $MIFC_base/rawdata/sub-$i/anat/*.nii.gz
	gunzip $MIFC_base/rawdata/sub-$i/func/*.nii.gz
done

