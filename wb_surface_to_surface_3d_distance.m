function [status,cmdout] = wb_surface_to_surface_3d_distance(surface_comp, surface_ref, dists_out)
% function [status,cmdout] = wb_surface_to_surface_3d_distance(surface_comp, surface_ref, dists_out)
% 
% DO NOT USE A FLAT SURFACE
%
% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -surface-to-surface-3d-distance ' surface_comp ' ' surface_ref ' ' dists_out];

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-surface-closest-vertex executed correclty\n')
else
    display(cmdout);
end