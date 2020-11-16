function [status,cmdout] = wb_volume_label2roi(wb_cfg, label_in, volume_out, label_name)

%% MAKE A VOLUME LABEL INTO AN ROI VOLUME
%    wb_command -volume-label-to-roi
%       <label-in> - the input volume label file
%       <volume-out> - output - the output volume file
% 
%       [-name] - select label by name
%          <label-name> - the label name that you want an roi of
% 
%       [-key] - select label by key
%          <label-key> - the label key that you want an roi of
% 
%       [-map] - select a single label map to use
%          <map> - the map number or name
% 
%       For each map in <label-in>, a map is created in <volume-out> where all
%       locations labeled with <label-name> or with a key of <label-key> are
%       given a value of 1, and all other locations are given 0.  Exactly one of
%       -name and -key must be specified.  Specify -map to use only one map from
%       <label-in>.

if nargin==0
    [wb_cfg, label_in, volume_out, label_name] = wb_volume_labe2roi_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -volume-label-to-roi');

% wb_cmd = [wb_function ' ' '"' expr '"' ' ' '"' variables '"' ' ' '"' metric_fname_out '"'];
wb_cmd = [wb_function ' ' '"' label_in '"' ' ' '"' volume_out '"' ' ' '-name' ' ' label_name];

[status,cmdout] = system(wb_cmd);
if status==0
    fprintf('expression %s applied correclty\n', label_in)
else
    display(cmdout);
end

function [wb_cfg, label_in, volume_out, label_name] = wb_volume_labe2roi_test

wb_cfg              = wb_parameters;
label_in    = './test/Q1-Q6_RelatedParcellation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii';
volume_out  = './test/onesampleT_Tstat_body_detail_model.nii';
label_name  = 'L_PHT_ROI';