function [status,cmdout] = wb_cifti_create_label(wb_cfg, cifti_out, data_type, data_fname, roi_type, roi_fname)
% function [status,cmdout] = wb_cifti_separate(wb_cfg, cifti_out, data_type, data_fname, roi_type, roi_fname)
% 
% e.g. -cifti-create-label Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.dlabel.nii -left-label Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.label.gii -roi-left Q1-Q6_RelatedParcellation210.L.atlasroi.32k_fs_LR.shape.gii

% CREATE A CIFTI LABEL FILE
%    wb_command -cifti-create-label
%       <cifti-out> - output - the output cifti file
% 
%       [-volume] - volume component
%          <label-volume> - volume file containing the label data
%          <parcel-volume> - label volume file with cifti structure names to
%             define the volume parcels
% 
%       [-left-label] - label file for left surface
%          <label> - the label file
% 
%          [-roi-left] - roi of vertices to use from left surface
%             <roi-metric> - the ROI as a metric file
% 
%       [-right-label] - label for left surface
%          <label> - the label file
% 
%          [-roi-right] - roi of vertices to use from right surface
%             <roi-metric> - the ROI as a metric file
% 
%       [-cerebellum-label] - label for the cerebellum
%          <label> - the label file
% 
%          [-roi-cerebellum] - roi of vertices to use from right surface
%             <roi-metric> - the ROI as a metric file
% 
%       All input files must have the same number of columns/subvolumes.  Only
%       the specified components will be in the output cifti.  At least one
%       component must be specified.
% 
%       The -volume option of -cifti-create-label requires two volume arguments,
%       the label-volume argument contains all labels you want to display (e.g.
%       nuclei of the thalamus), whereas the parcel-volume argument includes all
%       CIFTI structures you want to include data within (e.g. THALAMUS_LEFT,
%       THALAMUS_RIGHT).  If you just want the labels in voxels to be the
%       structure names, you may use the same file for both arguments.  The
%       parcel-volume must use some of the label names from this list, all other
%       label names in the parcel-volume will be ignored:
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
    [wb_cfg, cifti_out, data_type, data_fname, roi_type, roi_fname] = wb_cifti_separate_test;
end


% =========================================================================
% wb_command
% =========================================================================
wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-create-label');


% =========================================================================
% command string
% =========================================================================
wb_cmd = [wb_function ' ' '"' cifti_out '"' ' ' '"' data_type '"' ' ' '"' data_fname '"' ' '...
    '"' roi_type '"' ' ' '"' roi_fname '"' 
    ];


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-cifti-separate executed correclty %s\n', cifti_out)
else
    display(cmdout);
end

function [wb_cfg, cifti_out, data_type, data_fname, roi_type, roi_fname] = wb_cifti_separate_test

cd('D:\Projects\2018\pRF_hands\Experiment\Exp1_estimating_hand_pRFs\bash_script\roi_HCPMMP1_subjectSpace\S101\label');
wb_cfg          = wb_parameters;
cifti_out       = 'lh.S102_HCPMMP1.annot.dlabel.nii';
data_type       = '-left-label';
data_fname      = 'lh.S102_HCPMMP1.annot.label.gii';
roi_type        = '-roi-left';
roi_fname       = 'lh.S102_HCPMMP1.annot.shape.gii';
