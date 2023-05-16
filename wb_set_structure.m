function wb_set_structure(data_fname, scruct_type)
% function wb_set_structure(data_fname, scruct_type)

% scruct_type equal to either 'L' or 'lh' will be set to CORTEX_LEFT
% scruct_type equal to either 'R' or 'rh' will be set to CORTEX_RIGHT
% Othewise, use one of the option as listed in wb


wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% Choose the structure
switch scruct_type
    case {'L', 'lh'}
        scruct_type = 'CORTEX_LEFT';
    case {'R', 'rh'}
        scruct_type = 'CORTEX_RIGHT';        
    otherwise        
end

system([wb_command ' -set-structure ' data_fname ' ' scruct_type]);

% Give feedback
fprintf('Structure set for file: %s saved\n', data_fname)