%---------------------------------------------------------
% rename_files.m
%
% Helps rename a batch of files for each subject.
%
% Inputs:
%   - oldfilespec:  The format of the file name to be changed. This is to be filled in
%                   as the string in the sprintf function. (eg: sub-%03d_T1W.nii)
%                   Make sure that you specify the COMPLETE PATH.
%   - newfilespec:  The format of the file name to change to. This is to be filled in
%                   as the string in the sprintf function. (eg: sub-%03d_T1W.nii)
%                   Make sure that you specify the COMPLETE PATH.
%   - subjlist:     The list of subject numbers that have the file to be changed.
%
% Outputs:
%   - errorlist:    The numbers of subjects that don't have the file
%                   specified.
%
% Created by Jess CC Hsing 2023/03/04
%---------------------------------------------------------


function errorlist = rename_files(oldfilespec, newfilespec, subjlist)
errorlist = [];
fprintf('Now at subject 000\n');
for subjn = subjlist
    oldfilename = sprintf(oldfilespec,subjn,subjn);
    newfilename = sprintf(newfilespec,subjn,subjn);
    fprintf('\b\b\b\b%03d\n',subjn)
    if isfile(oldfilename)
        movefile(oldfilename,newfilename)
    else
        errorlist = [errorlist subjn];
    end
end