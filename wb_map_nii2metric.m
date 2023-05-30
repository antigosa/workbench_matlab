function [status,cmdout] = wb_map_nii2metric(nii_fname_in, surf_fname_ref, metric_fname_out)
% function [status,cmdout] = wb_map_nii2metric(nii_fname_in, surf_fname_ref, metric_fname_out)
%
% FROM WORKBENCH
% % CONVERT METRIC FILE TO FAKE NIFTI
%    wb_command -metric-convert
%
%       [-to-nifti] - convert metric to nifti
%          <metric-in> - the metric to convert
%          <nifti-out> - output - the output nifti file
%
%       [-from-nifti] - convert nifti to metric
%          <nifti-in> - the nifti file to convert
%          <surface-in> - surface file to use number of vertices and structure
%             from
%          <metric-out> - output - the output metric file
%
%       The purpose of this command is to convert between metric files and nifti1
%       so that gifti-unaware programs can operate on the data.  You must specify
%       exactly one of the options.


% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -metric-convert -from-nifti ' nii_fname_in ' ' surf_fname_ref ' ' metric_fname_out];

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('file %s mapped on metric %s\n', nii_fname_in, metric_fname_out)
else
    display(cmdout);
end
