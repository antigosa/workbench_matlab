function [status,cmdout] = wb_cifti_find_clusters(cifti_fname, surf_struct, surf_val_thrsh, surf_min_area, vol_val_threshold, vol_min_size, label_out) 
% 
% 
% wb_command -cifti-find-clusters \
%    <input_scalar_cifti_file.dscalar.nii> \
%    <surface_value_threshold> \
%    <surface_minimum_area> \
%    <volume_value_threshold> \
%    <volume_minimum_size> \
%    <output_cluster_labels.dlabel.nii> \
%    -spec-file <left_surface_file.surf.gii> <right_surface_file.surf.gii> \
%    -roi <optional_roi_cifti.dscalar.nii> \
%    <optional_arguments>

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=['"' wb_command '" -cifti-find-clusters "' cifti_fname '"' ' -left-surface "' surf_struct.lh '" -right-surface "' surf_struct.rh '"'];

wb_cmd=[wb_cmd ' ' ];

