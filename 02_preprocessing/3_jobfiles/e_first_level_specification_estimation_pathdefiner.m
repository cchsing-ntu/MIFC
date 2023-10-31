%-----------------------------------------------------------------------
% Job saved on 25-Feb-2023 16:35:47 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
function e_first_level_specification_estimation_pathdefiner(subjlist)
for subjno=subjlist
    %% Set up environmental variables
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);
    savefilename=strcat('../4_batchfiles/e_first_level_',subjstr);

    func_dir = strcat(subjdir,'/func');
    multi_reg_text = strcat(subjdir,'/PhysIO/multiple_regressors.txt');
    SPMmat = strcat(subjdir,'/func/SPM.mat');
    arRrest_epi_files=cell(180,1);
    for img = 1:180
        arRrest_epi_files{img,1}=strcat(subjdir,'/func/arR',subjstr,'_task-rest_bold.nii,',num2str(img));
    end



    matlabbatch{1}.spm.stats.fmri_spec.dir = {func_dir}; % changed here
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 38;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 2;
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess.scans = arRrest_epi_files; % changed here
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {multi_reg_text}; % changed here
    matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {SPMmat}; % changed here
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 1;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

    save(savefilename,'matlabbatch')
end
end