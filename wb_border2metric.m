function [status,cmdout] = wb_border2metric(wb_cfg, surf_fname_ref, border_fname, metric_out)
% function [status,cmdout] = wb_border2metric(wb_par, surf_fname_ref, border_fname, volume_out)
% MAKE METRIC ROIS FROM BORDERS
%    wb_command -border-to-rois
%       <surface> - the surface the borders are drawn on
%       <border-file> - the border file
%       <metric-out> - output - the output metric file
% 
%       [-border] - create ROI for only one border
%          <name> - the name of the border
% 
%       [-inverse] - use inverse selection (outside border)
% 
%       By default, draws ROIs inside all borders in the border file, as separate
%       metric columns.


if nargin==0
    [wb_cfg, surf_fname_ref, border_fname, metric_out] = wb_border2metric_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -border-to-rois');

wb_cmd = [wb_function ' ' '"' surf_fname_ref '"' ' ' '"' border_fname '"' ' ' '"' metric_out '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('file %s mapped on metric %s\n', border_fname, metric_out)
else
    display(cmdout);
end

function [wb_cfg, surf_fname_ref, border_fname, metric_out] = wb_border2metric_test

pathToSurf = 'D:/Data/fmri/Glasser_et_al_2016_HCP_MMP1.0_RVVG/HCP_PhaseTwo/Q1-Q6_RelatedParcellation210/MNINonLinear';

wb_cfg          = wb_parameters;
surf_fname_ref  = fullfile(pathToSurf, 'fsaverage_LR32k', 'Q1-Q6_RelatedParcellation210.R.inflated_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii');
check_existance_files(surf_fname_ref);
border_fname    = fullfile(pathToSurf, 'fsaverage_LR32k', 'Q1-Q6_RelatedParcellation210.R.CorticalAreas_dil_Final_Final_Areas_Group_Colors_fine_fine_fine_fine.32k_fs_LR.border');
check_existance_files(border_fname);
metric_out      = 'glasser_rois.R.func.gii';