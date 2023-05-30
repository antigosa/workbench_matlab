function [status,cmdout] = wb_file_information(fname, opt)
% function [status,cmdout] = wb_file_information(fname, opt)
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
    fname = wb_file_info_test;
end

wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% wb_function = strcat('"', wb_cfg.wb_command, '"', ' -file-information');
% 
% wb_cmd = [wb_function ' ' '"' fname '"'];

wb_cmd=[wb_command ' -file-information ' fname];

[status,cmdout] = system(wb_cmd);
if ~isempty(cmdout)
    display(cmdout);
end

function fname = wb_file_info_test

[~, glasser_fn]  = fmri_glasser_files;

fname = fullfile(glasser_fn.folder, 'Results\tfMRI_ALLTASKS', 'Q1-Q6_RelatedParcellation210_tfMRI_ALLTASKS_level3_beta_hp200_s2_MSMAll_2_d41_WRN_DeDrift_norm.dscalar.nii');
% fname   = 'D:\Projects\RESPACT\analysis\results\univariate\group\ttest\onesampleT\smth8\catch_vs_images_FDR_mask.nii.R.func.gii';