function [status,cmdout] = wb_create_cifti(wb_cfg, cifti_out, metric_struct, map_names_txt, volume_cell)
% function [status,cmdout] = wb_create_cifti(wb_cfg, cifti_out, metric_struct, map_names_txt, volume_cell)
% CREATE A CIFTI DENSE SCALAR FILE
%    wb_command -cifti-create-dense-scalar
%       <cifti-out> - output - the output cifti file
% 
%       [-volume] - volume component
%          <volume-data> - volume file containing all voxel data for all volume
%             structures
%          <label-volume> - label volume file containing labels for cifti
%             structures
% 
%       [-left-metric] - metric for left surface
%          <metric> - the metric file
% 
%          [-roi-left] - roi of vertices to use from left surface
%             <roi-metric> - the ROI as a metric file
% 
%       [-right-metric] - metric for left surface
%          <metric> - the metric file
% 
%          [-roi-right] - roi of vertices to use from right surface
%             <roi-metric> - the ROI as a metric file
% 
%       [-cerebellum-metric] - metric for the cerebellum
%          <metric> - the metric file
% 
%          [-roi-cerebellum] - roi of vertices to use from right surface
%             <roi-metric> - the ROI as a metric file
% 
%       [-name-file] - use a text file to set all map names
%          <file> - text file containing map names, one per line
% 
%       All input files must have the same number of columns/subvolumes.  Only
%       the specified components will be in the output cifti.  Map names will be
%       taken from one of the input files.  At least one component must be
%       specified.  The label volume should have some of the label names from
%       this list, all other label names will be ignored:
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
    % NOT WORKING!!
    [wb_cfg, cifti_out, metric_struct, map_names_txt, volume_cell] = wb_create_cifti_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-create-dense-scalar');

cifti_out = strrep(cifti_out, '\', '/');


wb_cmd_main = [wb_function ' ' cifti_out]; 

wb_cmd = [wb_cmd_main];

if isfield(metric_struct, 'lh')
    wb_cmd = [wb_cmd ' ' '-left-metric ' '"' metric_struct.lh '"'];
end
if isfield(metric_struct, 'rh')
    wb_cmd = [wb_cmd ' ' '-right-metric ' '"' metric_struct.rh '"'];
end

wb_cmd = [wb_cmd ' ' '-name-file ' '"' map_names_txt '"'];

if exist('volume_cell', 'var')
    wb_cmd = [wb_cmd ' ' '-volume ' '"' volume_cell{1} '"' ' ' '"' volume_cell{2} '"'];
end


[status,cmdout] = system(wb_cmd);
if status ~= 0
    display(cmdout);
else
    fprintf('created cifti %s succesfully\n', cifti_out);
end

% fprintf('added file:\n\t%s');

function [wb_cfg, cifti_out, metric_struct, map_names_txt, volume_cell] = wb_create_cifti_test

wb_cfg          = wb_parameters;
cifti_out       = './test/test.spec';
metric_struct   = 'CORTEX_LEFT';
map_names_txt   = './test/images_vs_rest_Tstat.nii.L.func.gii';
volume_cell     = [];