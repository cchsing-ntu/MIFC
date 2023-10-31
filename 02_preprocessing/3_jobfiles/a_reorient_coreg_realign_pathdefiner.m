%-----------------------------------------------------------------------
% Job saved on 16-Feb-2023 15:17:01 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%%
function a_reorient_coreg_realign_pathdefiner(subjlist)
for subjno=subjlist
    %% Set up environmental variables
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);

    %% For loop : 180 slices for resting state scans
    rest_epi_files=cell(180,1);
    Rrest_epi_files=cell(180,1);
    savefilename=strcat('../4_batchfiles/a_reorient_coreg_realign_',subjstr);
    T2_file = strcat(subjdir,'/anat/',subjstr,'_T2w.nii,1');
    RT2_file = strcat(subjdir,'/anat/R',subjstr,'_T2w.nii,1');
    for img = 1:180
        rest_epi_files{img,1}=strcat(subjdir,'/func/',subjstr,'_task-rest_bold.nii,',num2str(img));
        Rrest_epi_files{img,1}=strcat(subjdir,'/func/R',subjstr,'_task-rest_bold.nii,',num2str(img));
    end

    %% Details of the matlabbatch
    matlabbatch{1}.spm.util.reorient.srcfiles = [T2_file;rest_epi_files]; %changed here
    %%
    matlabbatch{1}.spm.util.reorient.transform.transF = {strcat(subjdir,'/anat/',subjstr,'_T1w_reorient.mat')}; %changed here
    matlabbatch{1}.spm.util.reorient.prefix = 'R';
    matlabbatch{2}.spm.spatial.coreg.estimate.ref = {strcat(subjdir,'/func/R',subjstr,'_task-rest_bold.nii,1')}; %changed here
    matlabbatch{2}.spm.spatial.coreg.estimate.source = {RT2_file};
    matlabbatch{2}.spm.spatial.coreg.estimate.other = {''};
    matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
    matlabbatch{3}.spm.spatial.coreg.estimate.ref = {RT2_file}; %changed here
    matlabbatch{3}.spm.spatial.coreg.estimate.source = {strcat(subjdir,'/anat/',subjstr,'_T1w.nii,1')}; %changed here
    matlabbatch{3}.spm.spatial.coreg.estimate.other = {''};
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
    %%
    matlabbatch{4}.spm.spatial.realign.estwrite.data = {Rrest_epi_files};
    %%
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{4}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{4}.spm.spatial.realign.estwrite.roptions.which = [2 1];
    matlabbatch{4}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{4}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{4}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{4}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

    %% save matlabbatch
    save(savefilename,'matlabbatch')
end
end