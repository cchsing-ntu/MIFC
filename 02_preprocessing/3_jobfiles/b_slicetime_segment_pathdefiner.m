%-----------------------------------------------------------------------
% Job saved on 17-Feb-2023 17:39:46 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%%
function b_slicetime_segment_pathdefiner(subjlist)
for subjno=subjlist
    %% Set up environmental variables
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);

    %% For loop : 180 slices for resting state scans
    rRrest_epi_files=cell(180,1);
    savefilename=strcat('../4_batchfiles/b_slicetime_segment_',subjstr);
    T1_file = strcat(subjdir,'/anat/',subjstr,'_T1w.nii,1');
    for img = 1:180
        rRrest_epi_files{img,1}=strcat(subjdir,'/func/rR',subjstr,'_task-rest_bold.nii,',num2str(img));
    end

    matlabbatch{1}.spm.temporal.st.scans = {rRrest_epi_files}; %changed here
    %%
    matlabbatch{1}.spm.temporal.st.nslices = 38;
    matlabbatch{1}.spm.temporal.st.tr = 2;
    matlabbatch{1}.spm.temporal.st.ta = 1.94736842105263;
    matlabbatch{1}.spm.temporal.st.so = [2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37];
    matlabbatch{1}.spm.temporal.st.refslice = 2;
    matlabbatch{1}.spm.temporal.st.prefix = 'a';
    matlabbatch{2}.spm.spatial.preproc.channel.vols = {T1_file}; %changed here
    matlabbatch{2}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{2}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{2}.spm.spatial.preproc.channel.write = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(1).tpm = {'/usr/local/spm12/tpm/TPM.nii,1'};
    matlabbatch{2}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{2}.spm.spatial.preproc.tissue(1).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(1).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(2).tpm = {'/usr/local/spm12/tpm/TPM.nii,2'};
    matlabbatch{2}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{2}.spm.spatial.preproc.tissue(2).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(2).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(3).tpm = {'/usr/local/spm12/tpm/TPM.nii,3'};
    matlabbatch{2}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{2}.spm.spatial.preproc.tissue(3).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(3).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(4).tpm = {'/usr/local/spm12/tpm/TPM.nii,4'};
    matlabbatch{2}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{2}.spm.spatial.preproc.tissue(4).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(4).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(5).tpm = {'/usr/local/spm12/tpm/TPM.nii,5'};
    matlabbatch{2}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{2}.spm.spatial.preproc.tissue(5).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(5).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(6).tpm = {'/usr/local/spm12/tpm/TPM.nii,6'};
    matlabbatch{2}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{2}.spm.spatial.preproc.tissue(6).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(6).warped = [0 0];
    matlabbatch{2}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{2}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{2}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{2}.spm.spatial.preproc.warp.affreg = 'eastern';
    matlabbatch{2}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{2}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{2}.spm.spatial.preproc.warp.write = [1 1];
    matlabbatch{2}.spm.spatial.preproc.warp.vox = NaN;
    matlabbatch{2}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
        NaN NaN NaN];

    %% save matlabbatch
    save(savefilename,'matlabbatch')
end
end