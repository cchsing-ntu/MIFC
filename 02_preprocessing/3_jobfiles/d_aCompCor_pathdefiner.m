%-----------------------------------------------------------------------
% Job saved on 23-Feb-2023 19:31:04 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
function d_aCompCor_pathdefiner(subjlist)
for subjno=subjlist
    %% Set up environmental variables
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);
    savefilename=strcat('../4_batchfiles/d_aCompcor_',subjstr);

    PhysIO_dir = strcat(subjdir,'/PhysIO');
    arRrest_files =  strcat(subjdir,'/func/arR',subjstr,'_task-rest_bold.nii');
    noise_files = {strcat(subjdir,'/anat/mc2',subjstr,'_T1w.nii');
        strcat(subjdir,'/anat/c3',subjstr,'_T1w.nii')};
    rp_text = strcat(subjdir,'/func/rp_R',subjstr,'_task-rest_bold.txt');

    matlabbatch{1}.spm.tools.physio.save_dir = {PhysIO_dir}; %changed here
    matlabbatch{1}.spm.tools.physio.log_files.vendor = 'Philips';
    matlabbatch{1}.spm.tools.physio.log_files.cardiac = {''};
    matlabbatch{1}.spm.tools.physio.log_files.respiration = {''};
    matlabbatch{1}.spm.tools.physio.log_files.scan_timing = {''};
    matlabbatch{1}.spm.tools.physio.log_files.sampling_interval = [];
    matlabbatch{1}.spm.tools.physio.log_files.relative_start_acquisition = 0;
    matlabbatch{1}.spm.tools.physio.log_files.align_scan = 'last';
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Nslices = 38;
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.NslicesPerBeat = [];
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.TR = 2;
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Ndummies = 0;
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Nscans = 180;
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.onset_slice = 2;
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.time_slice_to_slice = [];
    matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Nprep = [];
    matlabbatch{1}.spm.tools.physio.scan_timing.sync.nominal = struct([]);
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.modality = 'ECG';
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter.no = struct([]);
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.initial_cpulse_select.auto_matched.min = 0.4;
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.initial_cpulse_select.auto_matched.file = 'initial_cpulse_kRpeakfile.mat';
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.initial_cpulse_select.auto_matched.max_heart_rate_bpm = 90;
    matlabbatch{1}.spm.tools.physio.preproc.cardiac.posthoc_cpulse_select.off = struct([]);
    matlabbatch{1}.spm.tools.physio.preproc.respiratory.filter.passband = [0.01 2];
    matlabbatch{1}.spm.tools.physio.preproc.respiratory.despike = false;
    matlabbatch{1}.spm.tools.physio.model.output_multiple_regressors = 'multiple_regressors.txt';
    matlabbatch{1}.spm.tools.physio.model.output_physio = 'physio.mat';
    matlabbatch{1}.spm.tools.physio.model.orthogonalise = 'none';
    matlabbatch{1}.spm.tools.physio.model.censor_unreliable_recording_intervals = false;
    matlabbatch{1}.spm.tools.physio.model.retroicor.no = struct([]);
    matlabbatch{1}.spm.tools.physio.model.rvt.no = struct([]);
    matlabbatch{1}.spm.tools.physio.model.hrv.no = struct([]);
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.fmri_files = {arRrest_files}; %changed here
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.roi_files = noise_files; %changed here
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.force_coregister = 'Yes';
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.thresholds = 0.95;
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.n_voxel_crop = 0;
    matlabbatch{1}.spm.tools.physio.model.noise_rois.yes.n_components = 5;
    matlabbatch{1}.spm.tools.physio.model.movement.yes.file_realignment_parameters = {rp_text};
    matlabbatch{1}.spm.tools.physio.model.movement.yes.order = 12;
    matlabbatch{1}.spm.tools.physio.model.movement.yes.censoring_method = 'none';
    matlabbatch{1}.spm.tools.physio.model.movement.yes.censoring_threshold = 0.5;
    matlabbatch{1}.spm.tools.physio.model.other.no = struct([]);
    matlabbatch{1}.spm.tools.physio.verbose.level = 1;
    matlabbatch{1}.spm.tools.physio.verbose.fig_output_file = 'PhysIO_output_file.ps';
    matlabbatch{1}.spm.tools.physio.verbose.use_tabs = false;

    save(savefilename,'matlabbatch')
end
end