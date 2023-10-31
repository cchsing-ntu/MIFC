%-----------------------------------------------------------------------
% Job saved on 22-Feb-2023 17:02:34 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

function c_create_midbrain_mask_pathdefiner(subjlist)
for subjno=subjlist
    %% Set up environmental variables
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);
    savefilename=strcat('../4_batchfiles/c_create_midbrain_mask_',subjstr);

    iyT1_files = strcat(subjdir,'/anat/iy_',subjstr,'_T1w.nii');
    roi_files = {sprintf('%s/func/%s_task-rest_desc-VTA_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/%s_task-rest_desc-DRN_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/%s_task-rest_desc-MRN_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/%s_task-rest_desc-LC_mask.nii,1',subjdir,subjstr)};
    wroi_files = {sprintf('%s/func/w%s_task-rest_desc-VTA_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/w%s_task-rest_desc-DRN_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/w%s_task-rest_desc-MRN_mask.nii,1',subjdir,subjstr);
                sprintf('%s/func/w%s_task-rest_desc-LC_mask.nii,1',subjdir,subjstr)};
    midbrain_mask = strcat(subjdir,'/func/',subjstr,'_task-rest_space-subj_desc-midbrain_mask.nii');
    negmidbrain_mask = strcat(subjdir,'/func/',subjstr,'_task-rest_space-subj_desc-negmidbrain_mask.nii');


    matlabbatch{1}.spm.spatial.normalise.write.subj.def = {iyT1_files}; %changed here
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample = roi_files; %changed here
    matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
        78 76 85];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3.4 3.4 4];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
    matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
    matlabbatch{2}.spm.util.imcalc.input = wroi_files; %changed here
    matlabbatch{2}.spm.util.imcalc.output = midbrain_mask; %changed here
    matlabbatch{2}.spm.util.imcalc.outdir = {''};
    matlabbatch{2}.spm.util.imcalc.expression = 'i1+i2+i3+i4';
    matlabbatch{2}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{2}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{2}.spm.util.imcalc.options.mask = 0;
    matlabbatch{2}.spm.util.imcalc.options.interp = 1;
    matlabbatch{2}.spm.util.imcalc.options.dtype = 4;
    matlabbatch{3}.spm.util.imcalc.input = {midbrain_mask}; %changed here
    matlabbatch{3}.spm.util.imcalc.output = negmidbrain_mask; %changed here
    matlabbatch{3}.spm.util.imcalc.outdir = {''};
    matlabbatch{3}.spm.util.imcalc.expression = 'i1<0.01';
    matlabbatch{3}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{3}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{3}.spm.util.imcalc.options.mask = 0;
    matlabbatch{3}.spm.util.imcalc.options.interp = 1;
    matlabbatch{3}.spm.util.imcalc.options.dtype = 4;

    save(savefilename,'matlabbatch')
end
end