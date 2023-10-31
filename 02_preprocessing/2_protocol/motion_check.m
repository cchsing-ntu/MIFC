%% Motion Check
% Check if data head motion is within acceptable method. 
% A plot is created and put in the directory
% /bml/Data/Bank1/MIFC/Data/derivatives/motion_check
%
% History:
% 2022.11.18 Created by Jess CC Hsing based on AXC version
% 2023.02.17 Adjusted file to call for added new procedure.

%% 
function motion_check(subjlist)
MIFC_base = '/bml/Data/Bank1/MIFC/Data/derivatives';

for subj = subjlist
    close all
    clearvars -except MIFC_base subj subjlist
    rp_paras = {};
    rp_filename = sprintf('%s/nifti/sub-%03d/func/rp_Rsub-%03d_task-rest_bold.txt',MIFC_base,subj,subj);
    rp_paras = [rp_paras,load(rp_filename)];

    A = (rp_paras{:});
    vol_num = size(A);

    O(subj) = figure(subj);
    subplot(2,1,1)
    plot(1:vol_num(1),A(1:vol_num(1),1),1:vol_num(1),A(1:vol_num(1),2),1:vol_num(1),A(1:vol_num(1),3))
    xline(vol_num(1)/4)
    xline(vol_num(1)/4*2)
    xline(vol_num(1)/4*3)
    xline(vol_num(1))
    subjT = sprintf('REST translation (sub-%03d)',subj);
    title(subjT)

    subplot(2,1,2)
    plot(1:vol_num(1),A(1:vol_num(1),4),1:vol_num(1),A(1:vol_num(1),5),1:vol_num(1),A(1:vol_num(1),6))
    xline(vol_num(1)/4)
    xline(vol_num(1)/4*2)
    xline(vol_num(1)/4*3)
    xline(vol_num(1))
    subjR = sprintf('REST rotation (sub-%03d)',subj);
    title(subjR)
    figurename = sprintf('%s/motion_check/original_sub-%03d',MIFC_base,subj);
    saveas(O(subj),char(figurename),'png')

    F(subj) = figure(subj);
    subplot(2,1,1)
    plot(1:vol_num(1),A(1:vol_num(1),1),1:vol_num(1),A(1:vol_num(1),2),1:vol_num(1),A(1:vol_num(1),3))
    xline(vol_num(1)/4)
    xline(vol_num(1)/4*2)
    xline(vol_num(1)/4*3)
    xline(vol_num(1))
    yline(3)
    yline(-3)
    ylim([-4,4])
    subjT = sprintf('REST translation (sub-%03d)',subj);
    title(subjT)

    subplot(2,1,2)
    plot(1:vol_num(1),A(1:vol_num(1),4),1:vol_num(1),A(1:vol_num(1),5),1:vol_num(1),A(1:vol_num(1),6))
    xline(vol_num(1)/4)
    xline(vol_num(1)/4*2)
    xline(vol_num(1)/4*3)
    xline(vol_num(1))
    yline(3)
    yline(-3)
    ylim([-4,4])
    subjR = sprintf('REST rotation (sub-%03d)',subj);
    title(subjR)
    figurename = sprintf('%s/motion_check/fixed_sub-%03d',MIFC_base,subj);
    saveas(F(subj),char(figurename),'png')
end