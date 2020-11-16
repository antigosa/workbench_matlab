function [status,cmdout] = wb_file_info(wb_cfg, fname)
% function [status,cmdout] = wb_file_info(wb_par, surf_file)
%    wb_command -file-information
%       <data-file> - data file
% 
%       [-no-map-info] - do not show map information for files that support maps
% 
%       [-only-step-interval] - suppress normal output, print the interval
%          between maps
% 
%       [-only-number-of-maps] - suppress normal output, print the number of maps
% 
%       [-only-map-names] - suppress normal output, print the names of all maps
% 
%       [-only-metadata] - suppress normal output, print file metadata
% 
%          [-key] - only print the metadata for one key, with no formatting
%             <key> - the metadata key
% 
%       List information about the content of a data file.  Only one -only option
%       may be specified.  The information listed when no -only option is present
%       is dependent upon the type of data file.

if nargin==0
    [wb_cfg, fname] = wb_file_info_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -file-information');

wb_cmd = [wb_function ' ' '"' fname '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('Information about the surface %s\n', fname)
else
    display(cmdout);
end

function [wb_cfg, fname] = wb_file_info_test

wb_cfg      = wb_parameters;
% anat
% surf_file   = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
% func
fname   = 'D:\Projects\RESPACT\analysis\results\univariate\group\ttest\onesampleT\smth8\catch_vs_images_FDR_mask.nii.R.func.gii';