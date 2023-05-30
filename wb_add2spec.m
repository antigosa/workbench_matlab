function [status,cmdout] = wb_add2spec(spec_file, scruct_type, fname)
% function [status,cmdout] = wb_add2spec(spec_file, scruct_type, fname)
%
% scruct_type equal to either 'L' or 'lh' will be set to CORTEX_LEFT
% scruct_type equal to either 'R' or 'rh' will be set to CORTEX_RIGHT
% Othewise, use one of the option as listed below
%  
%       CORTEX_LEFT
%       CORTEX_RIGHT
%       CEREBELLUM
%       ACCUMBENS_LEFT
%       ACCUMBENS_RIGHT
%       ALL_GREY_MATTER
%       ALL_WHITE_MATTER
%       AMYGDALA_LEFT
%       AMYGDALA_RIGHT
%       BRAIN_STEM
%       CAUDATE_LEFT
%       CAUDATE_RIGHT
%       CEREBELLAR_WHITE_MATTER_LEFT
%       CEREBELLAR_WHITE_MATTER_RIGHT
%       CEREBELLUM_LEFT
%       CEREBELLUM_RIGHT
%       CEREBRAL_WHITE_MATTER_LEFT
%       CEREBRAL_WHITE_MATTER_RIGHT
%       CORTEX
%       DIENCEPHALON_VENTRAL_LEFT
%       DIENCEPHALON_VENTRAL_RIGHT
%       HIPPOCAMPUS_LEFT
%       HIPPOCAMPUS_RIGHT
%       INVALID
%       OTHER
%       OTHER_GREY_MATTER
%       OTHER_WHITE_MATTER
%       PALLIDUM_LEFT
%       PALLIDUM_RIGHT
%       PUTAMEN_LEFT
%       PUTAMEN_RIGHT
%       THALAMUS_LEFT
%       THALAMUS_RIGHT

if nargin==0
    [spec_file, scruct_type, fname] = wb_add2spec_test;
end

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

spec_folder = fileparts(spec_file);
if ~isempty(spec_folder) && ~exist(spec_folder, 'dir'); mkdir(spec_folder); end

% wb_function = strcat('"', wb_command, '"', ' -add-to-spec-file');
% 
% fname = strrep(fname, '\', '/');
% 
% wb_cmd = [wb_function ' ' '"' spec_file '"'   ' "' scruct_type '" ' '"' fname '"'];

wb_cmd=[wb_command ' -add-to-spec-file ' spec_file ' ' scruct_type ' ' fname];

[status,cmdout] = system(wb_cmd);
if status ~= 0
    display(cmdout)
else
    fprintf('file %s succesfully added to %s\n', fname, spec_file);
end

% fprintf('added file:\n\t%s');

function [spec_file, scruct_type, fname] = wb_add2spec_test

spec_file   = './test/test.spec';
scruct_type = 'CORTEX_LEFT';
fname       = './test/images_vs_rest_Tstat.nii.L.func.gii';