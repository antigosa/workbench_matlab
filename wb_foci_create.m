function [status,cmdout] = wb_foci_create(foci_out, foci_fn, surface_fn)
% function [status,cmdout] = wb_foci_create(foci_out, foci_fn, surface_fn)


% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -foci-create ' foci_out];

fn = fieldnames(foci_fn);
nclasses = length(fn);
for i = 1:nclasses
    wb_cmd=[wb_cmd ' -class ' fn{i} ' ' foci_fn.(fn{i}) ' ' surface_fn];
end


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if status ~= 0
    display(cmdout)
else
    fprintf('foci file %s succesfully created\n', foci_out);
end