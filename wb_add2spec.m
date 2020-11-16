function [status,cmdout] = wb_add2spec(wb_cfg, spec_file, scruct_type, fname)
% function [status,cmdout] = wb_add2spec(wb_cfg, spec_file, scruct_type, fname)
% %ADD A FILE TO A SPECIFICATION FILE
%    wb_command -add-to-spec-file
%       <specfile> - the specification file to add to
%       <structure> - the structure of the data file
%       <filename> - the path to the file
% 
%       The resulting spec file overwrites the existing spec file.  If the spec
%       file doesn't exist, it is created with default metadata.  The structure
%       argument must be one of the following:
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
    [wb_cfg, spec_file, scruct_type, fname] = wb_add2spec_test;
end

spec_folder = fileparts(spec_file);
if ~exist(spec_folder, 'file'); mkdir(spec_folder); end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -add-to-spec-file');

fname = strrep(fname, '\', '/');

wb_cmd = [wb_function ' ' '"' spec_file '"'   ' "' scruct_type '" ' '"' fname '"'];

[status,cmdout] = system(wb_cmd);
if status ~= 0
    display(cmdout)
else
    fprintf('file %s succesfully added to %s\n', fname, spec_file);
end

% fprintf('added file:\n\t%s');

function [wb_cfg, spec_file, scruct_type, fname] = wb_add2spec_test

wb_cfg      = wb_parameters;
spec_file   = './test/test.spec';
scruct_type = 'CORTEX_LEFT';
fname       = './test/images_vs_rest_Tstat.nii.L.func.gii';