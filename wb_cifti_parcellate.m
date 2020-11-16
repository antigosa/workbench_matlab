function [status,cmdout] = wb_cifti_parcellate(wb_cfg, cifti_in, cifti_label, direction, cifti_out, opts)
% function [status,cmdout] = wb_cifti_parcellate(wb_cfg, cifti_in, cifti_label, direction, cifti_out, opts)
% PARCELLATE A CIFTI FILE
%    wb_command -cifti-parcellate
%       <cifti-in> - the cifti file to parcellate
%       <cifti-label> - a cifti label file to use for the parcellation
%       <direction> - which mapping to parcellate (integer, ROW, or COLUMN)
%       <cifti-out> - output - output cifti file
% 
%       [-spatial-weights] - use voxel volume and either vertex areas or metric
%          files as weights
% 
%          [-left-area-surf] - use a surface for left vertex areas
%             <left-surf> - the left surface to use, areas are in mm^2
% 
%          [-right-area-surf] - use a surface for right vertex areas
%             <right-surf> - the right surface to use, areas are in mm^2
% 
%          [-cerebellum-area-surf] - use a surface for cerebellum vertex areas
%             <cerebellum-surf> - the cerebellum surface to use, areas are in
%                mm^2
% 
%          [-left-area-metric] - use a metric file for left vertex weights
%             <left-metric> - metric file containing left vertex weights
% 
%          [-right-area-metric] - use a metric file for right vertex weights
%             <right-metric> - metric file containing right vertex weights
% 
%          [-cerebellum-area-metric] - use a metric file for cerebellum vertex
%             weights
%             <cerebellum-metric> - metric file containing cerebellum vertex
%                weights
% 
%       [-cifti-weights] - use a cifti file containing weights
%          <weight-cifti> - the weights to use, as a cifti file
% 
%       [-method] - specify method of parcellation (default MEAN, or MODE if
%          label data)
%          <method> - the method to use to assign parcel values from the values
%             of member brainordinates
% 
%       [-exclude-outliers] - exclude non-numeric values and outliers from each
%          parcel by standard deviation
%          <sigma-below> - number of standard deviations below the mean to
%             include
%          <sigma-above> - number of standard deviations above the mean to
%             include
% 
%       [-only-numeric] - exclude non-numeric values
% 
%       Each label in the cifti label file will be treated as a parcel, and all
%       rows or columns within the parcel are averaged together to form the
%       output row or column.  The direction can be either an integer starting
%       from 1, or the strings 'ROW' or 'COLUMN'.  For dtseries or dscalar, use
%       COLUMN.  If you are parcellating a dconn in both directions, parcellating
%       by ROW first will use much less memory.
% 
%       The parameter to the -method option must be one of the following:
% 
%       MAX: the maximum value
%       MIN: the minimum value
%       INDEXMAX: the 1-based index of the maximum value
%       INDEXMIN: the 1-based index of the minimum value
%       SUM: add all values
%       PRODUCT: multiply all values
%       MEAN: the mean of the data
%       STDEV: the standard deviation (N denominator)
%       SAMPSTDEV: the sample standard deviation (N-1 denominator)
%       VARIANCE: the variance of the data
%       TSNR: mean divided by sample standard deviation (N-1 denominator)
%       COV: sample standard deviation (N-1 denominator) divided by mean
%       MEDIAN: the median of the data
%       MODE: the mode of the data
%       COUNT_NONZERO: the number of nonzero elements in the data
% 
%       The -*-weights options are mutually exclusive and may only be used with
%       MEAN, SUM, STDEV, SAMPSTDEV, VARIANCE, MEDIAN, or MODE.


if nargin==0
    [wb_cfg, cifti_in, cifti_label, direction, cifti_out] = wb_cifti_parcellate_test;
end


% =========================================================================
% wb_command
% =========================================================================
wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-parcellate');


% =========================================================================
% command string
% =========================================================================
wb_cmd = [wb_function ' ' '"' cifti_in '"' ' ' '"' cifti_label '"' ...
    ' ' '"' direction '"' ' ' '"' cifti_out '"' 
    ];

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-cifti-parcellate executed correclty %s\n', cifti_in)
else
    display(cmdout);
end

function [wb_cfg, cifti_in, cifti_label, direction, cifti_out] = wb_cifti_parcellate_test

wb_cfg          = wb_parameters;
gii_file        = './test/onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_body_detail_model.nii.L.func.gii';
scale_mode      = 'MODE_USER_SCALE';
paletteName     = 'FSL';
neg_minMaxVal   = [0 -5];
pos_minMaxVal   = [0 5];
thresholdInfo    = {'THRESHOLD_TYPE_NORMAL', 'THRESHOLD_TEST_SHOW_INSIDE', 3, 5};
opts.disp_pos       = 1;
opts.disp_neg       = 1;