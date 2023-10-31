# Welcome to the preprocessing part!
*Written by Jess CC Hsing 2023.10.31*

As you can see, there are 3 subdirectories. Let me explain the logic behind their creation here.

**1_dcm2nii** are files that I use to perform dicom conversion to NIfTI files. In this version, I used HeuDiConv with dcm2niix so that the converted NIfTI files are in BIDS format. To perform this part, run the codes step by step with the instructions included in the codes.

**2_protocol** are SPM batchfiles for preprocessing. Note that these are just for demonstration purposes so that one knows how I did the preprocessing by loading these files step by step into the SPM batch editor! I also used these scripts to create the jobfiles in the next part. Additionally, there are also some .m files in this directory.
`T1_check` and `motion_check` should be run at the beginning of the preprocessing to manually filter out files that had low imaging quality.
`s12_movefile_detrend_bandpass_mask_grey_matter.m` is run as the last step to further process the residuals signals that will be used for later stages.

**3_jobfiles**
Here you can see a lot of .m files with `pathdefiner` at the end of their files names. These are files that I modified according to the jobfiles that were created by the SPM `save batch and script` function. The purpose of these `pathdefiner` files are to creat SPM batchfiles in batches so that I don't have to click through it subject-by-subject.

If you go to the server version, you will see an extra directory called 4_batchfiles. That is where I store all the subject's batchfiles created with the pathdefiner files in 3\_jobfiles.

My habit is to run those batchfiles manually using the SPM GUI. Alternatively, you can also run those batches by loading them into the matlabbatch variable and run

`spm_jobman('run',matlabbatch)`

**__This part requires MATLAB, SPM12, HeuDiConv, dcm2niix, and the REST toolbox to run properly!__**
