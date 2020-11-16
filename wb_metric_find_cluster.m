function [status,cmdout] = wb_metric_find_cluster(wb_cfg, surf_file, gii_file, threshold, min_area, gii_output, op)
% function [status,cmdout] = wb_metric_find_cluster(wb_cfg, surf_file, gii_file, threshold, min_area, gii_output, op)
%   wb_command -metric-find-clusters
%       <surface> - the surface to compute on
%       <metric-in> - the input metric
%       <value-threshold> - threshold for data values
%       <minimum-area> - threshold for cluster area, in mm^2
%       <metric-out> - output - the output metric
% 
%       [-less-than] - find values less than <value-threshold>, rather than
%          greater
% 
%       [-roi] - select a region of interest
%          <roi-metric> - the roi, as a metric
% 
%       [-corrected-areas] - vertex areas to use instead of computing them from
%          the surface
%          <area-metric> - the corrected vertex areas, as a metric
% 
%       [-column] - select a single column
%          <column> - the column number or name
% 
%       [-size-ratio] - ignore clusters smaller than a given fraction of the
%          largest cluster in map
%          <ratio> - fraction of the largest cluster's area
% 
%       [-distance] - ignore clusters further than a given distance from the
%          largest cluster
%          <distance> - how far from the largest cluster a cluster can be, edge
%             to edge, in mm
% 
%       [-start] - start labeling clusters from a value other than 1
%          <startval> - the value to give the first cluster found
% 
%       Outputs a metric with nonzero integers for all vertices within a large
%       enough cluster, and zeros elsewhere.  The integers denote cluster
%       membership (by default, first cluster found will use value 1, second
%       cluster 2, etc).  By default, values greater than <value-threshold> are
%       considered to be in a cluster, use -less-than to test for values less
%       than the threshold.  To apply this as a mask to the data, or to do more
%       complicated thresholding, see -metric-math.

if nargin==0
    [wb_cfg, surf_file, gii_file, threshold, min_area, gii_output] = wb_add2spec_test;
end

if nargin==6; op='-greater-than';end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-find-clusters');

wb_cmd = [wb_function ' ' '"' surf_file '"' ' ' '"' gii_file '"' ' ' num2str(threshold) ' ' num2str(min_area) ' ' '"' gii_output '"'];

if strcmp(op, '-less-than')
    wb_cmd = [wb_cmd ' ' op];
end

[status,cmdout] = system(wb_cmd);

if status ~=0
    display(cmdout);
else
    fprintf('cluster analysis completed\n');
end

function [wb_cfg, surf_file, gii_file, threshold, min_area, gii_output] = wb_add2spec_test

wb_cfg      = wb_parameters;
threshold   = tinv(1-0.00001,19);
min_area    = 10;
surf_file   = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
gii_file    = './test/states_allVSrest_spmT_0001.nii.func.gii';
gii_output  = './test/cluster_states_allVSrest_spmT_0001.nii.func.gii';