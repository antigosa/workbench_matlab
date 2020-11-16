function [status,cmdout] = wb_metric_rois_to_border(wb_cfg, surf_file, gii_file, class_name, border_output)
% [status,cmdout] = wb_metric_rois_to_border(wb_cfg, surf_file, gii_file, class_name, border_output)
% DRAW BORDERS AROUND METRIC ROIS
%    wb_command -metric-rois-to-border
%       <surface> - the surface to use for neighbor information
%       <metric> - the input metric containing ROIs
%       <class-name> - the name to use for the class of the output borders
%       <border-out> - output - the output border file
% 
%       [-placement] - set how far along the edge border points are drawn
%          <fraction> - fraction along edge from inside vertex (default 0.33)
% 
%       [-column] - select a single column
%          <column> - the column number or name
% 
%       For each ROI column, finds all edges on the mesh that cross the boundary
%       of the ROI, and draws borders through them.  By default, this is done on
%       all columns in the input file, using the map name as the name for the
%       border.

if nargin==0
    [wb_cfg, surf_file, gii_file, class_name, border_output] = wb_metric_rois_to_border_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-rois-to-border');

wb_cmd = [wb_function ' ' '"' surf_file '"' ' ' '"' gii_file '"' ' ' '"' class_name '"' ' ' '"' border_output '"'];

[status,cmdout] = system(wb_cmd);

if status==-1
    display(cmdout);
end


function [wb_cfg, surf_file, gii_file, class_name, border_output] = wb_metric_rois_to_border_test

wb_cfg          = wb_parameters;

surf_file       = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
gii_file        = './test/onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_body_detail_model.nii.L.func.gii';
class_name      = 'test';
border_output   = './test/onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_body_detail_model.nii.L.func.gii.border'; 