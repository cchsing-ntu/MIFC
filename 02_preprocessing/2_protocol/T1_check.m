%% T1_check.m
% This script is a combination of commands for one to check batches of T1 files all at once.
% Rather than running this script as a code. I would run these codes section by section. (cmd+enter or ctrl+enter)
% 
% Dependencies: SPM12
%
% History:
% 2022.11.22 Created by Jess CC Hsing based on previous versions
% 2023.02.17 Adjusted file to call for added new procedure.
% 2023.10.31 Added text to explain how to use this code.
%% 

%% Logic of the check registration function 
%This is to demo that you can use the spm_check_registration function instead of using the GUI
P = spm_select(Inf,'image','Select images',[],pwd);
spm_check_registration(deblank(P));

%% Create a cell arrat called 'T1_files' that stores all the T1 paths
%Set up and find directory names
basepath = 'path/to/your/nifti'; % Change this to the path to your nifti base directory
subdir = dir(sprintf('%s/sub-*',basepath));
subs = {subdir(:).name};

% Preallocation
nsub = length(subs); % number of subjects
T1files = cell(nsub,1);
MIfiles = cell(nsub,1);

% Create cell array that saves data
for i = 1:length(subdir)
T1files{i} = sprintf('%s/%s/anat/%s_T1w.nii',basepath,subs{i},subs{i});
end

%% Initializing to prepare for the check
K = char(deblank(T1files));
n = 1;

%% This is the section that you run repeatedly to check through all files
spm_check_registration(K(n:n+8,:)); % Specify how many files you want to view at once
n = n+12;
