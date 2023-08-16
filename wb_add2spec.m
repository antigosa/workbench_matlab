function [status,cmdout] = wb_add2spec(spec_file, scruct_type, fname)
% function [status,cmdout] = wb_add2spec(spec_file, scruct_type, fname)


% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% Options
% =========================================================================

if isempty(scruct_type); scruct_type='';end

switch scruct_type
    case {'L', 'lh', 'CORTEX_LEFT'}
        scruct_type = 'CORTEX_LEFT';
    case {'R', 'rh', 'CORTEX_RIGHT'}
        scruct_type = 'CORTEX_RIGHT';
    otherwise
        scruct_type = 'OTHER';
end

spec_folder = fileparts(spec_file);
if ~isempty(spec_folder) && ~exist(spec_folder, 'dir'); mkdir(spec_folder); end

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -add-to-spec-file ' spec_file ' ' scruct_type ' ' fname];

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
    fprintf('file %s succesfully added to %s\n', fname, spec_file);
end
