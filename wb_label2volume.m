function [status,cmdout] = wb_label2volume(label_in, surf_file, volume_space, volume_out)

%% MAP LABEL FILE TO VOLUME
%    wb_command -label-to-volume-mapping
%       <label> - the input label file
%       <surface> - the surface to use coordinates from
%       <volume-space> - a volume file in the desired output volume space
%       <volume-out> - output - the output volume file
% 
%       [-nearest-vertex] - use the label from the vertex closest to the voxel
%          center
%          <distance> - how far from the surface to map labels to voxels, in mm
% 
%       [-ribbon-constrained] - use ribbon constrained mapping algorithm
%          <inner-surf> - the inner surface of the ribbon
%          <outer-surf> - the outer surface of the ribbon
% 
%          [-voxel-subdiv] - voxel divisions while estimating voxel weights
%             <subdiv-num> - number of subdivisions, default 3
% 
%       Maps labels from a gifti label file into a volume file.  You must specify
%       exactly one mapping method option.  The -nearest-vertex method uses the
%       label from the vertex closest to the voxel center.  The
%       -ribbon-constrained method uses the same method as in
%       -volume-to-surface-mapping, then uses the weights in reverse, with
%       popularity logic to decide on a label to use.  

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -label-to-volume-mapping -nearest-vertex 5 ' label_in ' ' surf_file ' ' volume_space ' ' volume_out];


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if status==0
    fprintf('expression %s applied correclty\n', label_in)
else
    display(cmdout);
end

function [wb_cfg, label_in, surf_file, volume_space, volume_out] = wb_label2volume_test

label_in        = './test/Q1-Q6_RelatedParcellation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii';
surf_file       = 'D:\Data\fmri\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.R.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';

label_name      = 'L_PHT_ROI';
volume_space    = './test/onesampleT_Tstat_body_detail_model.nii';
volume_out      = sprintf('./test/test.nii');
