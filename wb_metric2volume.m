function [status,cmdout] = wb_metric2volume(metric_in, surf_fname_ref, volume_ref, volume_out, opt)
% function [status,cmdout] = wb_map_nii2metric(wb_par, metric_in, surf_fname_ref, volume_ref, volume_out, opt)
% MAP METRIC FILE TO VOLUME
%    wb_command -metric-to-volume-mapping
%       <metric> - the input metric file
%       <surface> - the surface to use coordinates from
%       <volume-space> - a volume file in the desired output volume space
%       <volume-out> - output - the output volume file
% 
%       [-nearest-vertex] - use the value from the vertex closest to the voxel
%          center
%          <distance> - how far from the surface to map values to voxels, in mm
% 
%       [-ribbon-constrained] - use ribbon constrained mapping algorithm
%          <inner-surf> - the inner surface of the ribbon
%          <outer-surf> - the outer surface of the ribbon
% 
%          [-voxel-subdiv] - voxel divisions while estimating voxel weights
%             <subdiv-num> - number of subdivisions, default 3
% 
%       Maps values from a metric file into a volume file.  You must specify
%       exactly one mapping method option.  The -nearest-vertex method uses the
%       value from the vertex closest to the voxel center (useful for integer
%       values).  The -ribbon-constrained method uses the same method as in
%       -volume-to-surface-mapping, then uses the weights in reverse.  

if nargin==0
    [metric_in, surf_fname_ref, volume_ref, volume_out] = wb_metric2volume_test;
end

if nargin<5
    opt.method='nearest_vertex';
    opt.distance=5;
end

wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% wb_function = strcat('"', wb_command, '"', ' -metric-to-volume-mapping');
% wb_cmd = [wb_function ' ' '"' metric_in '"' ' ' '"' surf_fname_ref '"' ' ' '"' volume_ref '"' ' ' '"' volume_out '"'];

wb_cmd=[wb_command ' -metric-to-volume-mapping ' metric_in ' ' surf_fname_ref ' ' volume_ref ' ' volume_out];

switch opt.method
    case 'nearest_vertex'
       distanceFromSurf = opt.distance;
        wb_cmd = [wb_cmd ' -nearest-vertex 5'];
        
    case 'ribbon_constrained'
        inner_surf = opt.inner_surf;
        outer_surf = opt.outer_surf;
        voxel_subdiv = opt.voxel_subdiv;
        wb_cmd = [wb_cmd ' -ribbon-constrained 5'];        
end


[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('file %s mapped on volume %s\n', metric_in, volume_out)
else
    display(cmdout);
end

function [wb_cfg, metric_in, surf_fname_ref, volume_ref, volume_out] = wb_metric2volume_test

pathToSurf = 'D:/Data/fmri/Glasser_et_al_2016_HCP_MMP1.0_RVVG/HCP_PhaseTwo/Q1-Q6_RelatedParcellation210/MNINonLinear';

wb_cfg          = wb_parameters;
metric_in       = 'D:\Projects\Luigi\fmri data\workbench\3b.func.gii';
surf_fname_ref  = fullfile(pathToSurf, 'fsaverage_LR32k', 'Q1-Q6_RelatedParcellation210.L.inflated_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii');
volume_ref      = 'D:\Projects\Luigi\fmri data\group\ttest\Localiser\onesampleT\smth8/Localiser_all_vs_rest_Tstat.nii';
volume_out      = strrep(metric_in, '.func.gii', '.nii');