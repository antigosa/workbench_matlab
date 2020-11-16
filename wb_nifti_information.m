function [status,cmdout] = wb_nifti_information(wb_cfg, nifti_file, print_option)
% function [status,cmdout] = wb_nifti_information(wb_cfg, nifti_file, print_option)
% print_option: 'header' | 'matrix' | 'xml'

%% DISPLAY INFORMATION ABOUT A NIFTI/CIFTI FILE
%    wb_command -nifti-information
%       <nifti-file> - the nifti/cifti file to examine
% 
%       [-print-header] - display the header contents
% 
%       [-print-matrix] - output the values in the matrix (cifti only)
% 
%       [-print-xml] - print the cifti XML (cifti only)
% 
%          [-version] - convert the XML to a specific CIFTI version (default is
%             the file's cifti version)
%             <version> - the CIFTI version to use
% 
%       You must specify at least one -print-* option.

if nargin==0
    [wb_cfg, nifti_file, print_option] = wb_nifti_information_test;
end

print_option = strcat('-print-', print_option);

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -nifti-information');

% wb_cmd = [wb_function ' ' '"' expr '"' ' ' '"' variables '"' ' ' '"' metric_fname_out '"'];
wb_cmd = [wb_function ' ' '"' nifti_file '"' ' ' print_option];

[status,cmdout] = system(wb_cmd);
if status==0
    display(cmdout);
else
    display(cmdout);
end

function [wb_cfg, nifti_file, print_option] = wb_nifti_information_test

wb_cfg              = wb_parameters;
nifti_file          = './test/sub-01_T1w_iihc_mni.nii';
print_option        = 'header';  %'header'; 'xml'