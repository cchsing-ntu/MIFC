# Welcome to the signal extraction part!

The objective of the codes here is to turn the NIfTI images we have into mat files. 

**main_nifti_to_mi.m** is the main function that I use here. Notice that this function calls the other three functions. So you will need all files for the code to run properly.

**extract_voxel_values.m** is the function created by Josh. The purpose of the function is to extract voxel values, as the name suggests. In other words, this is the script that turns NIfTI files into mat files.

**mutualinfo.m** is another function written by Josh. The purpose of the function is to calculate the mutual information and the correlation coefficient between two time series. 

**mutualinfo_batch.m** is a function that I wrote that is calls on **mutualinfo.m** to run my calculations iteratively across subjects.
