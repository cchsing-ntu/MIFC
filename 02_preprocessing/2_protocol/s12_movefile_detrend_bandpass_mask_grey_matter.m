%% ========== rp_detrend an rp_bandpass ==========
%  - Please have the REST toolbox set as path before analysis.
%  - Make sure you have both main directory of REST and the basic_function
%   directory in the MATLAB path.
%
%  Usage:
%
%  Written by Jess CC Hsing 2021/03/15
%  Edited by Jess CC Hsing 2020/03/18
%  Edited by Jess CC Hsing 2023/02/26
%% ===============================================

function s12_movefile_detrend_bandpass_mask_grey_matter(subjlist)

tic
for subjno = subjlist
    %% Set subject directory
    subjdir=sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr=sprintf('sub-%03d',subjno);
    fprintf('===================Now Working on Subject %03d========================\n',subjno)

    %% Set srtings for specific files
    res_files = sprintf('%s/func/Res_*.nii',subjdir);   % Residuals to move in step 1-1
    beta_files = sprintf('%s/func/beta_*.nii',subjdir); % Beta files to move in step 1-2
    spm_mat = sprintf('%s/func/SPM.mat',subjdir);       % SPM.mat files to move in step 1-2
    rpv_nii= sprintf('%s/func/RPV.nii',subjdir);        % RPV.nii files to move in step 1-2
    resms_nii = sprintf('%s/func/ResMS.nii',subjdir);   % ResMS.nii files to move in step 1-2
    mask_nii = sprintf('%s/func/mask.nii',subjdir);     % mask.nii files to move in step 1-2
    gm_file = sprintf('%s/anat/c1%s_T1w.nii',subjdir,subjstr);  % Grey matter mask for step 4
    filtered_4D = sprintf('%s/Residuals_detrend_filtered/Filtered_4DVolume.nii',subjdir);   %filtered_4D file to be masked in step 4

    res_dir = sprintf('%s/Residuals',subjdir);          % Residuals directory to move in step 1-1
    first_level_dir = sprintf('%s/first_level',subjdir);    % first level directory to move in step 1-2
    detrend_dir = sprintf('%s/Residuals_detrend',subjdir);  % detrend directory to bandpass in step 3

    %% Make directory if directory does not exist
    if ~isdir(res_dir); mkdir(res_dir); end
    if ~isdir(first_level_dir); mkdir(first_level_dir); end

    %% Step 1-1: Organize ./func by moving the Res*.nii to ./Residuals
    fprintf('===================Subject %03d: 1.Organizing Files===================\n',subjno)
    movefile(res_files,res_dir);

    %% Step 1-2: Organize ./func by moving files generated after first level estimation to ./first_level
    movefile(beta_files,first_level_dir);
    movefile(spm_mat,first_level_dir);
    movefile(rpv_nii,first_level_dir);
    movefile(resms_nii,first_level_dir);
    movefile(mask_nii,first_level_dir);

    %% Step 2: Detrend files with the RESTplus toolbox
    fprintf('===================Subject %03d: 2.Detrending=========================\n',subjno)
    rp_detrend(res_dir, '_detrend')

    %% Step 3: Bandpass files with the RESTplus toolbox
    fprintf('===================Subject %03d: 3.Bandpassing======================\n',subjno)
    rp_bandpass(detrend_dir, 2, 0.08, 0.009, 'Yes', 0)

    %% Step 4: Mask gery matter for the processed images
    fprintf('===================Subject %03d: 4.Masking Grey Matter==============\n',subjno)
    spm_mask(gm_file,filtered_4D, 0.0001);
end
toc