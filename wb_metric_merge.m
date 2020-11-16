function [status,cmdout] = wb_metric_merge(wb_cfg, metric_out, metric_in)
% function [status,cmdout] = wb_metric_palette(wb_cfg, metric_out, metric_in)
% - metric_out: string
% - metric_in: cell of strings
% 
% MERGE METRIC FILES INTO A NEW FILE
%    wb_command -metric-merge
%       <metric-out> - output - the output metric
% 
%       [-metric] - repeatable - specify an input metric
%          <metric-in> - a metric file to use columns from
% 
%          [-column] - repeatable - select a single column to use
%             <column> - the column number or name
% 
%             [-up-to] - use an inclusive range of columns
%                <last-column> - the number or name of the last column to include
% 
%                [-reverse] - use the range in reverse order
% 
%       Takes one or more metric files and constructs a new metric file by
%       concatenating columns from them.  The input metric files must have the
%       same number of vertices and same structure.
% 
%       Example: wb_command -metric-merge out.func.gii -metric first.func.gii
%       -column 1 -metric second.func.gii
% 
%       This example would take the first column from first.func.gii, followed by
%       all columns from second.func.gii, and write these columns to
%       out.func.gii.

if nargin==0
    [wb_cfg, metric_out, metric_in] = wb_metric_merge_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-merge');

wb_cmd = [wb_function ' ' '"' metric_out '"'];

for m=1:length(metric_in)
    wb_cmd = [wb_cmd ' ' ' -metric ' '"' metric_in{m} '"'];
end

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('metrics merged\n')
else
    display(cmdout);
end

function [wb_cfg, metric_out, metric_in] = wb_metric_merge_test

wb_cfg          = wb_parameters;
metric_out      = 'out.func.gii';
metric_in       = {'in1.func.gii', 'in2.func.gii','in3.func.gii'};
