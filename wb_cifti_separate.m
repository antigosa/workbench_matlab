function [status,cmdout] = wb_cifti_separate(wb_cfg, cifti_in, direction, data_type, brain_struct, cifti_out)
% function [status,cmdout] = wb_cifti_separate(wb_cfg, cifti_in, direction, data_type, brain_struct, cifti_out)
% FROM: https://figshare.com/articles/HCP-MMP1_0_projected_on_fsaverage/3498446/2
% 
% e.g. wb_command -cifti-separate Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.dlabel.nii COLUMN -label CORTEX_LEFT Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.label.gii

% WRITE A CIFTI STRUCTURE AS METRIC, LABEL OR VOLUME
%    wb_command -cifti-separate
%       <cifti-in> - the cifti to separate a component of
%       <direction> - which direction to separate into components, ROW or COLUMN
% 
%       [-volume-all] - separate all volume structures into a volume file
%          <volume-out> - output - the output volume
% 
%          [-roi] - also output the roi of which voxels have data
%             <roi-out> - output - the roi output volume
% 
%          [-label] - output a volume label file indicating the location of
%             structures
%             <label-out> - output - the label output volume
% 
%          [-crop] - crop volume to the size of the data rather than using the
%             original volume size
% 
%       [-label] - repeatable - separate a surface model into a surface label
%          file
%          <structure> - the structure to output
%          <label-out> - output - the output label file
% 
%          [-roi] - also output the roi of which vertices have data
%             <roi-out> - output - the roi output metric
% 
%       [-metric] - repeatable - separate a surface model into a metric file
%          <structure> - the structure to output
%          <metric-out> - output - the output metric
% 
%          [-roi] - also output the roi of which vertices have data
%             <roi-out> - output - the roi output metric
% 
%       [-volume] - repeatable - separate a volume structure into a volume file
%          <structure> - the structure to output
%          <volume-out> - output - the output volume
% 
%          [-roi] - also output the roi of which voxels have data
%             <roi-out> - output - the roi output volume
% 
%          [-crop] - crop volume to the size of the component rather than using
%             the original volume size
% 
%       For dtseries, dscalar, and dlabel, use COLUMN for <direction>, and if you
%       have a symmetric dconn, COLUMN is more efficient.
% 
%       You must specify at least one of -metric, -volume-all, -volume, or -label
%       for this command to do anything.  Output volumes will spatially line up
%       with their original positions, whether or not they are cropped.
% 
%       For each <structure> argument, use one of the following strings:
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
    [wb_cfg, cifti_in, direction, data_type, brain_struct, cifti_out] = wb_cifti_separate_test;
end


% =========================================================================
% wb_command
% =========================================================================
wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-separate');


% =========================================================================
% command string
% =========================================================================
wb_cmd = [wb_function ' ' '"' cifti_in '"' ' ' '"' direction '"' ...
    ' ' '"' data_type '"' ' ' '"' brain_struct '"' ' ' '"' cifti_out '"' 
    ];


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-cifti-separate executed correclty %s\n', cifti_in)
else
    display(cmdout);
end

function [wb_cfg, cifti_in, direction, data_type, brain_struct, cifti_out] = wb_cifti_separate_test

cd('D:\Data\fmri\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k');
wb_cfg          = wb_parameters;
cifti_in        = './Q1-Q6_RelatedParcellation210.CorticalAreas_dil_Colors.32k_fs_LR.dlabel.nii';
direction       = 'COLUMN';
data_type       = '-label';
brain_struct    = 'CORTEX_LEFT';
cifti_out       = './Q1-Q6_RelatedParcellation210.CorticalAreas_dil_Colors.32k_fs_LR.label.gii';
