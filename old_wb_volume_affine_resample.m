function [status,cmdout] = wb_volume_affine_resample(wb_cfg, volume_in, threshold, min_vol, volume_out, roi_name)
% function [status,cmdout] = wb_metric_find_cluster(wb_cfg, volume_in, threshold, min_vol, volume_out, roi_name)
% RESAMPLE VOLUME USING AFFINE TRANSFORM
%    wb_command -volume-affine-resample
%       <volume-in> - volume to resample
%       <affine> - the affine file to apply
%       <volume-space> - a volume file in the volume space you want for the
%          output
%       <method> - the resampling method
%       <volume-out> - output - the output volume
% 
%       [-flirt] - MUST be used if affine is a flirt affine
%          <source-volume> - the source volume used when generating the affine
%          <target-volume> - the target volume used when generating the affine
% 
%       Resample a volume file with an affine transformation.  The recommended
%       methods are CUBIC (cubic spline) for most data, and ENCLOSING_VOXEL for
%       label data.  The parameter <method> must be one of:
% 
%       CUBIC
%       ENCLOSING_VOXEL
%       TRILINEAR



if nargin==0
    [wb_cfg, volume_in, threshold, min_vol, volume_out, roi_name] = wb_add2spec_test;
end 

if nargin == 5
    roi_name = [];
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -volume-find-clusters');

if ~isempty(roi_name)
    wb_cmd = [wb_function ' ' '"' volume_in '"' ' ' num2str(threshold) ' ' num2str(min_vol) ' ' '"' volume_out '"'];
else
    wb_cmd = [wb_function ' ' '"' volume_in '"' ' ' num2str(threshold) ' ' num2str(min_vol) ' ' '"' volume_out '"' ' ' '"' roi_name '"'];

end

[status,cmdout] = system(wb_cmd);

function [wb_cfg, volume_in, threshold, min_vol, volume_out, roi_name] = wb_add2spec_test

wb_cfg      = wb_parameters;
threshold   = tinv(1-0.005,11);
min_vol    = 10;
volume_in   = 'D:\Projects\Luigi\fmri data\group\ttest\Localiser\onesampleT\smth8\Localiser_all_vs_rest_Tstat.nii';
volume_out  = strcat('cluster_', volume_in);
roi_name    = [];