function [status,cmdout] = wb_map_nii2metric(wb_cfg, nii_fname_in, surf_fname_ref, metric_fname_out)
% function [status,cmdout] = wb_map_nii2metric(wb_par, nii_fname_in, surf_fname_ref, metric_fname_out)
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


if nargin==0
    [wb_cfg, nii_fname_in, surf_fname_ref, metric_fname_out] = wb_map_nii2metric_test;
end


wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-convert -from-nifti');

wb_cmd = [wb_function ' ' '"' nii_fname_in '"' ' ' '"' surf_fname_ref '"' ' ' '"' metric_fname_out '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('file %s mapped on metric %s\n', nii_fname_in, metric_fname_out)
else
    display(cmdout);
end

function [wb_cfg, nii_file, surf_file, metric_file] = wb_map_nii2metric_test

wb_cfg      = wb_parameters;
nii_file    = 'D:\Projects\STATES\analysis\data\group\stat\2BS1BV_smth8\onesampleT\all vs rest\spmT_0001.nii';
surf_file   = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
metric_file    = './test/states_allVSrest_spmT_0001_METRIC.nii.func.gii';