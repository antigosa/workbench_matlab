function wb_metric2label(metric_fname, roi_fname, scruct_type)
% THIS WORKS FOR ONE ROI PER FILE, FOR NOW

wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% Prepare a txt file for wb_command containing ROI info
fid=fopen('label_names.txt', 'w');
fprintf(fid, '%s\n1 255 0 0 1', roi_fname);
fclose all;

% Choose the structure
switch scruct_type
    case {'L', 'lh'}
        scruct_type = 'CORTEX_LEFT';
    case {'R', 'rh'}
        scruct_type = 'CORTEX_RIGHT';
end


% Write the label also as a label.gii file, so can be read by wb_view
system([wb_command ' -metric-label-import ' metric_fname ' label_names.txt ' roi_fname]);


% Set the structure
system([wb_command ' -set-structure ' roi_fname ' ' scruct_type]);

% Remove labels
delete('label_names.txt');

% Give feedback
fprintf('Label file: %s saved\n', roi_fname)