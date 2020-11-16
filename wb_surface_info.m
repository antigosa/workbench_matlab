function [status,cmdout] = wb_surface_info(wb_cfg, surf_file)
% function [status,cmdout] = wb_surface_info(wb_par, surf_file)
%   wb_command -surface-information
%       <Surface File> - Surface for which information is displayed
% 
%       Information about surface is displayed including vertices, 
%       triangles, bounding box, and spacing.

if nargin==0
    [wb_cfg, surf_file] = wb_surface_info_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -surface-information');

wb_cmd = [wb_function ' ' '"' surf_file '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('Information about the surface %s\n', surf_file)
else
    display(cmdout);
end

function [wb_cfg, surf_file] = wb_surface_info_test

wb_cfg      = wb_parameters;
% anat
% surf_file   = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
% func
surf_file   = 'D:\Projects\RESPACT\analysis\results\univariate\group\ttest\onesampleT\smth8\catch_vs_images_FDR_mask.nii.R.func.gii';