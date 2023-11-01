%---------------------------------------------------------
% main_nifti_to_mi.m
%
% Extracts the signals from the pre-processed 4D-Volume and calculates the
% functional connectivity in terms of MI and R.
% This function depends the following scripts to run:
% extract_voxel_values.m, mutualinfo_batch.m, mutualinfo.m
%
% Inputs:
%   - subjlist: The subject IDs to be processed.
%
% Outputs:
%   The outputs of this function is automatically saved.
%
% Created by Jess CC Hsing 2023/02/27 based on the previous version
%---------------------------------------------------------

function main_nifti_to_mi(subjlist)
tic
saveerrorfilename = sprintf('Errorlist_%03d_%03d',subjlist(1),subjlist(end));
errorlist.VTA = cell(1,length(subjlist));
errorlist.DRN = cell(1,length(subjlist));
errorlist.MRN = cell(1,length(subjlist));
errorlist.LC = cell(1,length(subjlist));
for subjno = subjlist
    %% Specify file destinations
    subjdir = sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/nifti/sub-%03d',subjno);
    subjstr = sprintf('sub-%03d',subjno);
    savefilename = sprintf('/bml/Data/Bank1/MIFC/Data/derivatives/mat/a_voxel_values/%s',subjstr);

    m4DVolume = strcat(subjdir,'/Residuals_detrend_filtered/mFiltered_4DVolume.nii');
    wvta_files = strcat(subjdir,'/func/w',subjstr,'_task-rest_desc-VTA_mask.nii');
    wdrn_files = strcat(subjdir,'/func/w',subjstr,'_task-rest_desc-DRN_mask.nii');
    wmrn_files = strcat(subjdir,'/func/w',subjstr,'_task-rest_desc-MRN_mask.nii');
    wlc_files = strcat(subjdir,'/func/w',subjstr,'_task-rest_desc-LC_mask.nii');

    %% Extract whole brain signal
    clear indicies WB MB_final
    data = spm_read_vols(spm_vol(char(m4DVolume))); %data is a 4d (l*m*n*n_vol double array)

    %% Extract midbrain signal
    rest_epi_files=cell(180,1);
    MB_final=zeros(180,4);

    for img = 1:180
        rest_epi_files{img,1}=strcat(m4DVolume,',',num2str(img));
        MB_final(img,1)=extract_voxel_values(wvta_files,rest_epi_files{img},'subj',0.0001);
        MB_final(img,2)=extract_voxel_values(wdrn_files,rest_epi_files{img},'subj',0.0001);
        MB_final(img,3)=extract_voxel_values(wmrn_files,rest_epi_files{img},'subj',0.0001);
        MB_final(img,4)=extract_voxel_values(wlc_files,rest_epi_files{img},'subj',0.0001);
    end

    MB_final = MB_final';

    %% Extract place and value information from the data
    fprintf('=======sub-%03d: Extracting whole brain signal============',subjno)

    indicies = find(~isnan(data(:,:,:,1))&data(:,:,:,1)~=0);% for place information only extract the first volume
    WB = data(~isnan(data)&data~=0);
    WB = reshape(WB,length(indicies),180); % make the data into a 59578*180 matrix, as we want it to be
    WB_size=size(data);

    save(savefilename,'indicies','WB','MB_final','WB_size')
    fprintf('Done, file saved.\n')

    %% Calculate MI and R
    fprintf('=======sub-%03d: Calculating MI and R values===================\n',subjno)
    try
        mutualinfo_batch(subjno,1,10,0,0,0)
    catch VTAerror
        errorlist.VTA{subjlist==subjno}=subjno;
        switch VTAerror.identifier
            case 'MATLAB:catenate:dimensionMismatch'
                warning('sub-%03d: Dimensions of arrays being concatenated are not consistent',subjno);
            otherwise
                rethrow(VTAerror)
        end
    end

    try
        mutualinfo_batch(subjno,2,10,0,0,0)
    catch DRNerror
        errorlist.DRN{subjlist==subjno}=subjno;
        switch DRNerror.identifier
            case 'MATLAB:catenate:dimensionMismatch'
                warning('sub-%03d: Dimensions of arrays being concatenated are not consistent',subjno);

            otherwise
                rethrow(DRNerror)
        end
    end

    try
        mutualinfo_batch(subjno,3,10,0,0,0)
    catch MRNerror
        errorlist.MRN{subjlist==subjno}=subjno;
        switch MRNerror.identifier
            case 'MATLAB:catenate:dimensionMismatch'
                warning('sub-%03d: Dimensions of arrays being concatenated are not consistent',subjno);

            otherwise
                rethrow(MRNerror)
        end
    end

    try
        mutualinfo_batch(subjno,4,10,0,0,0)
    catch LCerror
        errorlist.LC{subjlist==subjno}=subjno;
        switch LCerror.identifier
            case 'MATLAB:catenate:dimensionMismatch'
                warning('sub-%03d: Dimensions of arrays being concatenated are not consistent',subjno);
            otherwise
                rethrow(LCerror)
        end
    end
    fprintf('=======sub-%03d data is processed!============================\n',subjno)
end

%% Save errorlist
errorlist.VTA = cell2mat(errorlist.VTA);
errorlist.DRN = cell2mat(errorlist.DRN);
errorlist.MRN = cell2mat(errorlist.MRN);
errorlist.LC = cell2mat(errorlist.LC);
save(saveerrorfilename,'errorlist')
toc
end