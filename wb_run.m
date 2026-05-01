function [status,cmdout] = wb_run(wbcommand_string)
% function [status,cmdout] = wb_run(wbcommand_string)
%
% This is just a wrapper for using any wb commands in Matlab. 

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;


wbcommand_string = strrep(wbcommand_string, 'wb_command', '');


wbcommand_string = [wb_command ' ' wbcommand_string];

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wbcommand_string);

% =========================================================================
% check output
% =========================================================================
if status ~= 0
    display(cmdout);
else
    fprintf('All good\n');
end