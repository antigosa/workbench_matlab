function [status,cmdout] = wb_metric_mask(wb_cfg, metric_fname_in, metric_fname_mask, metric_fname_out)
% function [status,cmdout] = wb_metric_mask(wb_cfg, metric_fname_in, metric_fname_mask, metric_fname_out)
%
% MASK A METRIC FILE
%    wb_command -metric-mask
%       <metric> - the input metric
%       <mask> - the mask metric
%       <metric-out> - output - the output metric
% 
%       [-column] - select a single column
%          <column> - the column number or name
% 
%       By default, the output metric is a copy of the input metric, but with
%       zeros wherever the mask metric is not positive.  if -column is specified,
%       the output contains only one column, the masked version of the specified
%       input column.


if nargin==0
    [wb_cfg, metric_fname_in, metric_fname_mask, metric_fname_out] = wb_metric_mask_test;
end


wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-mask');

wb_cmd = [wb_function ' ' '"' metric_fname_in '"' ' ' '"' metric_fname_mask '"' ' ' '"' metric_fname_out '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('file %s masked with file %s\n', metric_fname_in, metric_fname_mask)
else
    display(cmdout);
end

function [wb_cfg, metric_fname_in, metric_fname_mask, metric_fname_out] = wb_metric_mask_test

wb_cfg              = wb_parameters;
metric_fname_in     = './test/images_vs_rest_Tstat.nii.L.func.gii';
metric_fname_mask   = './test/images_vs_rest_Zstat_MAXSUM_p001_masked.nii.L.func.gii';
metric_fname_out    = './test/images_vs_rest_Tstat_maskedWith_Zstat_MAXSUM_p001.L.func.gii';