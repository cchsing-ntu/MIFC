%---------------------------------------------------------
% delete files.m
%
% Helps deletefiles across subjects. 
%
% Inputs:
%   - filespec:     The format of the file name. This is to be filled in
%                   as the string in the sprintf function. (eg: sub-%03d_T1W.nii)
%                   Make sure that you specify the COMPLETE PATH.
%   - subjlist:     The list of subject numbers that are to be examined.
%
% Outputs:
%   - errorlist:    The numbers of subjects that don't have the file
%                   specified.
%
% Created by Jess CC Hsing 2023/02/15
%---------------------------------------------------------


function errorlist = delete_files(filespec, subjlist)
errorlist = [];
fprintf('Now at subject 000\n');
for subjn = subjlist
    filename = sprintf(filespec,subjn,subjn);
    fprintf('\b\b\b\b%03d\n',subjn)
    if isfile(filename)
        delete(filename)
    else
        errorlist = [errorlist subjn];
    end
end