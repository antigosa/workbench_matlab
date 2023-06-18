function [status,cmdout] = wb_cifti_label2roi(label_in, scalar_out, opt)

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -cifti-label-to-roi ' label_in ' ' scalar_out];

fn = cell2mat(fieldnames(opt));
wb_cmd=[wb_cmd ];

nlabels = length(opt.(fn));
for i = 1:nlabels
    wb_cmd=[wb_cmd ' -' fn ' ' opt.(fn){i}];
    
end


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
