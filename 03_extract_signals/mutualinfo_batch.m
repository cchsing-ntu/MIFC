%---------------------------------------------------------
% mutualinfo_batch.m
%
% A function called by main_nifti_to_mat. This function helps calculate the
% mutual information of each ROI by calling the mutualinfo function.
% A corresponding file is saved in
% ../Data/derivatives/mat/b_mi_r_values/n_roi
%
% Inputs:
%   - subjno:   The current subject number to be processed.
%   - source:   The source ROI number to calculate. (1)VTA (2)DRN (3)MRN (4)LC.
%   - r:        Number of bins.
%   - lag:      number of time shifts.
%   - gpumode:  GPU mode flag 0 = 'no', 1 = 'yes'.
%   - nshuf:    Integer no. of shuffles to apply and test against (0: no shuffling).
%
% Outputs:
%   The outputs of this function is automatically saved.
%
% Created by Jess CC Hsing 2023/02/27 based on the previous version
%---------------------------------------------------------

function mutualinfo_batch(subjno,source,r,lag,gpumode,nshuf)
%% Evaluate input arguments
switch nargin
    case 2 ; error('Please enter source no:(1)VTA (2)DRN (3)MRN (4)LC. ')
    case 3 ; r = 12; lag = 0; gpumode = 0; nshuf = 0;
    case 4 ; lag = 0; gpumode = 0; nshuf = 0;
    case 5 ; gpumode = 0; nshuf = 0;
    case 6 ; nshuf = 0;
end

%% Main function
% Step 1: Load subject data stored in res_mat
mat_dir = '/bml/Data/Bank1/MIFC/Data/derivatives/mat';
res_mat_file = sprintf('%s/a_voxel_values/sub-%03d',mat_dir,subjno);
load(res_mat_file)

S = dir(sprintf('%s/b_mi_r_values/%d*',mat_dir,source));
savefilename = sprintf('%s/b_mi_r_values/%s/sub-%03d',mat_dir,S.name,subjno);
fprintf('=======sub-%03d: Calculating MI and R (Source ROI:%s)=======',subjno,S.name)

% Step 2: Create variable W and calculate MI
W = repmat(MB_final(source,:),size(WB,1),1);
switch nshuf
    case 0
        [MI,R,PDF] = mutualinfo(W,WB,r,lag,gpumode,nshuf);
        PMI = [];
        PR = [];
    otherwise
        [MI,R,PDF,PMI,PR] = mutualinfo(W,WB,r,lag,gpumode,nshuf);
end

% Step 3: Save file
save(savefilename,'MI','R','PDF','PMI','PR','indicies','WB_size')
fprintf('Done\n',subjno)