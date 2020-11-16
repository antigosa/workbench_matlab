function [status,cmdout] = wb_map_nii2surf(wb_cfg, nii_file, surf_file, gii_file, opts)
% function [status,cmdout] = wb_map_nii2surf(wb_par, nii_file, surf_file, gii_file, opts)
%   wb_command -volume-to-surface-mapping
%       <volume> - the volume to map data from
%       <surface> - the surface to map the data onto
%       <metric-out> - output - the output metric file
% 
%       [-trilinear] - use trilinear volume interpolation
% 
%       [-enclosing] - use value of the enclosing voxel
% 
%       [-cubic] - use cubic splines
% 
%       [-ribbon-constrained] - use ribbon constrained mapping algorithm
%          <inner-surf> - the inner surface of the ribbon
%          <outer-surf> - the outer surface of the ribbon
% 
%          [-volume-roi] - use a volume roi
%             <roi-volume> - the volume file
% 
%          [-voxel-subdiv] - voxel divisions while estimating voxel weights
%             <subdiv-num> - number of subdivisions, default 3
% 
%          [-output-weights] - write the voxel weights for a vertex to a volume
%             file
%             <vertex> - the vertex number to get the voxel weights for, 0-based
%             <weights-out> - output - volume to write the weights to
% 
%          [-output-weights-text] - write the voxel weights for all vertices to a
%             text file
%             <text-out> - output - the output text filename
% 
%       [-myelin-style] - use the method from myelin mapping
%          <ribbon-roi> - an roi volume of the cortical ribbon for this
%             hemisphere
%          <thickness> - a metric file of cortical thickness
%          <sigma> - gaussian kernel in mm for weighting voxels within range
% 
%       [-subvol-select] - select a single subvolume to map
%          <subvol> - the subvolume number or name
% 
%       You must specify exactly one mapping method.  Enclosing voxel uses the
%       value from the voxel the vertex lies inside, while trilinear does a 3D
%       linear interpolation based on the voxels immediately on each side of the
%       vertex's position.
% 
%       The ribbon mapping method constructs a polyhedron from the vertex's
%       neighbors on each surface, and estimates the amount of this polyhedron's
%       volume that falls inside any nearby voxels, to use as the weights for
%       sampling.  The volume ROI is useful to exclude partial volume effects of
%       voxels the surfaces pass through, and will cause the mapping to ignore
%       voxels that don't have a positive value in the mask.  The subdivision
%       number specifies how it approximates the amount of the volume the
%       polyhedron intersects, by splitting each voxel into NxNxN pieces, and
%       checking whether the center of each piece is inside the polyhedron.  If
%       you have very large voxels, consider increasing this if you get zeros in
%       your output.
% 
%       The myelin style method uses part of the caret5 myelin mapping command to
%       do the mapping: for each surface vertex, take all voxels closer than the
%       thickness at the vertex that are within the ribbon ROI, and less than
%       half the thickness value away from the vertex along the direction of the
%       surface normal, and apply a gaussian kernel with the specified sigma to
%       them to get the weights to use.

if nargin==0
    [wb_cfg, nii_file, surf_file, gii_file, opts] = wb_map_nii2surf_test;
end

if nargin==4;opts = [];end
if isempty(opts);opts.method = '-enclosing';end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -volume-to-surface-mapping');

wb_cmd = [wb_function ' ' '"' nii_file '"' ' ' '"' surf_file '"' ' ' '"' gii_file '"' ' ' opts.method];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('file %s mapped on surface %s\nmethod: %s\n', nii_file, surf_file, opts.method)
else
    display(cmdout);
end

function [wb_cfg, nii_file, surf_file, gii_file, opts] = wb_map_nii2surf_test

opts            = [];
opts.method     = '-enclosing';

wb_cfg          = wb_parameters;
nii_file        = 'D:\Projects\RESPACT\Results\sl_analysis\with body parts with persons\group\ttest\onesampleT\smth0\onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_object_model.nii';
surf_file       = 'D:\Data\fmri\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.R.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
gii_file        = './test/onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_object_model.nii.R.func.gii';
