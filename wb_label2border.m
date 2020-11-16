function [status,cmdout] = wb_label2border(wb_cfg, surf_file, label_in, border_out)
% function [status,cmdout] = wb_label2border(wb_cfg, surf_file, label_in, border_out)
% DRAW BORDERS AROUND LABELS
%    wb_command -label-to-border
%       <surface> - the surface to use for neighbor information
%       <label-in> - the input label file
%       <border-out> - output - the output border file
% 
%       [-placement] - set how far along the edge border points are drawn
%          <fraction> - fraction along edge from inside vertex (default 0.33)
% 
%       [-column] - select a single column
%          <column> - the column number or name
% 
%       For each label, finds all edges on the mesh that cross the boundary of
%       the label, and draws borders through them.  By default, this is done on
%       all columns in the input file, using the map name as the class name for
%       the border. 

if nargin==0
    [wb_cfg, label_in, surf_file, border_out] = wb_label2border_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -label-to-border');

wb_cmd = [wb_function ' ' '"' surf_file '"' ' ' '"' label_in '"' ' ' '"' border_out '"'];

[status,cmdout] = system(wb_cmd);
if status==0
    fprintf('borders created correclty in %s\n', border_out)
else
    display(cmdout);
end

function [wb_cfg, label_in, surf_file, border_out] = wb_label2border_test
cd('D:\Projects\2018\pRF_hands\Experiment\Exp1_estimating_hand_pRFs\bash_script\roi_HCPMMP1_subjectSpace\S101\label')
wb_cfg          = wb_parameters;
label_in        = './test/Q1-Q6_RelatedParcellation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii';
surf_file       = 'D:\Data\fmri\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.R.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
border_out      = sprintf('./test/test.nii');
