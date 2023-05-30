function [status,cmdout] = wb_surface_geodesic_distance(surface, vertex, metric_out, opt)
% function [status,cmdout] = wb_surface_geodesic_distance(surface, vertex, metric_out, opt)

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

if isnumeric(vertex);vertex=num2str(vertex);end

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -surface-geodesic-distance ' surface ' ' vertex ' ' metric_out];

if nargin>3
    if isfield(opt, 'limit')
        if isnumeric(opt.limit);opt.limit=num2str(opt.limit);end
        wb_cmd=[wb_cmd ' -limit ' opt.limit];
    end
end

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-surface-geodesic-distance executed correclty\n')
else
    display(cmdout);
end
