function [status,cmdout] = wb_surface_closest_vertex(surface, coord_list_file, vertex_list_out)
% function [status,cmdout] = wb_surface_closest_vertex(surface, coord_list_file, vertex_list_out)
% 
% DO NOT USE A FLAT SURFACE

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -surface-closest-vertex ' surface ' ' coord_list_file ' ' vertex_list_out];

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
